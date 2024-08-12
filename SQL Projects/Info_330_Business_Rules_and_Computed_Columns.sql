USE INFO_330_Proj_16

--Business Rules

--No album released before ‘January 1, 2015’ can have the genre name ‘Heavy Metal’ 


ALTER FUNCTION fn_NoAlbumHeavyMetal()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT *
FROM ANDWtblALBUM A
	JOIN ANDWtblAlbum_Recording AR ON A.AlbumID = AR.AlbumID
	JOIN ANDWtblRecording R ON AR.RecordingID = R.RecordingID
	JOIN ANDWtblGenre G ON R.GenreID = G.GenreID
WHERE A.AlbumReleaseDate < '2015-01-01'
AND G.GenreName = 'Heavy Metal')
SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE ANDWtblAlbum_Recording
ADD CONSTRAINT CK_NoAlbumHeavyMetalBefore1960
CHECK (dbo.fn_NoAlbumHeavyMetal() = 0)


--No Artists with role type ‘Vocalist’ younger than 18 can have an Advertisement type ‘video’


ALTER FUNCTION fn_NoArtistsYounger18AdVideo()
RETURNS INT
AS
BEGIN

DECLARE @RET INT = 0
IF EXISTS (SELECT *
	FROM ANDWtblArtist A
		JOIN ANDWtblArtist_Song_Role ASR ON A.ArtistID = ASR.ArtistID
		JOIN ANDWtblRole RL ON ASR.RoleID = RL.RoleID
		JOIN ANDWtblSong SG ON ASR.SongID = SG.SongID
		JOIN ANDWtblRecording R ON SG.RecordingID = R.RecordingID
		JOIN ANDWtblAccess AC ON R.RecordingID = AC.RecordingID
		JOIN ANDWtblAccess_Ad AA ON AC.AccessID = AA.AccessID
		JOIN ANDWtblAdvertisement AD ON AA.AdvertisementID = AD.AdvertisementID
		JOIN ANDWtblAdvertisment_Type ADT ON AD.AdvertisementTypeID = ADT.AdvertismentTypeID 
	WHERE RL.RoleName = 'Vocalist'
	AND A.ArtistDOB < DateAdd(Year, -18, GetDate())
	AND ADT.AdvertisementTypeName = 'Video')
SET @RET = 1

RETURN @RET
END
GO

ALTER TABLE ANDWtblAccess_Ad
ADD CONSTRAINT CK_NoArtistsYounger18AdVideo
CHECK (dbo.fn_NoArtistsYounger18AdVideo() = 0)


-- Computed Columns
-- Create the computed column to measure the total number of Artists with the role ‘Writer’ and is between 25 and 40 years old from each country 

CREATE FUNCTION fn_NumWriters25To40(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (SELECT COUNT(*)
	FROM ANDWtblCountry C
		JOIN ANDWtblArtist A ON C.CountryID = A.CountryID
		JOIN ANDWtblArtist_Song_Role ASR ON A.ArtistID = ASR.ArtistID
		JOIN ANDWtblRole R ON ASR.RoleID = R.RoleID
WHERE R.RoleName = 'Writer'
AND A.ArtistDOB > DateAdd(Year, -40, GetDate()) AND A.ArtistDOB < DateAdd(Year, -25, GetDate())
AND C.CountryID = @PK)

RETURN @RET
END
GO

ALTER TABLE ANDWtblCountry
ADD Calc_Num_writers_25To40Country AS (dbo.fn_NumWriters25To40(CountryID))


--Create the computed column to measure the total number of songs recorded at each studio in the last 5 years

CREATE FUNCTION fn_NumSongsPerStudioLast5(@PK INT)
RETURNS INT
AS
BEGIN
DECLARE @RET INT = (SELECT COUNT(*)
	FROM ANDWtblStudio S
	JOIN ANDWtblRecording R ON S.StudioID = R.StudioID
	JOIN ANDWtblSong SG ON R.RecordingID = SG.RecordingID
WHERE SG.DatePublished > DateAdd(Year, -5, GetDate())
AND S.StudioID = @PK)

RETURN @RET
END
GO

ALTER TABLE ANDWtblStudio
ADD Calc_Num_Songs_each_Studio_last5 AS (dbo.fn_NumSongsPerStudioLast5(StudioID))
