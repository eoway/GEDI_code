#------------------------------------------------------------------------------------------------#
# Download and visualize GEDI data
# 6-7-20
#------------------------------------------------------------------------------------------------#
# https://github.com/carlos-alberto-silva/rGEDI
#------------------------------------------------------------------------------------------------#
setwd("G:/My Drive/GEDI")
#------------------------------------------------------------------------------------------------#
library(raster); library(rgdal); library(sp)
library(reshape2); library(dplyr); library(rgeos)
library(sf); library(rGEDI)
#https://stackoverflow.com/questions/13982773/crop-for-spatialpolygonsdataframe
#https://www.rdocumentation.org/packages/rgeos/versions/0.5-2/topics/gIntersection
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# load CA Southern Sierra bounding box - large
ca_large <- readOGR(dsn="G:/My Drive/GEDI", layer="CA_large_bb"); plot(ca_large)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# set outdir
# [1] Download granules of interest
# [2] Extracting GEDI full-waveform for a giving shotnumbers
# [3] save plot
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"
gedilevel1b_sj <-readLevel1B(level1Bpath = paste0(outdir,"\\GEDI01_B_2019219024757_O03684_T04260_02_003_01.h5"))
# level1bGeo<-getLevel1BGeo(level1b=gedilevel1b_sj,select=c("elevation_bin0"))
# head(level1bGeo)
wf_sj <- getLevel1BWF(gedilevel1b_sj, shot_number="36840817300288335")

# bin0     = closest to GEDI sensor (higher in elevation/altitude)
# last_bin = lowest elevation (often - elevation, e.g. -4m)
sj_bin0     <- 361.4917
sj_last_bin <- 352.3513

# highest = top of canopy?
# lowest  = ground return elevation
sj_highest  <- 361.1546
sj_lowest   <- 357.5958
  
plot(wf_sj, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main="SJER",
     ylim=c(350,365)) 
abline(h=sj_highest, lty=2)
abline(h=sj_lowest, lty=2)
#jpg 400x400 SJER_plot_v2

plot(wf_sj, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main="SJER",
     ylim=c(350,365)) 
abline(h=sj_highest, lty=2)
abline(h=sj_lowest, lty=2)
abline(h=sj_bin0, lty=2, col="red")
abline(h=sj_last_bin, lty=2, col="red")
#jpg 400x400 SJER_plot_v3

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

gedilevel1b_sp <-readLevel1B(level1Bpath = paste0(outdir,"\\GEDI01_B_2019115130439_O02076_T02190_02_003_01.h5"))
wf_sp <- getLevel1BWF(gedilevel1b_sp, shot_number="20760218400229056")

sp_bin0     <- 1.1400e+03
sp_last_bin <- 1.1229e+03

sp_highest  <- 1139.666
sp_lowest   <- 1128.916

plot(wf_sp, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main="Soaproot",
     ylim=c(1115,1145))
abline(h=sp_highest, lty=2)
abline(h=sp_lowest, lty=2)
#jpg 400x400 Soaproot_plot_v2

plot(wf_sp, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main="Soaproot",
     ylim=c(1115,1145))
abline(h=sp_highest, lty=2)
abline(h=sp_lowest, lty=2)
abline(h=sp_bin0, lty=2, col="red")
abline(h=sp_last_bin, lty=2, col="red")
#jpg 400x400 Soaproot_plot_v3
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

gedilevel1b_p3 <-readLevel1B(level1Bpath = paste0(outdir,"\\GEDI01_B_2019115130439_O02076_T02190_02_003_01.h5"))
wf_p3 <- getLevel1BWF(gedilevel1b_p3, shot_number="20760316700228213")

p3_bin0     <- 2.0034e+03
p3_last_bin <- 1.9679e+03

p3_highest  <- 2003.099
p3_lowest   <- 1971.936

plot(wf_p3, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main="P301",
     ylim=c(1960,2010))
abline(h=p3_highest, lty=2)
abline(h=p3_lowest, lty=2)
#jpg 400x400 P301_plot_v2

plot(wf_p3, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main="P301",
     ylim=c(1960,2010))
abline(h=p3_highest, lty=2)
abline(h=p3_lowest, lty=2)
abline(h=p3_bin0, lty=2, col="red")
abline(h=p3_last_bin, lty=2, col="red")
#jpg 400x400 P301_plot_v3
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

gedilevel1b_sh <-readLevel1B(level1Bpath = paste0(outdir,"\\GEDI01_B_2019223180803_O03756_T03613_02_003_01.h5"))
wf_sh <- getLevel1BWF(gedilevel1b_sh, shot_number="37560317000080468")

