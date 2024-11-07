CREATE TABLE ANDWtblAlbum_Recording
(AlbumRecordingID INTEGER IDENTITY(1,1) primary key,
AlbumID INT FOREIGN KEY REFERENCES ANDWtblAlbum(AlbumID) not null,
RecordingID INT FOREIGN KEY REFERENCES ANDWtblRecording(RecordingID) not null)
GO

CREATE TABLE ANDWtblGenre
(GenreID INTEGER IDENTITY(1,1) primary key,
GenreName varchar(20) not null,
GenreDescription varchar(100) null)
GO

CREATE TABLE ANDWtblStudio
(StudioID INTEGER IDENTITY(1,1) primary key,
StudioName varchar(20) not null,
StudioDescription varchar(100) null)
GO

CREATE TABLE ANDWtblCountry
(CountryID INTEGER IDENTITY(1,1) primary key,
CountryName varchar(20) not null)
GO

CREATE TABLE ANDWtblUser
(UserID INTEGER IDENTITY(1,1) primary key,
UserTypeID INT FOREIGN KEY REFERENCES ANDWtblUser_Type(UserTypeID) not null,
UserFname varchar(20) not null,
UserLname varchar(20) not null,
UserProfileName varchar (40) not null,
UserEmail varchar (40) not null,
UserAddress varchar (100) not null,
UserCity varchar (40) not null,
UserState (20) not null,
UserDOB DATE not null)
GO

CREATE TABLE ANDWtblUser_Type
(UserTypeID INTEGER IDENTITY(1,1) primary key,
UserTypeName varchar(20) not null,
UserTypeDescription varchar(100) not null)
GO
