-- Write the query to determine the students 
-- 1. who have spent more than $3,000 in RegistrationFees for Information School classes after 2010 
-- 2. who also have completed at least 12 credits of Public Health courses before 2016. 


SELECT S.StudentID, S.StudentFName, S.StudentLname, SubQ1.TotalCredits, SUM(CL.RegistrationFee) AS TotatlRegistarationFees
FROM tblStudent S 
	JOIN tblClass_LIST CL ON S.StudentID = CL.StudentID
	JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
	JOIN tblCourse CR ON CS.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID

	JOIN (SELECT S.StudentID, S.StudentFName, S.StudentLname, SUM(CR.Credits) AS TotalCredits
			FROM tblStudent S 
				JOIN tblClass_LIST CL ON S.StudentID = CL.StudentID
				JOIN tblCLASS CS ON CL.ClassID = CS.ClassID
				JOIN tblCourse CR ON CS.CourseID = CR.CourseID
				JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
				JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
			WHERE CS.[Year] < '2016'
			AND C.CollegeName = 'Public Health'
			GROUP BY S.StudentID, S.StudentFName, S.StudentLname
			HAVING SUM(CR.Credits) >= 12) AS SubQ1 ON S.StudentID = SubQ1.StudentID

WHERE CS.[Year] > '2010'
AND C.CollegeName = 'Information School'
GROUP BY  S.StudentID, S.StudentFName, S.StudentLname, SubQ1.TotalCredits
HAVING SUM(CL.RegistrationFee) > 3000



SELECT *
FROM tblDEPARTMENT


-- Write the query to list the Top 3 departments in Arts and Sciences ordered by most students 
-- completing a class with a grade of less than 3.4 between 2004 and 2013. HINT: look for the number 
-- of DISTINCT individuals who meet the condition NOT the number of classes. :-)

SELECT TOP 3 D.DeptID, D.DeptName, COUNT(DISTINCT S.StudentID) AS NumIndividuals
FROM tblDEPARTMENT D
	JOIN tblCOLLEGE C ON D.CollegeID = C.CollegeID
	JOIN tblCourse CR ON D.DeptID = CR.DeptID		 
	JOIN tblCLASS CS ON CR.CourseID = CS.CourseID			 
	JOIN tblClass_LIST CL ON CS.ClassID = CL.ClassID
	JOIN tblSTUDENT S ON CL.StudentID = S.StudentID
				 
WHERE CL.Grade < 3.4
AND C.CollegeName = 'Arts and Sciences'
AND CS.[Year] BETWEEN '2004' AND '2013'
GROUP BY D.DeptID, D.DeptName
ORDER BY NumIndividuals DESC

-- Write the query to determine the newest building on South campus that has had a Geography class 
-- instructed by Greg Hay before winter 2015. 

SELECT TOP 1 B.BuildingID, B.BuildingName, B.YearOpened
FROM tblBUILDING B
	JOIN tblLOCATION L ON B.LocationID = L.LocationID
	JOIN tblCLASSROOM CSRM ON B.BuildingID = CSRM.BuildingID
	JOIN tblCLASS CS ON CSRM.ClassroomID = CS.ClassroomID
	JOIN tblCOURSE CR ON CS.CourseID = CR.CourseID
	JOIN tblQUARTER Q ON CS.QuarterID = Q.QuarterID
	JOIN tblINSTRUCTOR_CLASS ICS ON CS.ClassID = ICS.ClassID
	JOIN tblINSTRUCTOR I ON ICS.InstructorID = I.InstructorID
WHERE L.LocationName = 'South Campus'
AND CR.CourseName LIKE 'GEOG%'
AND I.InstructorFName = 'Greg'
AND I.InstructorLName = 'Hay'
AND Q.QuarterName = 'Winter'
AND CS.[Year] < '2015'
ORDER BY YearOpened DESC

-- Write the query to determine the staff person currently-employed who has been in their position the
-- longest for each college.

SELECT SF.StaffID, SF.StaffFname, SF.StaffLname -- CAST(DATEDIFF(DAY, BeginDate, GETDATE()) / 365.25 AS numeric(3, 1)) AS date_served
FROM tblSTAFF SF
JOIN tblSTAFF_POSITION SFP ON SF.StaffID = SFP.StaffID
JOIN tblDEPARTMENT D ON SFP.DeptID = D.DeptID
JOIN tblCOLLEGE CG ON D.CollegeID = CG.CollegeID
WHERE SFP.EndDate = NULL
ORDER BY CAST(DATEDIFF(Day, BeginDate, GETDATE()) / 365.25 AS numeric(3, 1))

