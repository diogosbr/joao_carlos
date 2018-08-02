# vai retirar ??? ####



###############################
# Converter em mapas binários #
###############################
projections.binary.CTA.mean <-
  BinaryTransformation(projections.CTA.mean, th_CTA) #Calcular th
class(projections.binary.CTA.mean)
summary(values(projections.binary.CTA.mean))
#plot(projections.binary.CTA.mean, col = matlab.like(100), main = "Current Climate_CTA", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.CTA.mean,
  filename = paste0("./output/", especie, "Current Climate_CTA - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.GBM.mean <-
  BinaryTransformation(projections.GBM.mean, th_GBM) #Calcular th
class(projections.binary.GBM.mean)
summary(values(projections.binary.GBM.mean))
#plot(projections.binary.GBM.mean, col = matlab.like(100), main = "Current Climate_GBM", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.GBM.mean,
  filename = paste0("./output/", especie, "Current Climate_GBM - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.RF.mean <-
  BinaryTransformation(projections.RF.mean, th_RF) #Calcular th
class(projections.binary.RF.mean)
summary(values(projections.binary.RF.mean))
#plot(projections.binary.RF.mean, col = matlab.like(100), main = "Current Climate_RF", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.RF.mean,
  filename = paste0("./output/", especie, "Current Climate_RF - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.ANN.mean <-
  BinaryTransformation(projections.ANN.mean, th_ANN) #Calcular th
class(projections.binary.ANN.mean)
summary(values(projections.binary.ANN.mean))
#plot(projections.binary.ANN.mean, col = matlab.like(100), main = "Current Climate_ANN", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.ANN.mean,
  filename = paste0("./output/", especie, "Current Climate_ANN - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.FDA.mean <-
  BinaryTransformation(projections.FDA.mean, th_FDA) #Calcular th
class(projections.binary.FDA.mean)
summary(values(projections.binary.FDA.mean))
#plot(projections.binary.FDA.mean, col = matlab.like(100), main = "Current Climate_FDA", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.FDA.mean,
  filename = paste0("./output/", especie, "Current Climate_FDA - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.GAM.mean <-
  BinaryTransformation(projections.GAM.mean, th_GAM) #Calcular th
class(projections.binary.GAM.mean)
summary(values(projections.binary.GAM.mean))
#plot(projections.binary.GAM.mean, col = matlab.like(100), main = "Current Climate_GAM", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.GAM.mean,
  filename = paste0("./output/", especie, "Current Climate_GAM - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.GLM.mean <-
  BinaryTransformation(projections.GLM.mean, th_GLM) #Calcular th
class(projections.binary.GLM.mean)
summary(values(projections.binary.GLM.mean))
#plot(projections.binary.GAM.mean, col = matlab.like(100), main = "Current Climate_GLM", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.GLM.mean,
  filename = paste0("./output/", especie, "Current Climate_GLM - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.MARS.mean <-
  BinaryTransformation(projections.MARS.mean, th_MARS) #Calcular th
class(projections.binary.MARS.mean)
summary(values(projections.binary.MARS.mean))
#plot(projections.binary.MARS.mean, col = matlab.like(100), main = "Current Climate_MARS", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.MARS.mean,
  filename = paste0("./output/", especie, "Current Climate_MARS - BINARY.tif"),
  formato = "GTiff"
)

projections.binary.MAXENT.Phillips.mean <-
  BinaryTransformation(projections.MAXENT.Phillips.mean, th_MAXENT.Phillips) #Calcular th
class(projections.binary.MAXENT.Phillips.mean)
summary(values(projections.binary.MAXENT.Phillips.mean))
#plot(projections.binary.MAXENT.Phillips.mean, col = matlab.like(100), main = "Current Climate_MAXENT.Phillips", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.MAXENT.Phillips.mean,
  filename = paste0(
    "./output/",
    especie,
    "Current Climate_MAXENT.Phillips - BINARY.tif"
  ),
  formato = "GTiff"
)

projections.binary.SRE.mean <-
  BinaryTransformation(projections.SRE.mean, th_SRE) #Calcular th
class(projections.binary.SRE.mean)
summary(values(projections.binary.SRE.mean))
#plot(projections.binary.SRE.mean, col = matlab.like(100), main = "Current Climate_SRE", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.binary.SRE.mean,
  filename = paste0("./output/", especie, "Current Climate_SRE - BINARY.tif"),
  formato = "GTiff"
)



########################################
# Consenso entre as Projeções Binárias #
########################################

# Mapa de consenso: binário médio
projections.all.mean_bin1 <-
  mean(
    projections.binary.RF.mean + projections.binary.GBM.mean + projections.binary.CTA.mean +
      projections.binary.GLM.mean + projections.binary.GAM.mean + projections.binary.ANN.mean +
      projections.binary.SRE.mean + projections.binary.MARS.mean + projections.binary.FDA.mean + projections.binary.MAXENT.Phillips.mean
  )
#windows(w=6, h=6)
#plot(projections.all.mean_bin, col = matlab.like(100), main = "Binary Ensemble - Current Climate", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.all.mean_bin,
  filename = paste0(
    "./output/",
    especie,
    "Ensemble - Current Climate - mean binary.tif"
  ),
  format = "GTiff",
  overwrite = TRUE
)

# Mapa de consenso: binário final
projections.all.mean_bin2 <-
  BinaryTransformation(projections.all.mean, th_mean) #Calcular th
#windows(w=6, h=6)
#plot(projections.all.mean_bin, col = matlab.like(100), main = "Binary Ensemble - Current Climate", las = 1)
#plot(domains, add = TRUE, col="transparent", border="white", lwd = 0.5)
writeRaster(
  projections.all.mean_bin,
  filename = paste0(
    "./output/",
    especie,
    "Ensemble - Current Climate - final binary.tif"
  ),
  format = "GTiff",
  overwrite = TRUE
)

#ATÉ AQUI - Vai retirar ????####