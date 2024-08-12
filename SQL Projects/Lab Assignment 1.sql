-- Write the SQL query to determine which students were born after November 5, 1996
SELECT StudentID, StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth >= 'November 5, 1996'

-- Write the SQL query to determine which buildings are on West Campus.

SELECT B.BuildingID, BuildingName, L.LocationName
FROM tblBUILDING B
	JOIN tblLOCATION L ON B.BuildingID = L.LocationID
WHERE L.LocationName = 'West Campus'

-- Write the SQL query to determine how many libraries are at UW.

SELECT COUNT(DISTINCT B.BuildingID) AS NumberOfLibraries
FROM tblBUILDING B
	JOIN tblBUILDING_TYPE BT ON B.BuildingTypeID = BT.BuildingTypeID
WHERE BT.BuildingTypeName = 'Library'

-- Write the code to return the 10 youngest students enrolled a course from Information School during winter quarter 2009.

SELECT TOP 10 S.StudentID, StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT S
	JOIN tblCLASS_LIST CL ON S.StudentID = CL.StudentID
    JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
    JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
    JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
    JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
    JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
WHERE Q.QuarterName = 'Winter'
AND CS.[Year] = 2009
AND CR.CourseName LIKE 'INFO%'
ORDER BY StudentBirth DESC

-- Write the code that exhibits the 5 oldest buildings on UW campus by the year that they were opened.

SELECT TOP 5 B.BuildingName, YearOpened
FROM tblBUILDING B
ORDER BY YearOpened

-- Write the SQL query to list the Department that hired the most people to the position type 'Executive' between June 8, 1968 and March 6, 1989.

SELECT TOP 1 D.DeptID, D.DeptName, PT.PositionTypeName, SUM(SP.StaffID) AS TotalExecsHired
FROM tblDEPARTMENT D
	JOIN tblSTAFF_POSITION SP ON D.DeptID = SP.DeptID
	JOIN tblPOSITION P ON SP.PositionID = P.PositionID
	JOIN tblPOSITION_TYPE PT ON P.PositionTypeID = PT.PositionTypeID
WHERE PT.PositionTypeName = 'Executive'
AND SP.BeginDate >= 'June 8, 1968'
AND Sp.EndDate <= 'March 6, 1989'
GROUP BY D.DeptID, D.DeptName, PT.PositionTypeName
ORDER BY TotalExecsHired DESC

-- Write the SQL query to determine which current instructor has been a Senior Lecturer the longest.
SELECT TOP 1 I.InstructorID, InstructorFName, InstructorLName, CAST(DATEDIFF(DAY, BeginDate, GETDATE()) / 365.25 AS numeric(3, 1)) AS date_served
FROM tblINSTRUCTOR I
	JOIN tblINSTRUCTOR_INSTRUCTOR_TYPE IIT ON I.InstructorID = IIT.InstructorID
	JOIN tblINSTRUCTOR_TYPE ITYP ON IIT.InstructorTypeID = ITYP.InstructorTypeID
WHERE ITYP.InstructorTypeName = 'Senior Lecturer'
AND IIT.EndDate is NULL
ORDER BY date_served DESC


-- Write the SQL query to determine which College offer the most courses Spring quarter 2014.

SELECT TOP 1 CG.CollegeID, CG.CollegeName, COUNT(CR.CourseID) AS total_Courses_Offered
FROM tblCOLLEGE CG
	JOIN tblDEPARTMENT D ON CG.CollegeID = D.CollegeID
	JOIN tblCOURSE CR ON D.DeptID = CR.DeptID
	JOIN tblCLASS C ON CR.CourseID = C.CourseID
	JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
WHERE Q.QuarterName = 'Spring'
AND C.[Year] = 2014
GROUP BY CG.CollegeID, CG.CollegeName
ORDER By total_Courses_Offered DESC


-- Write the SQL query to determine which courses were held in large lecture halls or auditorium type classrooms summer 2016. 

SELECT CS.CourseID, CourseName, CourseNumber, CT.ClassroomTypeName
FROM tblCOURSE CS
	JOIN tblCLASS C ON CS.CourseID = C.CourseID
	JOIN tblCLASSROOM CR ON C.ClassroomID = Cr.ClassroomID
	JOIN tblCLASSROOM_TYPE CT ON CR.ClassroomTypeID = CT.ClassroomTypeID
	JOIN tblQUARTER Q ON C.QuarterID = Q.QuarterID
WHERE Q.QuarterName = 'Summer'
AND C.[Year] = 2016
AND CT.ClassroomTypeName = 'Large Lecture Hall'
OR CT.ClassroomTypeName = 'Auditorium'


