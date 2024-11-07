USE INFO_330_Proj_16

-- Write the code to determine which Users have made a subscription within the past 5 years with type 'Premium'
-- who also 
-- listen to the Artist “Taylor Swift’
SELECT * FROM ANDWtblSubscription

SELECT U.UserID, U.UserFname, U.UserLname
FROM ANDWtblUser U
	JOIN ANDWtblSubscription S ON U.UserID = S.UserID
	JOIN ANDWtblSubscriptionType ST ON S.SubscriptionTypeID = ST.SubscriptionTypeID
WHERE S.SubscriptionBeginDate > DateAdd(Year, -5, GetDate())
AND ST.SubscriptionTypeName = 'Premium'
AND S.SubscriptionEndDate IS NULL


AND U.UserID IN (SELECT U.UserID
FROM ANDWtblUser U
	JOIN ANDWtblSubscription S ON U.UserID = S.UserID
	JOIN ANDWtblAccess AC ON S.SubscriptionID = AC.SubscriptionID
	JOIN ANDWtblRecording R ON AC.RecordingID = R.RecordingID
	JOIN ANDWtblSong SG ON R.RecordingID = SG.RecordingID
	JOIN ANDWtblArtist_Song_Role ASR ON SG.SongID = ASR.SongID
	JOIN ANDWtblArtist A ON ASR.ArtistID = A.ArtistID
WHERE A.ArtistFname = 'Taylor'
AND A.ArtistLname = 'Swift')


-- Write the code to determine the top 10 songs recorded in 2020 with the genre ‘Country’
-- who also
-- run Ads by 'Purple Uncle' longer than 30 seconds

SELECT TOP 10 S.SongID, S.SongName, COUNT(S.SongID)AS NumSongs
FROM ANDWtblSong S
 JOIN ANDWtblRecording R ON S.RecordingID = R.RecordingID
 JOIN ANDWtblGenre G ON R.GenreID = G.GenreID
WHERE R.RecordingDate >= '01-01-2020' AND R.RecordingDate <= '12-31-2021'
AND G.GenreName = 'Country'

AND S.SongID IN (SELECT S.SongID
FROM ANDWtblSong S
 JOIN ANDWtblRecording R ON S.RecordingID = R.RecordingID
 JOIN ANDWtblAccess A ON R.RecordingID = A.RecordingID
 JOIN ANDWtblAccess_Ad AA ON A.AccessID = AA.AccessID
 JOIN ANDWtblAdvertisement AD ON AA.AdvertisementID = AD.AdvertisementID
 JOIN ANDWtblCompany C ON AD.CompanyID = C.CompanyID
WHERE AD.SecondsDuration > '00:00:30'
AND C.CompanyName = 'Purple Uncle')

GROUP BY S.SongID, S.SongName
ORDER BY NumSongs



