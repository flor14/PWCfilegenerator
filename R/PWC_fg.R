#' @title Weather file for Pesticide in Water Calculator (PWC) v1.52 and Pesticide Root Zone Model (PRZM5) v5.02
#'
#' @description The function \code{\link{PWC_fg}} generates the weather files for \href{https://www.epa.gov/pesticide-science-and-assessing-pesticide-risks/models-pesticide-risk-assessment}{PWC and PRZM5} models from a database in .csv format. The weather file format is described in the \href{https://nepis.epa.gov/Exe/ZyNET.exe/P100K3R4.TXT?ZyActionD=ZyDocument&Client=EPA&Index=2011+Thru+2015&Docs=&Query=&Time=&EndTime=&SearchMethod=1&TocRestrict=n&Toc=&TocEntry=&QField=&QFieldYear=&QFieldMonth=&QFieldDay=&IntQFieldOp=0&ExtQFieldOp=0&XmlQuery=&File=D%3A%5Czyfiles%5CIndex%20Data%5C11thru15%5CTxt%5C00000011%5CP100K3R4.txt&User=ANONYMOUS&Password=anonymous&SortMethod=h%7C-&MaximumDocuments=1&FuzzyDegree=0&ImageQuality=r75g8/r75g8/x150y150g16/i425&Display=hpfr&DefSeekPage=x&SearchBack=ZyActionL&Back=ZyActionS&BackDesc=Results%20page&MaximumPages=1&ZyEntry=1&SeekPage=x&ZyPURL}{PRZM5 manual} guidelines.
#'
#' @param data Name of the dataset
#' @param date Column name for dates in format
#' @param start Date to start the weather file in format
#' @param end  Date to end the weather file in format
#' @param format_date Format of the dates in the dataset
#' @param temp_celsius Column name for temperature (Celsius)
#' @param precip_cm Column name for precipitation (cm/day)
#' @param ws10_cm_s Column name for wind speed values (cm/sec)
#' @param pevp_cm Column name for pan pan evaporation data (cm/day)
#' @param solr_lang Column name for solar radiation (Langley)
#' @param save_in Path to save the final weather file. Extension .dvf do not need to be specified.
#' @return A weather file for PWC and PRZM5 models
#'
#' @examples
#' plot_crayons()
#'
#' @export


PWC_fg <- function(data, date, start, end, format_date, temp_celsius, precip_cm, ws10_cm_s, pevp_cm, solr_lang, save_in){

  file <- data

  names(file)[names(file) == as.character(date)] <- "date"
  names(file)[names(file) == as.character(precip_cm)] <- "precip_cm"
  names(file)[names(file) == as.character(pevp_cm)] <- "pevp_cm"
  names(file)[names(file) == as.character(temp_celsius)] <- "temp_celsius"
  names(file)[names(file) == as.character(ws10_cm_s)] <- "ws10_cm_s"
  names(file)[names(file) == as.character(solr_lang)] <- "solr_lang"


  # subset period
  file_PWC <- file[as.Date(file[ ,"date"], format = format_date) >= as.Date(start, format = format_date) & as.Date(file[ ,"date"], format = format_date) <= as.Date(end, format = format_date),]

  # Split dates into month, day and year
  split_dates <- as.character(format(as.Date(file_PWC[ ,"date"], format = format_date), "%m-%d-%y"))
  split_dates  <- strsplit(split_dates, "-")
  split_dates <- matrix(unlist(split_dates), ncol = 3, byrow = TRUE)

  # Weather file
  file_PWC_dates <- data.frame(split_dates,
                               precip_cm = file_PWC[, "precip_cm"],
                               pevp_cm = file_PWC[, "pevp_cm"],
                               temp_celsius = file_PWC[, "temp_celsius"],
                               ws10_cm_s = file_PWC[, "ws10_cm_s"],
                               solr_lang = file_PWC[, "solr_lang"])

  file_PWC_dates$empty <- NA
  file_PWC_dates <- file_PWC_dates[c("empty","X1", "X2","X3", "precip_cm", "pevp_cm",
                                     "temp_celsius", "ws10_cm_s", "solr_lang" )]

  file_PWC_dates$X3 <- year(seq(as.Date("61/01/01"), by = "day",
                                length.out = nrow(file_PWC_dates)))

  # "Parana" gaps will be filled by the average value
  file_PWC_dates$precip_cm[is.na(file_PWC_dates$precip_cm)] <- 0
  file_PWC_dates$pevp_cm[is.na(file_PWC_dates$pevp_cm)] <- mean(file_PWC_dates$pevp_cm, na.rm = TRUE)
  file_PWC_dates$temp_celsius[is.na(file_PWC_dates$temp_celsius)] <- mean(file_PWC_dates$temp_celsius, na.rm = TRUE)
  file_PWC_dates$ws10_cm_s[is.na(file_PWC_dates$ws10_cm_s)] <- mean(file_PWC_dates$ws10_cm_s, na.rm = TRUE)
  file_PWC_dates$solr_lang[is.na(file_PWC_dates$solr_lang)] <- mean(file_PWC_dates$solr_lang, na.rm = TRUE)

  # Round numbers
  file_PWC_dates$precip_cm <- round(file_PWC_dates$precip_cm, digit = 2)
  file_PWC_dates$pevp_cm <- round(file_PWC_dates$pevp_cm, digit = 2)
  file_PWC_dates$temp_celsius <- round(file_PWC_dates$temp_celsius, digit = 1)
  file_PWC_dates$ws10_cm_s <- round(file_PWC_dates$ws10_cm_s, digit = 1)
  file_PWC_dates$solr_lang <- round(file_PWC_dates$solr_lang, digit = 1)

  # FORTRAN format 1X,3I2,5F10.0
  file_PWC_dates$X1 <- as.integer(as.character(file_PWC_dates$X1))
  file_PWC_dates$X2 <- as.integer(as.character(file_PWC_dates$X2))
  file_PWC_dates$X3 <- as.integer(as.character(file_PWC_dates$X3))

  file_PWC_dates$X1 <- sprintf("%02d", file_PWC_dates$X1)
  file_PWC_dates$X2 <- sprintf("%02d", file_PWC_dates$X2) #leading zeros

  file_PWC_dates$precip_cm <- as.numeric(file_PWC_dates$precip_cm)
  file_PWC_dates$pevp_cm <- as.numeric(file_PWC_dates$pevp_cm)
  file_PWC_dates$temp_celsius <- as.numeric(file_PWC_dates$temp_celsius)
  file_PWC_dates$ws10_cm_s <- as.numeric(file_PWC_dates$ws10_cm_s)
  file_PWC_dates$solr_lang <- as.numeric(file_PWC_dates$solr_lang)

  #save file as .dvf in FORTRAN file format
  write.fwf(file_PWC_dates, file = paste(as.character(save_in), ".dvf", sep = ""),
            width = c(1, 2, 2, 2, 10, 10, 10, 10, 10),
            sep ="",
            colnames = FALSE)
}
