install.packages("devtools")
require(devtools)

install_github("narayanibarve/ENMGadgets", dep = T)
require(ENMGadgets)
library(raster) 
library(maptools) 
library(sqldf)
library(fields)
library(rgdal) 
library(dismo)

if (dir.exists("PCA") == F) {
  dir.create("PCA")
}

bio.crop <- list.files("./Environmental layers/CHELSA-WD", full.names=TRUE, pattern=".tif")
bio.crop
names(bio.crop)
res(bio.crop)

# Checando bio.crop
bio.crop 


bio50.85_MC <-  list.files("./Environmental Layers/CHELSA_Future-WD/MIROC5", pattern = ".asc", full.names = TRUE)
bio50.85_MC

# Criar as projeções
pcaop = PCAProjection(BioStackFiles = bio.crop, LoadingFile = "joao", CompImpFile = "pca1",
                      ProjectonStackFiles = bio50.85_MC, OutputFolder = "./PCA")
