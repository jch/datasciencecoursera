complete <- function(directory, id = 1:332) {
  totals <- c()
  ## 'directory' is a character vector of length 1 indicating
  ## the location of the CSV files

  ## 'id' is an integer vector indicating the monitor ID numbers
  ## to be used
  for(monitor_id in id) {
    path <- sprintf("%s/%03d.csv", directory, monitor_id)

    df <- read.csv(path, header = TRUE, comment.char = "")
    totals <- c(totals, sum(complete.cases(df)))
  }

  ## Return a data frame of the form:
  ## id nobs
  ## 1  117
  ## 2  1041
  ## ...
  ## where 'id' is the monitor ID number and 'nobs' is the
  ## number of complete cases
  data.frame(id, totals)
}
