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


dat_coords <- read.csv("G:/My Drive/Projects/GEDI/Valentina_Doerre_Torres/Data/Soap_Teak_GEDI_coords_filtered.csv")
dat_pai <- read.csv("G:/My Drive/Projects/GEDI/Valentina_Doerre_Torres/Data/Soap_Teak_GEDI_PAI_all_filtered.csv")

head(dat_coords)
head(dat_pai)


# convert shot_number column to character string for both csv's
# dat_coords$shot_number <- as.character(dat_coords$shot_number)
# dat_pai$shot_number <- as.character(dat_pai$shot_number)

# > head(dat_coords$shot_number)
# [1] "19690000200125788" "19690000200125792" "19690000200125792" "19690000200125792" "19690000200125792" "19690000200125796"
# > dat_pai$shot_number <- as.character(dat_pai$shot_number)
# > head(dat_pai$shot_number)
# [1] "19690000200121764" "19690000200121768" "19690000200121768" "19690000200121768" "19690000200121768" "19690000200121768"

#------------------------------------------------------------------------------------------------#
# location of your GEDI .h5 files
#------------------------------------------------------------------------------------------------#
outdir="C:/Users/elsao/Desktop/temp_files/GEDI_2B/"
# outdir_2A_1="C:/Users/elsao/Desktop/temp_files/GEDI_2B_1/"
# outdir_2A_2="C:/Users/elsao/Desktop/temp_files/GEDI_2B_2/"
# outdir_2A_3="C:/Users/elsao/Desktop/temp_files/GEDI_2B_3/"
# outdir_2A_4="C:/Users/elsao/Desktop/temp_files/GEDI_2B_4/"
# outdir_2A_5="C:/Users/elsao/Desktop/temp_files/GEDI_2B_5/"
# outdir_2A_6="C:/Users/elsao/Desktop/temp_files/GEDI_2B_6/"
# outdir_2A_7="C:/Users/elsao/Desktop/temp_files/GEDI_2B_7/"
# outdir_2A_8="C:/Users/elsao/Desktop/temp_files/GEDI_2B_8/"
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# evaluation on single file
#------------------------------------------------------------------------------------------------#
# gedilevel2b <-readLevel2B(level2Bpath = paste0(outdir,"\\GEDI02_B_2019108154705_O01969_02_T03766_02_003_01_V002.h5"))
# level2B_totalPAI <- getLevel2BVPM(gedilevel2b) # "pai" variable = total PAI
# head(level2B_totalPAI)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
#create a list of the files from target directory
#------------------------------------------------------------------------------------------------#
file_list <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_2B/")
# file_list_2A_1 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_1/")
# file_list_2A_2 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_2/")
# file_list_2A_3 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_3/")
# file_list_2A_4 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_4/")
# file_list_2A_5 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_5/")
# file_list_2A_6 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_6/")
# file_list_2A_7 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_7/")
# file_list_2A_8 <- list.files(path="C:/Users/elsao/Desktop/temp_files/GEDI_Southern_Sierra_2A_8/")
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
#initiate a blank data frame, each iteration of the loop will append the data from the given file to this variable
#------------------------------------------------------------------------------------------------#
dataset <- data.frame()
# dataset2A_1 <- data.frame()
# dataset2A_2 <- data.frame()
# dataset2A_3 <- data.frame()
# dataset2A_4 <- data.frame()
# dataset2A_5 <- data.frame()
# dataset2A_6 <- data.frame()
# dataset2A_7 <- data.frame()
# dataset2A_8 <- data.frame()
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# Load Level 2B data and extract total PAI and shotnumber
#------------------------------------------------------------------------------------------------#
for (i in 1:length(file_list)){
  temp_data <- readLevel2B(level2Bpath = paste0(outdir,file_list[i]))
  level2B_totalPAI <- getLevel2BVPM(temp_data)
  dataset <- rbind(dataset, level2B_totalPAI) 
  #for each iteration, bind the new data to the building dataset
}
#------------------------------------------------------------------------------------------------#
colnames(dataset)
head(dataset)
dim(dataset)

dat_sub <- select(dataset, beam, shot_number, pai, pgap_theta, omega, fhd_normal, elev_highestreturn, elev_lowestmode, algorithmrun_flag, l2b_quality_flag, sensitivity)
#summary(dat2A_1_sub)
dim(dat_sub); dim(dataset)
rm(dataset)
#------------------------------------------------------------------------------------------------#

#------------------------------------------------------------------------------------------------#
# subset level 1B data to bounding box
#------------------------------------------------------------------------------------------------#
# # Soaproot & Teakettle Bounding Box coordinates - area that overlaps with NEON data
# # c(lat upper, lat lower, lon right, lon left)
# bb <- c(37.132, 36.925, -119.346, -118.956)
# 
# # subset L1B data to bounding box
# dat_sub <- subset(dataset, latitude_bin0 < bb[1] & latitude_bin0 > bb[2] & longitude_bin0 > bb[3] & longitude_bin0 < bb[4])
# summary(dat_sub)
# dim(dat_sub); dim(dataset)
# 
# head(dat_sub)
# rm(dataset)
#------------------------------------------------------------------------------------------------#


#------------------------------------------------------------------------------------------------#
# Join dat_sub with level 2B data for shots of interest 
#------------------------------------------------------------------------------------------------#
# dat_sub_all <- inner_join(dat_sub, dat2A_sub, by = c("shot_number"))
# dim(dat_sub_all); dim(dat_sub); dim(dat2A_sub)
# 
# summary(dat_sub_all$latitude_bin0)
# summary(dat_sub_all$longitude_bin0)
# 
dat_sub_filtered <- subset(dat_sub, l2b_quality_flag != 0 & sensitivity >= 0.95)
head(dat_sub_filtered)
summary(dat_sub_filtered)

dim(dat_sub_filtered); dim(dat_sub)

#------------------------------------------------------------------------------------------------#
# Write dataframe to csv files
#------------------------------------------------------------------------------------------------#
write.csv(dat_sub,"G:/My Drive/Projects/GEDI/Valentina_Doerre_Torres/Data/Soap_Teak_GEDI_PAI_all.csv")
write.csv(dat_sub_filtered,"G:/My Drive/Projects/GEDI/Valentina_Doerre_Torres/Data/Soap_Teak_GEDI_PAI_all_filtered.csv")
#------------------------------------------------------------------------------------------------#

