#------------------------------------------------------------------------------------------------#
# load GEDI Level 1B data for Southern Sierra
# subset to bounding box
# select lat, lon, quality flag, sensitivity, beam 
#------------------------------------------------------------------------------------------------#
# see package info here: https://github.com/carlos-alberto-silva/rGEDI
#------------------------------------------------------------------------------------------------#
library(rGEDI); library(ggplot2); library(rgdal); library(sf); library(raster); library(dplyr)
library(tidyverse)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
#/n/holylfs04/LABS/moorcroft_lab/Everyone/GEDI/Data_Southern_Sierra
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# location of your GEDI .h5 files
#------------------------------------------------------------------------------------------------#
outdir="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_1B/"
outdir_2A_1="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_1/"
outdir_2A_2="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_2/"
outdir_2A_3="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_3/"
outdir_2A_4="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_4/"
outdir_2A_5="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_5/"
outdir_2A_6="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_6/"
outdir_2A_7="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_7/"
outdir_2A_8="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_8/"
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
#create a list of the files from target directory
#------------------------------------------------------------------------------------------------#
file_list <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_1B/")
file_list_2A_1 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_1/")
file_list_2A_2 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_2/")
file_list_2A_3 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_3/")
file_list_2A_4 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_4/")
file_list_2A_5 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_5/")
file_list_2A_6 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_6/")
file_list_2A_7 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_7/")
file_list_2A_8 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_8/")
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable
#------------------------------------------------------------------------------------------------#
dataset <- data.frame()
dataset2A_1 <- data.frame()
dataset2A_2 <- data.frame()
dataset2A_3 <- data.frame()
dataset2A_4 <- data.frame()
dataset2A_5 <- data.frame()
dataset2A_6 <- data.frame()
dataset2A_7 <- data.frame()
dataset2A_8 <- data.frame()
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# Load Level 2A data for quality flag & sensitivity info
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_1)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_1,file_list_2A_1[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_1 <- rbind(dataset2A_1, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_1)
dat2A_1_sub <- select(dataset2A_1, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_1_sub)
dim(dat2A_1_sub); dim(dataset2A_1)
rm(dataset2A_1)
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_2)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_2,file_list_2A_2[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_2 <- rbind(dataset2A_2, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_2)
dat2A_2_sub <- select(dataset2A_2, beam, shot_number, quality_flag, sensitivity, degrade_flag)
dim(dat2A_2_sub); dim(dataset2A_2)
rm(dataset2A_2)
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_3)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_3,file_list_2A_3[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_3 <- rbind(dataset2A_3, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_3)
dat2A_3_sub <- select(dataset2A_3, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_3_sub)
dim(dat2A_3_sub); dim(dataset2A_3)
rm(dataset2A_3)
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_4)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_4,file_list_2A_4[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_4 <- rbind(dataset2A_4, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_4)
dat2A_4_sub <- select(dataset2A_4, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_4_sub)
dim(dat2A_4_sub); dim(dataset2A_4)
rm(dataset2A_4)
#------------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_5)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_5,file_list_2A_5[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_5 <- rbind(dataset2A_5, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_5)
dat2A_5_sub <- select(dataset2A_5, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_5_sub)
dim(dat2A_5_sub); dim(dataset2A_5)
rm(dataset2A_5)
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_6)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_6,file_list_2A_6[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_6 <- rbind(dataset2A_6, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_6)
dat2A_6_sub <- select(dataset2A_6, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_6_sub)
dim(dat2A_6_sub); dim(dataset2A_6)
rm(dataset2A_6)
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_7)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_7,file_list_2A_7[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_7 <- rbind(dataset2A_7, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_7)
dat2A_7_sub <- select(dataset2A_7, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_7_sub)
dim(dat2A_7_sub); dim(dataset2A_7)
rm(dataset2A_7)
#------------------------------------------------------------------------------------------------#
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list_2A_8)){
  temp_data <- readLevel2A(level2Apath = paste0(outdir_2A_8,file_list_2A_8[i]))
  level2AM_temp <- getLevel2AM(temp_data)
  dataset2A_8 <- rbind(dataset2A_8, level2AM_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset2A_8)
dat2A_8_sub <- select(dataset2A_8, beam, shot_number, quality_flag, sensitivity, degrade_flag)
#summary(dat2A_8_sub)
dim(dat2A_8_sub); dim(dataset2A_8)
rm(dataset2A_8)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# Combine all 2A dataframes
#------------------------------------------------------------------------------------------------#
dat2A_sub <- rbind(dat2A_1_sub, dat2A_2_sub, dat2A_3_sub, dat2A_4_sub, dat2A_5_sub, dat2A_6_sub, dat2A_7_sub, dat2A_8_sub)
head(dat2A_sub)
dim(dat2A_sub)

rm(dat2A_1_sub, dat2A_2_sub, dat2A_3_sub, dat2A_4_sub, dat2A_5_sub, dat2A_6_sub, dat2A_7_sub, dat2A_8_sub)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# Load Level 1B data with lat/lon
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list)){
  temp_data <- readLevel1B(level1Bpath = paste0(outdir,file_list[i]))
  level1bGeo_temp <- getLevel1BGeo(temp_data,
                                   select=c("shot_number","latitude_bin0","latitude_lastbin",
                                            "longitude_bin0","longitude_lastbin","elevation_bin0",
                                            "elevation_bin0_error","elevation_lastbin",
                                            "elevation_lastbin_error"))
  #each file will be read in, specify which columns you need read in to avoid any errors
  dataset <- rbind(dataset, level1bGeo_temp) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
#output will be a massive dataframe
colnames(dataset)
head(dataset)
dim(dataset)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# subset level 1B data to bounding box
#------------------------------------------------------------------------------------------------#
# Soaproot & Teakettle Bounding Box coordinates - area that overlaps with NEON data
# c(lat upper, lat lower, lon right, lon left)
bb <- c(37.132, 36.925, -119.346, -118.956)

# subset L1B data to bounding box
dat_sub <- subset(dataset, latitude_bin0 < bb[1] & latitude_bin0 > bb[2] & longitude_bin0 > bb[3] & longitude_bin0 < bb[4])
summary(dat_sub)
dim(dat_sub); dim(dataset)

head(dat_sub)
rm(dataset)
#------------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------------#
# Join dat_sub with level 2B data for shots of interest 
#------------------------------------------------------------------------------------------------#
dat_sub_all <- inner_join(dat_sub, dat2A_sub, by = c("shot_number"))
dim(dat_sub_all); dim(dat_sub); dim(dat2A_sub)

summary(dat_sub_all$latitude_bin0)
summary(dat_sub_all$longitude_bin0)

dat_sub_filtered <- subset(dat_sub_all, quality_flag != 0 & sensitivity >= 0.95)
dim(dat_sub_filtered)
summary(dat_sub_filtered)

#------------------------------------------------------------------------------------------------#
# Write filtered and unfiltered dataframes to csv files
#------------------------------------------------------------------------------------------------#
write.csv(dat_sub_all,"G:/My Drive/Projects/GEDI/Valentina_Doerre_Torres/Data/Soap_Teak_GEDI_coords.csv")
write.csv(dat_sub_filtered,"G:/My Drive/Projects/GEDI/Valentina_Doerre_Torres/Data/Soap_Teak_GEDI_coords_filtered.csv")
#------------------------------------------------------------------------------------------------#

