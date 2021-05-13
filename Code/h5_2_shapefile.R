rm(list=ls())
options(warn=0)
gc()
graphics.off()

install.packages("sp")
install.packages("rGEDI")

library(sp)
library(rGEDI)

##outdir="G:/My Drive/GEDI/Data/CA_large_bb_data"
outdir="/n/moorcroftfs5/eordway/GEDI"

GEDI01_B_2019265014402_O04397_T01226_02_003_01.h5
file_name <- "\\GEDI01_B_2019265014402_O04397_T01226_02_003_01.h5"
print(file_name)

gedilevel1b<-readLevel1B(level1Bpath = paste0(outdir,file_name))
level1bGeo<-getLevel1BGeo(level1b=gedilevel1b,select=c("elevation_bin0")); head(level1bGeo)

level1bGeo$shot_number<-paste0(level1bGeo$shot_number)

level1bGeo <- na.omit(level1bGeo); summary(level1bGeo) # not sure why there are NA values....

level1bGeo_spdf<-SpatialPointsDataFrame(cbind(level1bGeo$longitude_bin0, level1bGeo$latitude_bin0), data=level1bGeo)

raster::shapefile(level1bGeo_spdf,paste0(outdir,"/shapefiles",file_name))

print("shapefile creation complete")


