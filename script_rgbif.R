#####################################################################
#         ROTINA PARA BAIXAR DADOS DE OCORRÊNCIA DO GBIF E          # 
#         CONFERENCIA DE SINÔNIMOS NO SITE DO FLORA 2020            #
#####################################################################

#instalando pacotes, se for necessário
packages = c("dismo", "raster", "maptools", "flora", "devtools", 'xlsx', "beepr")
for (p in setdiff(packages, installed.packages()[, "Package"])) { install.packages(p, dependencies = T)}

library(flora)
library(raster)

#-------------------------#
        #NATIVAS
#-------------------------#

#importando lista de espécies
lista.nat = xlsx::read.xlsx("Lista_de_espécies.xlsx", sheetIndex = 1, encoding = "UTF-8")
lista.nat[,1] = as.vector(lista.nat[,1])

#verificando o início e o final do objeto
head(lista.nat)
tail(lista.nat)

#removendo o nome do autor da espécie
for(i in 1:dim(lista.nat)[1]){
  lista.nat[i,1] = remove.authors(lista.nat[i,1])
}

#verificando o início do objeto
head(lista.nat)

#conferindo no Flora 2020
lista.flora2020=flora::get.taxa(lista.nat$Species)
head(lista.flora2020)

#salvando um csv
write.table(lista.flora2020, 'lista_flora2020.csv', sep = ";", row.names = F)

#quantas ameaçadas?
table(lista.flora2020$threat.status)

#quantas espécies são sinônimos e quantas não foram encontradas no FLora2020?
table(lista.flora2020$notes)

#quais são as não encontradas?
lista.flora2020[lista.flora2020$notes == "not found",]

#quais são os sinônimos?
lista.flora2020[lista.flora2020$notes == "replaced synonym",]

#gerando objeto para armazenar os registros
occ = c()
occ1 = data.frame(NA)
occ1$data = NA
#loop para baixar os registros em um única tabela
#incluí os nomes aceitos 
for(i in 1:dim(lista.flora2020)[1]){
  cat("sp", i, "\n")
  
  ini = Sys.time()
  
  #baixar dados de ocorrência do GBIF pelo pacote dismo
  if (lista.flora2020$notes[i] == "not found") {
    species = rgbif::occ_data(
      scientificName = lista.flora2020$original.search[i],
      limit = 200000,
      hasCoordinate = T,
      hasGeospatialIssue = F
    )
    species = as.data.frame(species$data)
  } else{
    species = rgbif::occ_data(
      scientificName = lista.flora2020$search.str[i],
      limit = 200000,
      hasCoordinate = T,
      hasGeospatialIssue = F
    )
    species = as.data.frame(species$data)
  }
  
  
  #pula a espécie que não possui registros com coordenadas
  if(is.null(species$decimalLongitude)) {
    cat(paste(lista.flora2020$original.search[i], "não possui registros com coordenadas \n"))
    occ1 = rbind(occ1, c(lista.flora2020$original.search[i],"não possui registros com coordenadas"))
    next}
  
  #pula a espécie com menos de 10 registros
  # if(dim(species)[1]<10) {
  #   cat(paste(lista.flora2020$original.search[i], "possui menos de 10 registros \n"))
  #   occ1 = rbind(occ1, c(lista.flora2020$original.search[i],"possui menos de 10 registros"))
  #   next}
  
  if(is.null(species$municipality)){
    #cat(paste(lista.flora2020$original.search[i], "não possui nomes de município \n"))
    #occ1 = rbind(occ1, c(lista.flora2020$original.search[i],"não possui nomes de município"))
    species$municipality = NA}
  if(is.null(species$identifiedBy)){
    #cat(paste(lista.flora2020$original.search[i], "não possui nome de quem identificou \n"))
    #occ1 = rbind(occ1, c(lista.flora2020$original.search[i], "não possui nome de quem identificou"))
    species$identifiedBy = NA}
  
  #selecionando as colunas de interesse
  species.sel=species[,c("name","decimalLongitude","decimalLatitude", "year", "identifier", "recordedBy","recordNumber","catalogNumber","collectionCode","institutionCode", "municipality","stateProvince","country", "protocol")]
  species.sel$source = "GBIF"
  #excluíndo os registros que não tem longitude e latitude
  #species.sel=na.exclude(species.sel)
  
  #criando a lista
  occ = rbind(occ, species.sel)
  
  if (i == dim(lista.flora2020)[1]) {
    final = Sys.time()
    cat("Time: \n")
    print(round(difftime(final, ini, units = 'mins'),2))
    
    if(round(difftime(final, ini, units = 'mins'),2)>5){beepr::beep(3)}
  }
}

#número de espécies que baixou os registros
length(unique(occ$name))

occ1

#número de registros com coordenadas por espécie
table(occ$name)

#salvando um csv
write.table(table(occ1[-1,]), 'sp_sem_registro_nativas.csv', sep = ";", row.names = F)
#salvando um csv
write.table(table(occ$name), 'numero de ocorrencias_nativas.csv', sep = ";", row.names = F)

#visualizando os 10 primeiro registros
head(occ,10)

#plotando os registros para visualização
data(wrld_simpl, package = "maptools")
occ1=occ
sp::coordinates(occ1)  =~decimalLongitude+decimalLatitude
raster::plot(occ1, col = 'red', pch = 19, cex = 0.8);raster::plot(wrld_simpl, add = T)

#salvando um csv com os registros baixados
write.table(occ, 'ocorrencias_nativas.csv', sep = ";", row.names = F)


