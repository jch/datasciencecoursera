pollutantmean <- function(directory, pollutant, id = 1:332) {
  all = c()

  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  for(monitor_id in id) {
    path <- sprintf("%s/%03d.csv", directory, monitor_id)

    df <- read.csv(path, header = TRUE, comment.char = "")

    ## 'pollutant' is a character vector of length 1 indicating
    ## the name of the pollutant for which we will calculate the
    ## mean; either "sulfate" or "nitrate".
    data <- df[pollutant]
    blanks <- is.na(data)

    all <- c(all, data[!blanks])
  }

  ## Return the mean of the pollutant across all monitors list
  ## in the 'id' vector (ignoring NA values)
  ## NOTE: Do not round the result!
  mean(all)
}
