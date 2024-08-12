-- Write the SQL to determine which customers have booked more than 5 flights between March 3, 2015 
-- and November 12, 2018 arriving in airports in the region of South America 
-- who have also
-- booked fewer than 10 total flights on planes from Boeing Airplane manufacturer before January 15, 2019.
 
 SELECT C.CustomerID, C.CustomerFname, C.CustomerLname, COUNT(B.BookingID) AS NumBookings
 FROM tblCUSTOMER C 
	JOIN tblBOOKING BK ON C.CustomerID = BK.BookingID
	JOIN tblROUTE_FLIGHT RF ON BK.RouteFlightID = RF.RouteFlightID
	JOIN tblFLIGHT F ON RF.FlightID = F.FlightID
	JOIN tblAIRPORT A ON  F.ArrivalAirportID = A.AirportID
	JOIN tblCITY CI ON A.CityID = CI.CityID
	JOIN tblCOUNTRY CY ON CI.CountryID = CY.CountryID
	JOIN tblREGION R ON CY.RegionID = R.RegionID

	JOIN (SELECT C.CustomerID, C.CustomerFname, C.CustomerLname, COUNT(B.BookingID) AS NumBookings
		 FROM tblCUSTOMER C 
			JOIN tblBOOKING BK ON C.CustomerID = BK.BookingID
			JOIN tblSEAT_PLANE SP ON BK.SeatPlaneClassID = SP.SeatPlaneClassID
			JOIN tblPLANE P ON SP.PlaneID = P.PlaneID
			JOIN tblMANUFACTURER M ON P.MfgID = M.MfgID
		WHERE M.MfgName = 'Boeing Airplane manufaturer'
		AND BK.BookingDateTime < 'January 15, 2019'
		GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
		HAVING COUNT(B.BookingID) < '10') AS SubQ1 ON C.CustomerID = SubQ1.CustomerID

WHERE BK.BookingDateTime > 'March 3, 2015' AND BK.BookingDateTime < 'November 12, 2018'
AND R.RegionName = 'South America'
GROUP BY C.CustomerID, C.CustomerFname, C.CustomerLname
HAVING COUNT(B.BookingID) > '5'

 

-- Write the SQL to determine which employees served in the role of ‘captain’ on greater than 11 flights 
-- departing from airport type of ‘military’ from the region of North America
-- who also
-- served in the role of ‘Chief Navigator’ no more than 5 flights arriving to airports in Japan.

SELECT E.EmployeeID, EmployeeFname, EmployeeLname, COUNT(*) AS NumFlights
FROM tblEMPLOYEE E
	JOIN tblFLIGHT_EMPLOYEE FE ON E.EmployeeID = FE.EmployeeID
	JOIN tblROLE R ON FE.RoleID = R.RoleID
	JOIN tblFLIGHT F ON FE.FlightID = F.FlightID
	JOIN tblAIRPORT A ON F.DepartAirportID = A.AirportID
	JOIN tblAIRPORT_TYPE APT ON A.AirportTypeID = APT.AiportTypeID
	JOIN tblCITY C ON A.CityID = C.CityID
	JOIN tblCOUNTRY CY ON C.CountryID = CY.CountryID
	JOIN tblREGION RG ON CY.RegionID = RG.RegionID

	JOIN (SELECT E.EmployeeID, EmployeeFname, EmployeeLname, COUNT(*) AS NumFlights
		 FROM tblEMPLOYEE E
			JOIN tblFLIGHT_EMPLOYEE FE ON E.EmployeeID = FE.EmployeeID
			JOIN tblROLE R ON FE.RoleID = R.RoleID
			JOIN tblFLIGHT F ON FE.FlightID = F.FlightID
			JOIN tblAIRPORT A ON F.DepartAirportID = A.AirportID
			JOIN tblCITY C ON A.CityID = C.CityID
			JOIN tblCOUNTRY CY ON C.CountryID = CY.CountryID
		WHERE R.RoleName = 'Chief Navigator'
		AND CY.CountryName = 'Japan'
		GROUP BY E.EmployeeID, EmployeeFname, EmployeeLname
		HAVING COUNT(*) <= 5) AS SubQ1 ON E.EmployeeID = SubQ1.EmployeeID