#-----------------------------------------------------------------#

#lendo a tabela salva
occ = read.table("ocorrencias_nativas.csv", sep = ";", h = T)

#plotando os registros para visualização
data(wrld_simpl, package = "maptools")
occ1=occ
sp::coordinates(occ1)  =~lon+lat
raster::plot(occ1, col = 'red', pch = 19, cex = 0.8);raster::plot(wrld_simpl, add = T)


#-------------------------#
        #INVASORAS
#-------------------------#

#importando lista de espécies
lista.nat = xlsx::read.xlsx("Lista_de_espécies.xlsx", sheetIndex = 4, encoding = "UTF-8")
lista.nat[,1] = as.vector(lista.nat[,1])

#verificando o início e o final do objeto
head(lista.nat)
tail(lista.nat)

#verificando o início do objeto
head(lista.nat)

#conferindo no Flora 2020
lista.flora2020=flora::get.taxa(lista.nat$Spp..Inv.)
head(lista.flora2020)

#salvando um csv
write.table(lista.flora2020, 'lista_flora2020_inv.csv', sep = ";", row.names = F)

#quantas ameaçadas?
table(lista.flora2020$threat.status)

#quantas espécies são sinônimos e quantas não foram encontradas no FLora2020?
table(lista.flora2020$notes)

#quais são as não encontradas?
lista.flora2020[lista.flora2020$notes == "not found",]

#quais são os sinônimos?
lista.flora2020[lista.flora2020$notes == "replaced synonym",]

#gerando objeto para armazenar os registros
occ = c()
occ1 = data.frame(NA)
occ1$data = NA
#loop para baixar os registros em um única tabela
#incluí os nomes aceitos 
for(i in 1:dim(lista.flora2020)[1]){
  cat("sp", i, "\n")
  
  ini = Sys.time()
  
  #baixar dados de ocorrência do GBIF pelo pacote dismo
  if (lista.flora2020$notes[i] == "not found") {
    species = rgbif::occ_data(
      scientificName = lista.flora2020$original.search[i],
      limit = 200000,
      hasCoordinate = T,
      hasGeospatialIssue = F
    )
    species = as.data.frame(species$data)
  } else{
    species = rgbif::occ_data(
      scientificName = lista.flora2020$search.str[i],
      limit = 200000,
      hasCoordinate = T,
      hasGeospatialIssue = F
    )
    species = as.data.frame(species$data)
  }
  
  
  #pula a espécie que não possui registros com coordenadas
  if(is.null(species$decimalLongitude)) {
    cat(paste(lista.flora2020$original.search[i], "não possui registros com coordenadas \n"))
    occ1 = rbind(occ1, c(lista.flora2020$original.search[i],"não possui registros com coordenadas"))
    next}
  
  #pula a espécie com menos de 10 registros
  # if(dim(species)[1]<10) {
  #   cat(paste(lista.flora2020$original.search[i], "possui menos de 10 registros \n"))
  #   occ1 = rbind(occ1, c(lista.flora2020$original.search[i],"possui menos de 10 registros"))
  #   next}
  
  if(is.null(species$municipality)){
    #cat(paste(lista.flora2020$original.search[i], "não possui nomes de município \n"))
    #occ1 = rbind(occ1, c(lista.flora2020$original.search[i],"não possui nomes de município"))
    species$municipality = NA}
  if(is.null(species$identifiedBy)){
    #cat(paste(lista.flora2020$original.search[i], "não possui nome de quem identificou \n"))
    #occ1 = rbind(occ1, c(lista.flora2020$original.search[i], "não possui nome de quem identificou"))
    species$identifiedBy = NA}
  
  #selecionando as colunas de interesse
  species.sel=species[,c("name","decimalLongitude","decimalLatitude", "year", "identifier", "recordedBy","recordNumber","catalogNumber","collectionCode","institutionCode", "municipality","stateProvince","country", "protocol")]
  species.sel$source = "GBIF"
  #excluíndo os registros que não tem longitude e latitude
  #species.sel=na.exclude(species.sel)
  
  #criando a lista
  occ = rbind(occ, species.sel)
  
  if (i == dim(lista.flora2020)[1]) {
    final = Sys.time()
    cat("Time: \n")
    print(round(difftime(final, ini, units = 'mins'),2))
    
    if(round(difftime(final, ini, units = 'mins'),2)>5){beepr::beep(3)}
  }
}

#número de espécies que baixou os registros
length(unique(occ$species))

#número de registros com coordenadas por espécie
table(occ$species)

#salvando um csv
write.table(table(occ$species), 'numero de ocorrencias_inv.csv', sep = ";", row.names = F)

#visualizando os 10 primeiro registros
head(occ,10)

#plotando os registros para visualização
data(wrld_simpl, package = "maptools")
occ1=occ
sp::coordinates(occ1)  =~lon+lat
raster::plot(occ1, col = 'red', pch = 19, cex = 0.8);raster::plot(wrld_simpl, add = T)

#salvando um csv com os registros baixados
write.table(occ, 'ocorrencias_invasoras.csv', sep = ";", row.names = F)
#-----------------------------------------------------------------#

#lendo a tabela salva
occ = read.table("ocorrencias_invasoras.csv", sep = ";", h = T)

#plotando os registros para visualização
data(wrld_simpl, package = "maptools")
occ1=occ
sp::coordinates(occ1)  =~lon+lat
raster::plot(occ1, col = 'red', pch = 19, cex = 0.8);raster::plot(wrld_simpl, add = T)