sh_bin0     <- 2.6387e+03
sh_last_bin <- 2.6170e+03

sh_highest  <- 2638.401
sh_lowest   <- 2622.256

plot(wf_sh, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main = "Shorthair",
     ylim=c(2610,2645))
abline(h=sh_highest, lty=2)
abline(h=sh_lowest, lty=2)
#jpg 400x400 Shorthair_plot_v2

plot(wf_sh, relative=FALSE, polygon=TRUE, type="l", lwd=2, col="grey60",
     xlab="Waveform Amplitude", ylab="Highest return elevation (m)", main = "Shorthair",
     ylim=c(2610,2645))
abline(h=sh_highest, lty=2)
abline(h=sh_lowest, lty=2)
abline(h=sh_bin0, lty=2, col="red")
abline(h=sh_last_bin, lty=2, col="red")
#jpg 400x400 Shorthair_plot_v3
#------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
# plot vertical PAI & PAVD from 2B product
#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"
gedilevel2b_sj <-readLevel2B(level2Bpath = paste0(outdir,"\\GEDI02_B_2019219024757_O03684_T04260_02_001_01.h5"))

level2_sj_BPAIProfile<-getLevel2BPAIProfile(gedilevel2b_sj)
#level2_sj_BPAIProfile<-getLevel2BPAVDProfile(gedilevel2b_sj)
head(level2_sj_BPAIProfile)
#write.csv(level2_sj_BPAIProfile, paste0(outdir,"/level2B_sj_PAIProfile.csv"))
#write.csv(level2_sj_BPAIProfile, paste0(outdir,"/level2B_sj_PAVDProfile.csv"))

level2_sj_BPAIProfile_sn <- subset(level2_sj_BPAIProfile, shot_number == "36840817300288335")
#level2_sj_BPAIProfile_sn <- subset(level2_sj_BPAIProfile, l2b_quality_flag == 1)
level2_sj_BPAIProfile_sn$l2b_quality_flag

# QUALITY == 1

# take pai values by height and transpose 
level2_sj_BPAIProfile_sn_vert <- level2_sj_BPAIProfile_sn[,c(12:22)]
dat <- as.data.frame(t(level2_sj_BPAIProfile_sn_vert))
dat$height <- seq(2.5,52.5, by=5); dat
write.csv(dat, paste0(outdir,"/level2B_sj_PAIProfile_36841116400287186.csv"))
#write.csv(dat, paste0(outdir,"/level2B_sj_PAVDProfile_36841116400287186.csv"))


plot(dat$V1, dat$height, type="l", lwd=2, col="grey60",
     xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)", main="SJER")#,
#     xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)", main="SJER")#,
#     ylim=c(320,400))
#jpg 400x400 SJER_plot ; SJER_PAVD_plot

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

gedilevel2b_sp <-readLevel2B(level2Bpath = paste0(outdir,"\\GEDI02_B_2019115130439_O02076_T02190_02_001_01.h5"))

level2_sp_BPAIProfile<-getLevel2BPAIProfile(gedilevel2b_sp)
#level2_sp_BPAIProfile<-getLevel2BPAVDProfile(gedilevel2b_sp)
head(level2_sp_BPAIProfile)
#write.csv(level2_sp_BPAIProfile, paste0(outdir,"/level2B_sp_PAIProfile.csv"))
#write.csv(level2_sp_BPAIProfile, paste0(outdir,"/level2B_sp_PAVDProfile.csv"))

level2_sp_BPAIProfile_sn <- subset(level2_sp_BPAIProfile, shot_number == "20760218400229056")
level2_sp_BPAIProfile_sn

# QUALITY == 1

# take pai values by height and transpose 
level2_sp_BPAIProfile_sn_vert <- level2_sp_BPAIProfile_sn[,c(12:22)]
dat <- as.data.frame(t(level2_sp_BPAIProfile_sn_vert))
dat$height <- seq(2.5,52.5, by=5); dat
write.csv(dat, paste0(outdir,"/level2B_sp_PAIProfile_20760218400229056.csv"))
#write.csv(dat, paste0(outdir,"/level2B_sp_PAVDProfile_20760218400229056.csv"))

plot(dat$V1, dat$height, type="l", lwd=2, col="grey60",
#     xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)", main="Soaproot")#,
     xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)", main="Soaproot")#,
#     ylim=c(320,400))
#jpg 400x400 Soaproot_plot; Soaproot_PAVD_plot
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

