USE INFO_330_Proj_16

--Adding CountryID to tblUser

GO
ALTER TABLE ANDWtblUser
ADD CountryID INT FOREIGN KEY (CountryID)
    REFERENCES ANDWtblCountry(CountryID);
GO


--User Insert 

INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES ((SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = 'Senior'), 'John', 'Lasseter', 'MickeyM1984', 'LasseterJ@Gmail.com',
'3340 12th Ave. N', 'Anaheim', 'California', '05-12-1964')

INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES ((SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = 'Adult'), 'Michael', 'Jordan', 'GOATBballPlayer', 'JordanM@gmail.com',
'1239 45th ST', 'Chicago', 'Illinois', '06-11-1962')

INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES ((SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = 'Youth'), 'Lebron', 'James', 'LA4Lyfe', 'JamesLO@gmail.com',
'8800 126th Ct. NE', 'Los Angeles', 'California', '04-10-1982')


-- Album Recording Insert
INSERT INTO ANDWtblAlbum_Recording (AlbumID, RecordingID)
VALUES ((SELECT AlbumID FROM ANDWtblAlbum WHERE AlbumName = 'Doo-Wops and Hooligans'), (SELECT RecordingID FROM ANDWtblRecording WHERE RecordingName = 'Take 35'))

INSERT INTO ANDWtblAlbum_Recording (AlbumID, RecordingID)
VALUES ((SELECT AlbumID FROM ANDWtblAlbum WHERE AlbumName = 'Tuxedo'), (SELECT RecordingID FROM ANDWtblRecording WHERE RecordingName = 'Take 22'))

INSERT INTO ANDWtblAlbum_Recording (AlbumID, RecordingID)
VALUES ((SELECT AlbumID FROM ANDWtblAlbum WHERE AlbumName = '24K Magic'), (SELECT RecordingID FROM ANDWtblRecording WHERE RecordingName = 'Take 77'))


--Stored Procedures

ALTER PROCEDURE uspInsertUserANDW
@UseTname varchar (20),
@Fname varchar (20),
@Lname varchar (20),
@UsePname varchar (40),
@UseEmail varchar (40),
@UseAdd varchar (100),
@UseCity varchar (40),
@UseState varchar (20),
@DOB DATE
AS

DECLARE @UT_ID INT
SET @UT_ID = (SELECT UserTypeID FROM ANDWtblUser_Type WHERE UserTypeName = @UseTname)

BEGIN TRAN T1
INSERT INTO ANDWtblUser (UserTypeID, UserFname, UserLname, UserProfileName, UserEmail, UserAddress, UserCity, UserState, UserDOB)
VALUES (@UT_ID, @Fname, @Lname, @UsePname, @UseEmail, @UseAdd, @UseCity, @UseState, @DOB)
COMMIT TRAN T1
GO

EXECUTE uspInsertUserANDW
@UseTname = 'Adult',
@Fname = 'Winston',
@Lname = 'Guy',
@UsePname = 'Megatron626',
@UseEmail = 'GuyW@uw.edu',
@UseAdd = '4587 E Cherry Ln',
@UseCity = 'Jacksonville',
@UseState = 'Florida',
@DOB = '1987-05-04'

EXECUTE uspInsertUserANDW
@UseTname = 'Youth',
@Fname = 'Craig',
@Lname = 'Sager',
@UsePname = 'Sager4Ever',
@UseEmail = 'SagerC@uw.edu',
@UseAdd = '5333 S 37th St',
@UseCity = 'New Haven',
@UseState = 'Conneticut',
@DOB = '2003-11-06'

EXECUTE uspInsertUserANDW
@UseTname = 'Senior',
@Fname = 'Daniel',
@Lname = 'Woo',
@UsePname = 'WooHoo99',
@UseEmail = 'WooD@uw.edu',
@UseAdd = '2312 E 7th St',
@UseCity = 'Topika',
@UseState = 'Kansas',
@DOB = '1933-03-05'

SELECT * FROM ANDWtblAlbum_Recording

-- tblAlbumRecording

ALTER PROCEDURE uspInsertAlbumRecordingANDW
@Aname varchar (30),
@Rname varchar (20)
AS

DECLARE @A_ID INT, @R_ID INT

SET @A_ID = (SELECT AlbumID FROM ANDWtblAlbum WHERE AlbumName = @Aname)

SET @R_ID = (SELECT RecordingID FROM ANDWtblRecording WHERE RecordingName = @Rname)

BEGIN TRAN T2
INSERT INTO ANDWtblAlbum_Recording (AlbumID, RecordingID)
VALUES (@A_ID, @R_ID)
COMMIT TRAN T2
GO

SELECT * FROM ANDWtblRecording
SELECT * FROM ANDWtblAlbum
SELECT * FROM ANDWtblAlbum_Recording

EXECUTE uspInsertAlbumRecordingANDW
@Aname = 'Doo-Wops and Hooligans',
@Rname = 'Take 35'

EXECUTE uspInsertAlbumRecordingANDW
@Aname = 'Tuxedo',
@Rname = 'Take 22'

EXECUTE uspInsertAlbumRecordingANDW
@Aname = '24K Magic',
@Rname = 'Take 77'
