source("../StudentConn.R")
geteligible <- function(semester = "201508", status = "Eligible") {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")
  
  if(exists("status")) {
    sqlstr <- paste("SELECT 
                    ", iddata, ", ", demodatatocollect, 
                    " FROM Students 
                    WHERE ID is not null
                    AND term = ", sem, "", sep = "")
  } else {
    sqlstr <- paste("SELECT distinct(", iddata, ") 
                    FROM Students, StatusUpdates
                    WHERE Students.ID = StatusUpdates.StudentID 
                    AND StatusUpdates.Comment like '%", status, "%' AND term = ", sem, "", sep = "")
  }  
  #sqlstr <- paste("Select * from Students where Status2 = \'", status, "\'", sep = "")
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
}

getapplied <- function(semester = "201508", status = "Application") {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")
  
  if(exists("status")) {
    sqlstr <- paste("SELECT 
                    ", iddata, ", ", demodatatocollect, 
                    " FROM Students 
                    WHERE ID is not null
                    AND ApplicationFor = ", sem, "", sep = "")
  } else {
    sqlstr <- paste("SELECT distinct(", iddata, ") 
                    FROM Students, StatusUpdates
                    WHERE Students.ID = StatusUpdates.StudentID 
                    AND StatusUpdates.Comment like '%", status, "%' AND ApplicationFor = ", sem, "", sep = "")
  }  
  #sqlstr <- paste("Select * from Students where Status2 = \'", status, "\'", sep = "")
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
  }

getadmitted <- function(semester = 201608) {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")
  if(exists("semester")) {
    sqlstr <- paste("SELECT 
                    ", iddata, ", ", demodatatocollect, 
                    " FROM Students 
                    WHERE ID is not null
                    AND FirstSemesterAsHonors = ", semester, "", sep = "")
  } else {
    stop("No semester specified")
  }  
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
}

getadmittedFTIAC <- function(semester = 201608) {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")
  if(exists("semester")) {
    sqlstr <- paste("SELECT 
                    ", iddata, ", ", demodatatocollect, 
                    " FROM Students 
                    WHERE ID is not null
                    AND FirstSemesterAsHonors = ", semester, " AND EntranceType = 1", sep = "")
  } else {
    stop("No semester specified")
  }  
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
}
getgraduates <- function(semester = 201608) {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete, Students.AthleteCopy, Students.State_Corrected, Students.Zip_Corrected, Students.LastCumGPA, Students.TotalSemestersAsHonors")
  iddata <- paste("Students.ID")
  if(exists("semester")) {
    if(semester < 201600) {
      confirmedString <- paste("Students.Status2 like '%lumn%' AND Students.LastSemesterAsHonor = ", semester, sep="")
      sqlstr <- paste("SELECT 
                      distinct (", iddata, "), ", demodatatocollect, 
                      " FROM Students
                      WHERE 
                      ", confirmedString, sep = "")
    } else {
      confirmedString <- paste("Students.AnticipatedCompletionSemester like '", semester, "' ", sep="")

    sqlstr <- paste("SELECT 
                    distinct (", iddata, "), ", demodatatocollect, 
                    " FROM Students, Symposium
                    WHERE Symposium.StudentID = Students.ID AND Symposium.Complete like 'Yes' AND
                    ", confirmedString, sep = "")
    }
  } else {
    stop("No semester specified")
  }  
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
  
}
getapp4med <- function(semester = 201608) {
  demodatatocollect <- paste("ReportsApplicationForMedallion.*, Students.FirstSemesterAsHonors, Students.EntranceType, Students.Status2, Students.LastSemesterAsHonor")
  iddata <- paste("Students.ID")
  if(exists("semester")) {
    if(semester < 201600) {
      confirmedString <- paste("Students.Status2 like '%lumn%' AND Students.LastSemesterAsHonor = ", semester, sep="")
      sqlstr <- paste("SELECT 
                      distinct (", iddata, "), ", demodatatocollect, 
                      " FROM Students, ReportsApplicationForMedallion
                      WHERE ReportsApplicationForMedallion.StudentID = Students.ID AND
                      ", confirmedString, sep = "")
    } else {
      confirmedString <- paste("Students.AnticipatedCompletionSemester like '", semester, "' ", sep="")
      
      sqlstr <- paste("SELECT 
                      distinct (", iddata, "), ", demodatatocollect, 
                      " FROM Students, ReportsApplicationForMedallion, Symposium
                      WHERE ReportsApplicationForMedallion.StudentID = Students.ID AND Symposium.StudentID = Students.ID AND Symposium.Complete like 'Yes' AND
                      ", confirmedString, sep = "")
    }
    } else {
      stop("No semester specified")
    }  
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
  
}
getorientation <- function(semester = 201608) {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected, Students.FirstCollege, Students.FirstMajor")
  iddata <- paste("Students.ID")
  if(exists("semester")) {
    if(semester > 201308) {
      confirmedString <- paste("StatusUpdates.Comment like '%onfirme%' AND Students.ApplicationFor = ", semester, sep="")
      sqlstr <- paste("SELECT 
                    distinct (", iddata, "), ", demodatatocollect, 
                      " FROM Students, StatusUpdates
                      WHERE Students.ID = StatusUpdates.StudentID
                      AND ", confirmedString, sep = "")
    } else {
      confirmedString <- paste("Students.EntranceType = 1 AND Students.Term = ", semester, sep="")
      sqlstr <- paste("SELECT 
                    distinct (", iddata, "), ", demodatatocollect, 
                      " FROM Students
                      WHERE 
                      ", confirmedString, sep = "")
    }
  } else {
    stop("No semester specified")
  }  
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
}

getstudentsbystatusUpdate <- function(status = "Enrolled", semester = "201508") {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")
  
  if(exists("status")) {
    sqlstr <- paste("SELECT distinct(", iddata, "), ", demodatatocollect , "  
                    FROM Students, StatusUpdates
                    WHERE Students.ID = StatusUpdates.StudentID 
                    AND StatusUpdates.Comment like '%", status, "%' AND term = ", semester, "", sep = "")
  } else {
    sqlstr <- paste("SELECT distinct(", iddata, "), ", demodatatocollect , "  
                    FROM Students, StatusUpdates
                    WHERE Students.ID = StatusUpdates.StudentID 
                    AND StatusUpdates.Comment like '%", status, "%' AND term = ", semester, "", sep = "")
  }  
  #sqlstr <- paste("Select * from Students where Status2 = \'", status, "\'", sep = "")
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
  }
getstudentsbystatus <- function(status = "Enrolled", semester = "201508") {
  demodatatocollect <- paste("Students.Term, Students.ApplicationFor, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")
  
  if(exists("status")) {
    sqlstr <- paste("SELECT 
                    ", iddata, ", ", demodatatocollect, 
                    " FROM Students 
                    WHERE ID is not null
                    AND Status3 like \'", status, "\' 
                    AND ApplicationFor = ", semester, "", sep = "")
  } else {
    sqlstr <- paste("SELECT distinct(", iddata, ") 
                    FROM Students, StatusUpdates
                    WHERE Students.ID = StatusUpdates.StudentID 
                    AND StatusUpdates.Comment like '%", status, "%' AND ApplicationFor = ", semester, "", sep = "")
  }  
  #sqlstr <- paste("Select * from Students where Status2 = \'", status, "\'", sep = "")
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
}
getcurrentbysemester <- function(semester = "201508") {
  demodatatocollect <- paste("Students.Term, Students.Ethnicity, Students.Gender, Students.LastCollege, Students.LastMajor, Students.First_Generation, Students.HS_GPA, Students.ACT_COMP, Students.SAT_COMP, Students.EntranceType, Students.FirstSemesterAsHonors, Students.Athlete,  Students.State_Corrected, Students.Zip_Corrected")
  iddata <- paste("Students.ID")

  if(exists("semester")) {
    sqlstr <- paste("SELECT 
                    ", iddata, ", ", demodatatocollect, 
                    " FROM Students, CurrentStudentsBySemester
                    WHERE Students.ID = CurrentStudentsBySemester.Banner_ID AND Students.ID is not null AND CurrentStudentsBySemester.Semester = ", semester, "", sep = "")
  } else {
    sqlstr <- paste("SELECT distinct(", iddata, ") 
                    FROM Students, CurrentStudentsBySemester
                    WHERE Students.ID = CurrentStudentsBySemester.Banner_ID AND Students.ID is not null AND CurrentStudentsBySemester.Semester = ", semester, "", sep = "")
  }  
 # sqlstr <- paste("Select * from Students, CurrentStudentsBySemester WHERE Students.ID = CurrentStudentsBySemester.Banner_ID AND CurrentStudentsBySemester.Semester = ", semester, "", sep = "")
  message(sqlstr)
  student_details <- studentConn(sqlstr)
  return(student_details)
}