gedilevel2b_p3 <-readLevel2B(level2Bpath = paste0(outdir,"\\GEDI02_B_2019115130439_O02076_T02190_02_001_01.h5"))

level2_p3_BPAIProfile<-getLevel2BPAIProfile(gedilevel2b_p3)
#level2_p3_BPAIProfile<-getLevel2BPAVDProfile(gedilevel2b_p3)
head(level2_p3_BPAIProfile)
summary(level2_p3_BPAIProfile)
#write.csv(level2_p3_BPAIProfile, paste0(outdir,"/level2B_p3_PAIProfile.csv"))
#write.csv(level2_p3_BPAIProfile, paste0(outdir,"/level2B_p3_PAVDProfile.csv"))
level2_p3_BPAIProfile_sn <- subset(level2_p3_BPAIProfile, shot_number == "20760316700228213")
level2_p3_BPAIProfile_sn

# QUALITY == 1

# take pai values by height and transpose 
level2_p3_BPAIProfile_sn_vert <- level2_p3_BPAIProfile_sn[,c(12:22)]
dat <- as.data.frame(t(level2_p3_BPAIProfile_sn_vert))
dat$height <- seq(2.5,52.5, by=5); dat
write.csv(dat, paste0(outdir,"/level2B_p3_PAIProfile_20760316700228213.csv"))
#write.csv(dat, paste0(outdir,"/level2B_p3_PAVDProfile_20760316700228213.csv"))

plot(dat$V1, dat$height, type="l", lwd=2, col="grey60",
#     xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)", main="P301")#,
     xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)", main="P301")#,

#     ylim=c(320,400))
#jpg 400x400 P301_plot ; P301_PAVD_plot
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(rGEDI)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

gedilevel2b_sh <-readLevel2B(level2Bpath = paste0(outdir,"\\GEDI02_B_2019223180803_O03756_T03613_02_001_01.h5"))

level2_sh_BPAIProfile<-getLevel2BPAIProfile(gedilevel2b_sh)
#level2_sh_BPAIProfile<-getLevel2BPAVDProfile(gedilevel2b_sh)
head(level2_sh_BPAIProfile)
summary(level2_sh_BPAIProfile)
#write.csv(level2_sh_BPAIProfile, paste0(outdir,"/level2B_sh_PAIProfile.csv"))
#write.csv(level2_sh_BPAIProfile, paste0(outdir,"/level2B_sh_PAVDProfile.csv"))
level2_sh_BPAIProfile_sn <- subset(level2_sh_BPAIProfile, shot_number == "37560317000080468")
level2_sh_BPAIProfile_sn

# QUALITY == 1


# take pai values by height and transpose 
level2_sh_BPAIProfile_sn_vert <- level2_sh_BPAIProfile_sn[,c(12:22)]
dat <- as.data.frame(t(level2_sh_BPAIProfile_sn_vert))
dat$height <- seq(2.5,52.5, by=5); dat
write.csv(dat, paste0(outdir,"/level2B_sh_PAIProfile_37560317000080468.csv"))
#write.csv(dat, paste0(outdir,"/level2B_sh_PAVDProfile_37560317000080468.csv"))

plot(dat$V1, dat$height, type="l", lwd=2, col="grey60",
#     xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)", main="Shorthair")#,
     xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)", main="Shorthair")#,

#     ylim=c(320,400))
#jpg 400x400 Shorthair_plot ; Shorthair_PAVD_plot
#------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------#
# Combine all PAVD plots
rm(list=ls())
options(warn=0)
gc()
graphics.off()
library(ggplot2)
outdir="G:/My Drive/GEDI/Data/CA_large_bb_data/shapefile_conversion_done"

# datsj <- read.csv(paste0(outdir, "/level2B_sj_PAVDProfile_36841116400287186.csv"))
# datsp <- read.csv(paste0(outdir, "/level2B_sp_PAVDProfile_20760218400229056.csv"))
# datp3 <- read.csv(paste0(outdir, "/level2B_p3_PAVDProfile_20760316700228213.csv"))
# datsh <- read.csv(paste0(outdir, "/level2B_sh_PAVDProfile_37560317000080468.csv"))

datsj <- read.csv(paste0(outdir, "/level2B_sj_PAIProfile_36841116400287186.csv"))
datsp <- read.csv(paste0(outdir, "/level2B_sp_PAIProfile_20760218400229056.csv"))
datp3 <- read.csv(paste0(outdir, "/level2B_p3_PAIProfile_20760316700228213.csv"))
datsh <- read.csv(paste0(outdir, "/level2B_sh_PAIProfile_37560317000080468.csv"))

