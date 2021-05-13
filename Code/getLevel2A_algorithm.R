getLevel2A_algorithm <- function (level2a, aN) {
  level2a <- level2a@h5 # level2a@h5 | gedilevel2a@h5
  beam_id <- grep("BEAM\\d{4}$", gsub("/", "", hdf5r::list.groups(level2a, 
                                                                  recursive = F)), value = T)
  groups_id <- paste(beam_id, "/geolocation", sep="")
  rh_alg <- paste("rh_a", aN, sep="")
  qual_flag <- paste("quality_flag_a", aN, sep="")
  sensitiv <- paste("sensitivity_a", aN, sep="")
  lat_lm <- paste("lat_lowestmode_a", aN, sep="")
  lon_lm <- paste("lon_lowestmode_a", aN, sep="")
  elev_highest_return <- paste("elev_highestreturn_a", aN, sep="")
  elev_lm <- paste("elev_lowestmode_a", aN, sep="")
  
  rh.dt <- data.table::data.table()
  pb <- utils::txtProgressBar(min = 0, max = length(groups_id), 
                              style = 3)
  i.s = 0
  for (i in groups_id) {
    i.s <- i.s + 1
    utils::setTxtProgressBar(pb, i.s)
    level2a_i <- level2a[[i]] #level2a[[i]] | "BEAM0000/geolocation"
    if (any(hdf5r::list.datasets(level2a_i) == "shot_number")) {
      if (length(level2a_i[[rh_alg]]$dims) == 2) {
        rh = t(level2a_i[[rh_alg]][, ])
      }
      else {
        rh = t(level2a_i[[rh_alg]][])
      }
      rhs <- data.table::data.table(beam <- rep(i, length(level2a_i[["shot_number"]][])), # replace 'i' with "BEAM0000/geolocation"
                                    shot_number = level2a_i[["shot_number"]][], 
                                    quality_flag = level2a_i[[qual_flag]][], 
                                    sensitivity = level2a_i[[sensitiv]][], 
                                    lat_lowestmode = level2a_i[[lat_lm]][], 
                                    lon_lowestmode = level2a_i[[lon_lm]][], 
                                    elev_highestreturn = level2a_i[[elev_highest_return]][], 
                                    elev_lowestmode = level2a_i[[elev_lm]][], 
                                    rh)
      rh.dt <- rbind(rh.dt, rhs)
    }
  }
  colnames(rh.dt) <- c("beam", "shot_number", qual_flag, sensitiv, lat_lm, 
                       lon_lm, elev_highest_return, elev_lm, paste0(rh_alg,"_", seq(0, 100)))
  close(pb)
  return(rh.dt)
}