-- Write the query to determine the TOP 3 classroom types (and their COUNT) that have been most-frequently
-- assigned for 300-level Anthropology courses since 1983.

SELECT TOP 3 CSRMT.ClassroomTypeID, CSRMT.ClassroomTypeName, COUNT(CR.CourseID) AS NumCoursesAssigned
FROM tblCLASSROOM_TYPE CSRMT
	JOIN tblCLASSROOM CSRM ON CSRMT.ClassroomTypeID = CSRM.ClassroomTypeID
	JOIN tblClass CS ON CSRM.ClassroomID = CS.ClassroomID
	JOIN tblCourse CR ON Cs.CourseID = CR.CourseID
	JOIN tblDEPARTMENT D ON CR.DeptID = D.DeptID
WHERE CR.CourseNumber LIKE '3__'
AND D.DeptName = 'Anthropology'
AND CS.[Year] >= '1983'
GROUP BY CSRMT.ClassroomTypeID, CSRMT.ClassroomTypeName

-- Write the code to create a stored procedure to hire a new person to an existing staff position. 

ALTER PROCEDURE bwongNewStf
@StfFname varchar(20),
@PNname varchar(20),
@BGN Date,
@END Date,
@Dptname varchar(20) 
AS

DECLARE @S_ID INT, @P_ID INT, @D_ID INT
SET @S_ID = (SELECT StaffID FROM tblSTAFF WHERE StaffFName = @StfFName)

SET @P_ID = (SELECT PositionID FROM tblPOSITION WHERE PositionName = @PNname)

SET @D_ID = (SELECT DeptID FROM tblDEPARTMENT WHERE DeptName = @Dptname)

BEGIN TRANSACTION T1
INSERT INTO tblSTAFF_POSITION (StaffID, PositionID, BeginDate, EndDate, DeptID)
VALUES (@StfFname, @PNname, @BGN, @END, @Dptname)
COMMIT TRANSACTION T1

EXECUTE bwongNewStf
@StfFname = 'Hayao',
@PNname = 'Dean',
@BGN = '1980-01-01',
@END = '2016-06-14',
@Dptname = 'History'

SELECT S.StaffFname


-- Write the code to create a stored procedure to create a new class of an existing course.

CREATE PROCEDURE bwongNewCS
@CRname varchar(20),
@Qname varchar (20),
@Year char(4),
@CMname varchar (20),
@SDname varchar (20),
@Section char (2)
AS

DECLARE @CR_ID INT, @Q_ID INT, @CM_ID INT, @SD_ID INT
SET @CR_ID = (SELECT CourseID FROM tblCOURSE WHERE CourseName = @CRname)

SET @Q_ID = (SELECT QuarterID FROM tblQUARTER WHERE QuarterName = @Qname)

SET @CM_ID = (SELECT ClassroomID FROM tblCLASSROOM WHERE ClassroomName = @CMname)

SET @SD_ID = (SELECT ScheduleID FROM tblSCHEDULE WHERE ScheduleName = @SDname)

BEGIN TRANSACTION T2
INSERT INTO tblCLASS (CourseID, QuarterID, [Year], ClassroomID, ScheduleID, Section)
VALUES (@CRname, @Qname, @Year, @CMname, @SDname, @Section)
COMMIT TRANSACTION T2

EXECUTE bwongNewCS
@CRname = 'CM 380',
@Qname = 'Summer',
@Year = '2008',
@CMname = 'KNE270',
@SDname = 'MonWed10',
@Section = 'ZZ'

-- Write the code to create a stored procedure to register an existing student to an existing class.
SELECT * 
FROM tblCLASS_LIST

CREATE PROCEDURE bwongNew_ClassList
@Sname varchar (20),
@Grde numeric(3,2),
@Rdate Date,
@Rfee numeric (5,2)
AS

DECLARE @S_ID INT
SET @S_ID = (SELECT StudentID FROM tblStudent WHERE StudentFName = @Sname)

BEGIN TRANSACTION T3
INSERT INTO tblCLASS_LIST (StudentID, Grade, RegistrationDate, RegistrationFee)
VALUES (@Sname, @Grde, @Rdate, @Rfee)
COMMIT TRANSACTION T3

EXECUTE bwongNew_ClassList
@Sname = 'John',
@Grde = 3.53,
@Rdate = '1996-02-24',
@Rfee = 20.00