datsj$site <- rep("sj", length(datsj$X))
datsp$site <- rep("sp", length(datsp$X))
datp3$site <- rep("p3", length(datp3$X))
datsh$site <- rep("sh", length(datsh$X))

plot_dat <- rbind(datsj, datsp, datp3, datsh)

# plot(datsh$V1, datsh$height, type="l", lwd=3, col="forestgreen",
#      xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)")
# lines(datp3$V1, datp3$height, type="l", lwd=3, col="dodgerblue3",
#       xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)")
# lines(datsj$V1, datsj$height, type="l", lwd=3, col="darkgoldenrod1",
#       xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)")
# lines(datsp$V1, datsp$height, type="l", lwd=3, col="firebrick3",
#       xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)")
# # lines(datsh$V1, datsh$height, type="l", lwd=3, col="green",
# #       xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)")
# # Add a legend to the plot
# legend(0.025, 50, legend=c("Shorthair", "P301", "SJER", "Soaproot"), box.col=NA,
#        col=c("forestgreen", "dodgerblue3", "darkgoldenrod1", "firebrick3"), lty=1, lwd=3, cex=1.5)


plot(datp3$V1, datp3$height, type="l", lwd=3, col="dodgerblue3",
      xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)")
lines(datsh$V1, datsh$height, type="l", lwd=3, col="forestgreen",
      xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)")
lines(datsj$V1, datsj$height, type="l", lwd=3, col="darkgoldenrod1",
     xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)")
lines(datsp$V1, datsp$height, type="l", lwd=3, col="firebrick3",
      xlab=expression(PAI~m^{2}~m^{-2}), ylab="Height (m)")
# lines(datsh$V1, datsh$height, type="l", lwd=3, col="green",
#       xlab=expression(PAVD~m^{2}~m^{-3}), ylab="Height (m)")
# Add a legend to the plot
legend(0.25, 50, legend=c("P301", "Shorthair", "SJER", "Soaproot"), box.col=NA,
       col=c("dodgerblue3", "forestgreen", "darkgoldenrod1", "firebrick3"), lty=1, lwd=3, cex=1.5)

#jpg 400x800 combined_PAVD_plot ; combined_PAI_plot

#------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------#




par(mfrow = c(2,2), mar=c(4,4,1,1), cex.axis = 1.5)


plot(wf_p3, relative=TRUE, polygon=FALSE, type="l", lwd=2, col="forestgreen",
     xlab="Waveform Amplitude (%)", ylab="Elevation (m)")


#------------------------------------------------------------------------------------------#
#test <- readOGR(dsn="G:/My Drive/GEDI/Data/shapefiles", layer="GEDI01_B_2019213012634_O03590_T04227_02_003_01_crop"); plot(test)
test <- readOGR(dsn="G:/My Drive/GEDI/Data/shapefiles", layer="GEDI01_B_2019213012634_O03590_T04227_02_003_01_crop"); plot(test)
plot(hf, lwd=3)
plot(test, pch=21, add=T, bg="red")
#------------------------------------------------------------------------------------------#

library(leaflet)
library(leafsync)

gedi_coords <- as.data.frame(test@coords)
#hf_coords <- as.data.frame(hf@coords)

leaflet() %>%
  # addGeoJSON(geojson=hf, 
  #            color = "blue",
  #            fill = F) %>%
  addCircleMarkers(gedi_coords$coords.x1,
                   gedi_coords$coords.x2,
                   radius = 3,
                   color = "black",
                   fillColor = "red",
                   stroke = TRUE, 
                   fillOpacity = 1)  %>%
  addPolygons(data = hf,
              #fillColor = "black",
              #fill=F,
              color = "blue",
              stroke = FALSE, 
              fillOpacity = 0.2, 
              smoothFactor = 0.5) %>% 
  addScaleBar(options = list(imperial = FALSE)) %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addLegend(colors = "red", labels= "Samples",title ="GEDI Level1B")




leaflet() %>%
  addCircleMarkers(level1bGeo$longitude_bin0,
                   level1bGeo$latitude_bin0,
                   radius = 1,
                   opacity = 1,
                   color = "red")  %>%
  addScaleBar(options = list(imperial = FALSE)) %>%
  addProviderTiles(providers$Esri.WorldImagery) %>%
  addLegend(colors = "red", labels= "Samples",title ="GEDI Level1B")


