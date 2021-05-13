#------------------------------------------------------------------------------------------------#
# Download and visualize GEDI data
# 6-2-20
#------------------------------------------------------------------------------------------------#
# Google Search: "gedi processing github"
# https://github.com/carlos-alberto-silva/rGEDI
#------------------------------------------------------------------------------------------------#
setwd("G:/My Drive/") # Google Drive
#------------------------------------------------------------------------------------------------#
# Set output dir for downloading and reading files
outdir="G:/My Drive/GEDI/Data"
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

#------------------------------------------------------------------------------------------------#
# The CRAN version:
# install.packages("rGEDI")
#------------------------------------------------------------------------------------------------#
## The development version:
# library(devtools)
# devtools::install_github("carlos-alberto-silva/rGEDI", dependencies = TRUE)
#------------------------------------------------------------------------------------------------#
# loading rGEDI package
library(rGEDI)
#------------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
#         Use GEDI Finder tool to identify GEDI data available in specific locations             #
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# Harvard Forest Bounding Box
# bbox = 42.557,-72.259,42.433,-72.134
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
# CA Southern Sierra Bounding Box
#	Small bbox = 37.13, -119.81, 37.01, -118.90
#	Large bbox = 38.03, -119.79, 36.65, -118.90 (-118.93)
#	Increased width of large bbox slightly to include all of smaller bbox
#------------------------------------------------------------------------------------------------# 

# Study area boundary box coordinates
ul_lat<-  38.03
lr_lat<-  36.65
ul_lon<- -119.79
lr_lon<- -118.90

# Specifying the date range
daterange=c("2019-01-01","2020-06-02") # year-month-day

# Get path to GEDI data
# gLevel1B<-gedifinder(product="GEDI01_B",ul_lat, ul_lon, lr_lat, lr_lon,version="001",daterange=daterange)
# gLevel2A<-gedifinder(product="GEDI02_A",ul_lat, ul_lon, lr_lat, lr_lon,version="001",daterange=daterange)
gLevel2B<-gedifinder(product="GEDI02_B",ul_lat, ul_lon, lr_lat, lr_lon,version="001",daterange=daterange)
#------------------------------------------------------------------------------------------------#

#gLevel2A <- gLevel2A[c(9,12,35)]
gLevel2B <- gLevel2B[c(9,12,35)]
#------------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------------#
#                                 Downloading the data                                           #
#------------------------------------------------------------------------------------------------#
# Downloading GEDI data
gediDownload(filepath=gLevel1B,outdir=outdir)
gediDownload(filepath=gLevel2A,outdir=outdir)
gediDownload(filepath=gLevel2B,outdir=outdir)

#------------------------------------------------------------------------------------------------#
#                                       Read GEDI data                                           #
#------------------------------------------------------------------------------------------------#
# gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,"\\GEDI01_B_2019108080338_O01964_T05337_02_003_01_sub.h5"))
# gedilevel2a<-readLevel2A(level2Apath = paste0(outdir,"\\GEDI02_A_2019108080338_O01964_T05337_02_001_01_sub.h5"))
# gedilevel2b<-readLevel2B(level2Bpath = paste0(outdir,"\\GEDI02_B_2019108080338_O01964_T05337_02_001_01_sub.h5"))

#file_name <- paste0("/examples","\\GEDI01_B_2019108080338_O01964_T05337_02_003_01_sub.h5")
file_name <- "\\GEDI01_B_2019246121050_O04109_T04380_02_003_01.h5"

gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))

#------------------------------------------------------------------------------------------------#
#                                      Get pulse location                                        #
#------------------------------------------------------------------------------------------------#
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0"))
# level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("latitude_bin0"))
# level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("longitude_bin0"))
head(level1bGeo)

#edit(getLevel1BGeo)

# Converting shot_number as "integer64" to "character"
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)

# Converting level1bGeo as data.table to SpatialPointsDataFrame
library(sp)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)

# Exporting level1bGeo as ESRI Shapefile
# raster::shapefile(level1bGeo_spdf,paste0(outdir,"/examples","\\GEDI01_B_2019108080338_O01964_T05337_02_003_01_sub"))
raster::shapefile(level1bGeo_spdf,paste0(outdir,"shapefiles",file_name))

# install.packages("leaflet")
# install.packages("leafsync")
# 
# library(leaflet)
# library(leafsync)
# 
# leaflet() %>%
#   addCircleMarkers(level1bGeo$longitude_bin0,
#                    level1bGeo$latitude_bin0,
#                    radius = 1,
#                    opacity = 1,
#                    color = "red")  %>%
#   addScaleBar(options = list(imperial = FALSE)) %>%
#   addProviderTiles(providers$Esri.WorldImagery) %>%
#   addLegend(colors = "red", labels= "Samples",title ="GEDI Level1B")


