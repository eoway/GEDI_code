getLevel2BPgapProfile <- function (level2b) 
{
  level2b <- level2b@h5
  groups_id <- grep("BEAM\\d{4}$", gsub("/", "", hdf5r::list.groups(level2b, 
                                                                    recursive = F)), value = T)
  m.dt <- data.table::data.table()
  pb <- utils::txtProgressBar(min = 0, max = length(groups_id), 
                              style = 3)
  i.s = 0
  for (i in groups_id) {
    i.s <- i.s + 1
    utils::setTxtProgressBar(pb, i.s)
    level2b_i <- level2b[[i]]
    m <- data.table::data.table(beam <- rep(i, length(level2b_i[["shot_number"]][])), 
                                shot_number = level2b_i[["shot_number"]][], algorithmrun_flag = level2b_i[["algorithmrun_flag"]][], 
                                l2b_quality_flag = level2b_i[["l2b_quality_flag"]][], 
                                delta_time = level2b_i[["geolocation/delta_time"]][], 
                                lat_lowestmode = level2b_i[["geolocation/lat_lowestmode"]][], 
                                lon_lowestmode = level2b_i[["geolocation/lon_lowestmode"]][], 
                                elev_highestreturn = level2b_i[["geolocation/elev_highestreturn"]][], 
                                elev_lowestmode = level2b_i[["geolocation/elev_lowestmode"]][], 
                                height_lastbin = level2b_i[["geolocation/height_lastbin"]][], 
                                height_bin0 = level2b_i[["geolocation/height_bin0"]][], 
                                pgap_theta_z = level2b_i[["pgap_theta_z"]]$dims)
#                                pgap_theta_z = t(level2b_i[["pgap_theta_z"]][, 1:level2b_i[["pgap_theta_z"]]$dims[2]]))
#                                pgap_theta_z = level2b_i[["pgap_theta_z"]][])
    m.dt <- rbind(m.dt, m)
  }
  # colnames(m.dt) <- c("beam", "shot_number", "algorithmrun_flag", 
  #                     "l2b_quality_flag", "delta_time", "lat_lowestmode", 
  #                     "lon_lowestmode", "elev_highestreturn", "elev_lowestmode", 
  #                     "height_lastbin", "height_bin0", paste0("pgap_theta_z", seq(0, 
  #                                                                           30 * 5, 5)[-31], "_", seq(5, 30 * 5, 5), "m"))
  close(pb)
  return(m.dt)
}




getLevel2BPgapProfile2 <- function (level2b, shot_number) 
{
  level2b <- level2b@h5
  groups_id <- grep("BEAM\\d{4}$", gsub("/", "", hdf5r::list.groups(level2b, 
                                                                    recursive = F)), value = T)
  i = NULL
  for (k in groups_id) {
    gid <- max(level2b[[paste0(k, "/shot_number")]][] == 
                 shot_number)
    if (gid == 1) {
      i = k
    }
  }
  if (is.null(i)) {
    stop(paste0("Shot number ", shot_number, " was not found within the dataset!. Please try another shot number"))
  }
  else {
    shot_number_i <- level2b[[paste0(i, "/shot_number")]][]
    shot_number_id <- which(shot_number_i[] == shot_number)
    elevation_bin0 <- level2b[[paste0(i, "/geolocation/elevation_bin0")]][]
    elevation_lastbin <- level2b[[paste0(i, "/geolocation/elevation_lastbin")]][]
    rx_sample_count <- level2b[[paste0(i, "/rx_sample_count")]][]
    rx_sample_start_index <- level2b[[paste0(i, "/rx_sample_start_index")]][]
    rx_sample_start_index_n <- rx_sample_start_index - min(rx_sample_start_index) + 1
    pgap_theta_z_i <- level2b[[paste0(i, "/pgap_theta_z")]][rx_sample_start_index_n[shot_number_id]:(rx_sample_start_index_n[shot_number_id] + 
                                                                                                   rx_sample_count[shot_number_id] - 1)]
    pgap_theta_z_inorm <- (pgap_theta_z_i - min(pgap_theta_z_i))/(max(pgap_theta_z_i) - 
                                                              min(pgap_theta_z_i)) * 100
    elevation_bin0_i <- elevation_bin0[shot_number_id]
    elevation_lastbin_i <- elevation_lastbin[shot_number_id]
    z = rev(seq(elevation_lastbin_i, elevation_bin0_i, (elevation_bin0_i - 
                                                          elevation_lastbin_i)/rx_sample_count[shot_number_id]))[-1]
    pgaptheta_z <- new("gedi.fullwaveform", dt = data.table::data.table(pgap_theta_z = pgap_theta_z_i, 
                                                                     elevation = z))
    return(pgaptheta_z)
  }
}