WHERE R.RoleName = 'captain'
AND APT.AirportTypeName = 'military'
AND R.RegionName = 'North America'
GROUP BY E.EmployeeID, EmployeeFname, EmployeeLname
HAVING COUNT(*) > 11






-- Write the SQL to create a stored procedure to UPDATE the EMPLOYEE table with new values for City, State and Zip. 
-- Use the following parameters: @Fname, @Lname, @Birthdate, @NewCity, @NewState, @NewZip

 CREATE PROCEDURE uspbwongUPDATE_Employee
 @Fname varchar (20),
 @Lname varchar (20),
 @DOB Date,
 @OldCity varchar (20),
 @NewCity varchar (20),
 @OldState varchar (20),
 @NewState varchar (20),
 @OldZip varchar (50),
 @NewZip varchar (50),
 @Email varchar (50),
 @Phone varchar (10)
 AS

 DECLARE @EID INT 
 SET @EID = (SELECT EmployeeID FROM tblEMPLOYEE WHERE EmployeeFname = @Fname AND EmployeeLname = @Lname AND EmployeeDOB = @DOB
 AND EmployeeCity = @OldCity AND EmployeeState = @OldState AND EmployeeZip = @OldZip AND EmployeeEmail = @Email AND EmployeePhone = @Phone)

 BEGIN TRAN T1
 UPDATE tblEMPLOYEE
 SET EmployeeCity = @NewCity, EmployeeState = @NewState, EmployeeZip = @NewZip
 WHERE EmployeeID = @EID
 COMMIT TRAN T1
 GO


-- Write the SQL to create enforce the following business rule:
-- “No employee younger than 28 years old may serve the role of ‘Principal Engineer’ for routes
-- named ‘Around the world over the Arctic’ scheduled to depart in the month of December”  
CREATE FUNCTION fn_NoEmpYounger28()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT * 
FROM tblEMPLOYEE E 
	JOIN tblFLIGHT_EMPLOYEE FE ON E.EmployeeID = FE.EmployeeID
	JOIN tblROLE R ON FE.RoleID = R.RoleID
	JOIN tblFLIGHT F ON FE.FlightID = F.FlightID
	JOIN tblROUTE_FLIGHT RF ON F.FlightID = RF.FlightID
	JOIN tblROUTE RT ON RF.RouteID = RT.RouteID
WHERE E.EmployeeDOB > DateAdd(YEAR, -28 ScheduledDepart)
AND R.RoleName = 'Principal Engineer'
AND RT.RouteName = 'Around the world over the Arctic'
AND MONTH(F.ScheduledDepart) = 12

SET @RET = 1

RETURN @RET
END
GO
 
 ALTER TABLE tblROUTE_FLIGHT
ADD CONSTRAINT CK_Emp28_NoDec
CHECK (dbo.fn_NoEmpYounger28() = 0)


-- Write the SQL to create enforce the following business rule:
-- “No more than 12,500 pounds of baggage may be booked on planes of type ‘Puddle Jumper’” 

CREATE FUNCTION fn_NoBagOver12500()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT * 
FROM BAG B 
	JOIN tblBOOKING BK ON B.BookingID = BK.BookingID
	JOIN tblSEAT_PLANE SP ON BK.SeatPlaneClassID = SP.SeatPlaneClassID
	JOIN tblPLANE P ON SP.PlaneID = P.PlaneID
	JOIN tblPLANE_TYPE PT ON P.PlaneTypeID = PT.PlaneTypeID
WHERE B.[Weight] > '12,500'
AND PT.PlaneType = 'Puddle Jumper'
SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE tblSEAT_PLANE
ADD CONSTRAINT CK_No_BagsOver12500OnPJ
CHECK (dbo.fn_NoBagOver12500() = 0)