#------------------------------------------------------------------------------------------------#
#                        load data, get pulse location, save as shapefile                        #
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           1                                              #
#------------------------------------------------------------------------------------------#
#----- Leave this as the first command, this will reset your R session. -------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
#------------------------------------------------------------------------------------------#
library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019265014402_O04397_T01226_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#
dim(level1bGeo_spdf)

#------------------------------------------------------------------------------------------#
#                                           2                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019261032101_O04336_T04883_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           3                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019260101949_O04325_T01062_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           4                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019256115713_O04264_T03143_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           5                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019257045811_O04275_T00002_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           6                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019209000122_O03527_T04730_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           7                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019219024757_O03684_T04260_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           8                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019219194832_O03695_T03965_02_003_01.h5" # size on comp = 8,422,903
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                           9                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019223010729_O03745_T03908_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          10                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019252133529_O04203_T05377_02_003_01.h5" 
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          11                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019242104318_O04046_T02343_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          12                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019223180803_O03756_T03613_02_003_01.h5" 
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          13                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019241174219_O04035_T02791_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          14                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019128143946_O02279_T04719_02_003_01.h5" 
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          15                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019178184725_O03058_T04413_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          16                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019179114752_O03069_T02695_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          17                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019182170610_O03119_T04061_02_003_01.h5" 
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          18                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019198041357_O03359_T05495_02_003_01.h5" 
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------#
#                                          19                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019204084105_O03455_T01108_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          20                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019194055411_O03298_T00155_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          21                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019193125333_O03287_T02026_02_003_01.h5" 
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          22                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019183100636_O03130_T05189_02_003_01.h5"
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          23                                              #
# #------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019168160242_O02901_T03001_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
# #------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          24                                              #
# #------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019167230214_O02890_T03296_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
# #------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          25                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019157201716_O02733_T03460_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          26                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019157031646_O02722_T03755_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          27                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019153045741_O02661_T01261_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name, overwrite=TRUE))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          28                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019147003131_O02565_T02649_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          29                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019143021311_O02504_T01425_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          30                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019157201716_O02733_T03460_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          31                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019142091342_O02493_T01567_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
#                                          32                                              #
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()

library(sp); library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
file_name <- "\\GEDI01_B_2019135115649_O02386_T01720_02_003_01.h5" # WHEN FULLY DOWNLOADED
gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)
level1bGeo$shot_number<-paste0(level1bGeo$shot_number)
#level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....
level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)
raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))
#------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------#
#                             Upload only shapefiles & plot                                #
#------------------------------------------------------------------------------------------#
setwd("G:/My Drive/GEDI/")

library(raster); library(rgdal); library(sp)
library(reshape2); library(dplyr); library(rgeos)
library(sf)
#https://stackoverflow.com/questions/13982773/crop-for-spatialpolygonsdataframe
#https://www.rdocumentation.org/packages/rgeos/versions/0.5-2/topics/gIntersection

# load Harvard Forest bounding box
#hf <- readOGR(dsn="G:/My Drive/GEDI", layer="HF_bb"); plot(hf)

# load CA Southern Sierra bounding box - large
ca_large <- readOGR(dsn="G:/My Drive/GEDI/", layer="CA_large_bb"); plot(ca_large)

# # load CA Southern Sierra bounding box - large
# ca_small <- readOGR(dsn="shapefiles", layer="CA_small_bb"); plot(ca_small)
#------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------#
# try loading just shapefiles, combining, & plotting on map
#------------------------------------------------------------------------------------------#
#file_name <- "GEDI01_B_2019213012634_O03590_T04227_02_003_01" 
#file_name <- "GEDI01_B_2019261032101_O04336_T04883_02_003_01" 
file_name <- "" 

#test <- readOGR(dsn="Data/CA_large_bb_data/shapefiles", layer="GEDI01_B_2019265014402_O04397_T01226_02_003_01"); plot(test)
test <- readOGR(dsn="Data/CA_large_bb_data/shapefiles", layer=file_name) #; plot(test)

## Create the clipping polygon
#CP <- as(extent(130, 180, 40, 70), "SpatialPolygons")
proj4string(out) <- CRS(proj4string(ca_large))
#proj4string(ca_large) <- CRS(proj4string(test))

## Clip the map
out <- gIntersection(test, ca_large, byid=T)

coords <- data.frame(out@coords)
out_spdf <- SpatialPointsDataFrame(coords, data.frame(ID=1:length(coords$x)))

# Plot the output
plot(ca_large, lwd=3)
plot(out, pch=21, add=T, col="red")

plot(ca_large, lwd=3)
plot(out_spdf, pch=21, add=T, col="red")

# save cropped shapefile
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefiles"
writeOGR(out_spdf, dsn=outdir, layer=paste0(file_name,"_crop"), driver="ESRI Shapefile", overwrite=T)
#------------------------------------------------------------------------------------------#
