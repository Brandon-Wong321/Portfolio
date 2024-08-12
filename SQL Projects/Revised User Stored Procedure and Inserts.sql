USE INFO_330_Proj_16

--Adding CountryID to tblUser

GO
ALTER TABLE ANDWtblUser
ADD CountryID INT FOREIGN KEY (CountryID)
    REFERENCES ANDWtblCountry(CountryID);
GO


-- Update tblUser with CountryID's

SELECT * FROM ANDWtblCountry
SELECT * FROM ANDWtblUser

UPDATE ANDWtblUser
SET CountryID = 1
WHERE UserID = 5


-- tblUser Insert 

INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES ((SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = 'Senior'), 'Marley', 'Rosberg', 'Formula1234', 'RosbergM@Gmail.com',
'3340 12th Ave. N', 'Anaheim', 'California', '05-12-1964', 'USA')

INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES ((SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = 'Adult'), 'Michael', 'Jordan', 'GOATBballPlayer', 'JordanM@gmail.com',
'1239 45th ST', 'Chicago', 'Illinois', '06-11-1962', 'USA')

INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES ((SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = 'Youth'), 'Lebron', 'James', 'LA4Lyfe', 'JamesLO@gmail.com',
'8800 126th Ct. NE', 'Los Angeles', 'California', '04-10-1982', 'USA')

-- Stored Procedure to insert a new user

ALTER PROCEDURE uspInsertUserANDW
@UseTname varchar (20),
@Fname varchar (20),
@Lname varchar (20),
@UsePname varchar (40),
@UseEmail varchar (40),
@UseAdd varchar (100),
@UseCity varchar (40),
@UseState varchar (20),
@DOB DATE,
@Cname varchar (20)
AS

DECLARE @UT_ID INT, @C_ID INT
SET @UT_ID = (SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = @UseTname)

SET @C_ID = (SELECT CountryID FROM ANDWtblCountry WHERE CountryName = @Cname)

BEGIN TRAN T1
INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB, CountryID)
VALUES (@UT_ID, @Fname, @Lname, @UsePname, @UseEmail, @UseAdd, @UseCity, @UseState, @DOB, @C_ID)
COMMIT TRAN T1
GO

EXECUTE uspInsertUserANDW
@UseTname = 'Youth',
@Fname = 'Wesley',
@Lname = 'Chan',
@UsePname = 'OptimusPrime64',
@UseEmail = 'ChanW@uw.edu',
@UseAdd = '6565 W Apple Dr',
@UseCity = 'Atlanta',
@UseState = 'Georgia',
@DOB = '1999-03-14',
@Cname = 'USA'

EXECUTE uspInsertUserANDW
@UseTname = 'Youth',
@Fname = 'Craig',
@Lname = 'Sager',
@UsePname = 'Sager4Ever',
@UseEmail = 'SagerC@uw.edu',
@UseAdd = '5333 S 37th St',
@UseCity = 'New Haven',
@UseState = 'Conneticut',
@DOB = '2003-11-06',
@Cname = 'USA'

EXECUTE uspInsertUserANDW
@UseTname = 'Senior',
@Fname = 'Daniel',
@Lname = 'Woo',
@UsePname = 'WooHoo99',
@UseEmail = 'WooD@uw.edu',
@UseAdd = '2312 E 7th St',
@UseCity = 'Topika',
@UseState = 'Kansas',
@DOB = '1933-03-05',
@Cname = 'USA'

EXECUTE uspInsertUserANDW
@UseTname = 'Youth',
@Fname = 'Mark',
@Lname = 'Shumskiy',
@UsePname = 'ShumChum89',
@UseEmail = 'ShumskiyM@uw.edu',
@UseAdd = '1009 SW 76th Way',
@UseCity = 'Monterey',
@UseState = 'California',
@DOB = '2001-02-01',
@Cname = 'USA'
