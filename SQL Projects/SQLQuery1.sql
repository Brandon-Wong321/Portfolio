
SELECT --> columnNames
FROM --> tableName
WHERE --> conditional filters/ logic

-- year --> 1985
-- letter -- 'T'

SELECT StudentID, StudentFname, StudentLname, StudentBirth
FROM tblSTUDENT
WHERE StudentBirth >= 'January 1, 1985' AND StudentBirth <= 'December 31, 1985'
AND StudentLname LIKE 'T%'


-- Spring 1992

SELECT tblStudent.StudentID, StudentFname, StudentLname, StudentBirth, StudentPermCity
FROM tblSTUDENT
	JOIN tblCLASS_LIST ON tblStudent.StudentID = tblCLASS_LIST.StudentID
	JOIN tblCLASS ON tblCLASS_LIST.ClassID = tblCLASS.ClassID
	JOIN tblQUARTER ON tblCLASS.QuarterID = tblQuarter.QuarterID

WHERE tblCLASS.[Year] = '1992'
AND tblQUARTER.QuarterName = 'spring'
