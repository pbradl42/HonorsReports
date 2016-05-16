## Cultural event reports: cerdescriptives returns count of # accepted, rejected, questionable by semester submitted
##          Assessment: getculturaleventassessment() returns likertscales of assessment data from Application for Medallion, relating to C1-4
##          Script at bottom writes charts by year.
## Current students: getstudentsbystatus returns student details from students where status2 = ? (enrolled by default)
## Courses: Script at bottom, not in function, creates likert charts for course-related questions on Annual Accomplishments.
##          Faculty intrusion for 2014-2015 included as XLSX, comparable likert created
## Service: 

studentConn <- function (sqlstr = "select * from Students") {
  library(RJDBC)
  library(plyr)
  library(likert)
  drv <- JDBC("com.filemaker.jdbc.Driver", "/Library/Java/Extensions/fmjdbc.jar", "`")
  student_conn <- dbConnect(drv, "jdbc:filemaker://localhost:2399/StudentRecords?user=pbradley&password=)Declan-14(")
  toReturn <- dbGetQuery(student_conn, sqlstr)
  dbDisconnect(student_conn)
  return(toReturn)
  close(student_conn)
}

setupHNEnv <- function() {
  library(xlsx)
  library(plyr)
  library(tidyr)
 # setwd("~/Desktop/RTallies")
  wd <- getwd()
  message(wd)
  oldpar <- par()
  par(pin = c(4.0,8.0))
  source("likertcharts.R")
}

holdingpen <- function() {
## Make the charts


  aa <- getannualaccomplishments()
  ## count types of annual accomplishments submitted by first semester as honors
  count(aa, c("FirstSemesterAsHonors", "AssessmentPaperType")) -> myCount
  myCount <- myCount[order(myCount$FirstSemesterAsHonors, myCount$AssessmentPaperType), ]
  
  message("Count of assessment paper types by FirstSemesterAsHonors: ")
  myCount
  #toReturn
  
 
  
  
 
  

}


trim <- function (x) gsub("^\\s+|\\s+$", "", x)


