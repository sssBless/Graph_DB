-- 1) Найдем всех пользователей, которые используют то же приложение, что и конкретный пользователь
SELECT DISTINCT user1.Username, user2.Username, App.AppName
FROM [User] AS user1
	, Uses AS U1
	, [User] AS user2
	, App
	, Uses AS U2
WHERE MATCH(user1-(U1)->App<-(U2)-user2) AND user1.Username = N'John Smith' AND user1.Username <> user2.Username

-- 2) Найдем все песни друзей конкретного пользователя
SELECT user2.Username, T.TrackName
FROM [User] AS user1
	    , FriendOf AS friend
		, [User] AS user2
		, Created AS cr
		, Track AS T
WHERE MATCH(user1-(friend)->user2-(cr)->T) AND user1.Username = N'John Smith'

-- 3) Найдем кто и как оценили трек конкретного пользователя
SELECT user1.Username AS Author, t.TrackName, user2.Username, l.Rating
FROM [User] AS user1
	, Created AS cr
	, Track AS t
	, Likes AS l
	, [User] AS user2
WHERE MATCH(user1-(cr)->t<-(l)-user2) AND user1.Username = N'John Smith'

-- 4) Найдем всех пользователей, использующих конкретное приложение для создания музыки
SELECT user1.Username, app.AppName
FROM [User] AS user1
		, Uses AS u
		, App AS app
WHERE MATCH (user1-(u)->app) AND app.AppName = N'Melody Creator'

-- 5) Найдем все оценки конкретного пользователя
SELECT user1.Username, t.TrackName ,l.Rating
FROM [User] AS user1
	 , Likes AS l
	 , Track AS t
WHERE MATCH(user1-(l)->t) AND user1.Username = N'Robert Taylor'

-- 6) Предположим: 2 пользователя хотят создать вместе трек и им нужно найти друг друга, тогда:

DECLARE @userFrom AS NVARCHAR(30) = N'John Smith';
DECLARE @userTo AS NVARCHAR(30) = N'Sarah Davis';
WITH T1 AS
(
SELECT user1.username AS userName
 , STRING_AGG(user2.username, ' -> ') WITHIN GROUP (GRAPH PATH)
AS Friends
 , LAST_VALUE(user2.username) WITHIN GROUP (GRAPH PATH) AS
LastNode
FROM [user] AS user1
 , FriendOf FOR PATH AS fo
 , [user] FOR PATH AS user2
WHERE MATCH(SHORTEST_PATH(user1(-(fo)->user2)+))
 AND user1.username = @userFrom
)
SELECT userName, Friends
FROM T1
WHERE LastNode = @userTo;

-- 7) ПУсть некоторый пользователь хочет познакомиться с друзьями друзей для расширения своей сети друзейб тогда:
SELECT user1.username AS userName
 , STRING_AGG(user2.username, '->') WITHIN GROUP (GRAPH PATH)
AS Friends
FROM [User] AS user1
 , FriendOf FOR PATH AS fo
 , [User] FOR PATH AS user2
WHERE MATCH(SHORTEST_PATH(user1(-(fo)->user2){1,2}))
 AND user1.username = N'James Wilson';