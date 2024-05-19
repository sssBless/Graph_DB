USE master
GO

DROP DATABASE IF EXISTS SocialApp
GO

CREATE DATABASE SocialApp
GO

USE SocialApp
GO

CREATE TABLE [User] (
	Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	Username NVARCHAR(255) NOT NULL UNIQUE,
	[Password] NVARCHAR(255) NOT NULL
) AS NODE
GO

CREATE TABLE App (
	Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	AppName NVARCHAR(255) NOT NULL UNIQUE
) AS NODE
GO

CREATE TABLE Track (
	Id INT IDENTITY(1, 1) NOT NULL PRIMARY KEY,
	TrackName NVARCHAR(255) NOT NULL,
	Duration TIME(0) NOT NULL
) AS NODE
GO

CREATE TABLE FriendOf AS EDGE;
CREATE TABLE Uses AS EDGE;
CREATE TABLE Created AS EDGE;
CREATE TABLE Likes(Rating INT CHECK (Rating >= 0 AND Rating <= 10)) AS EDGE;

ALTER TABLE FriendOf
ADD CONSTRAINT EC_FriendOf CONNECTION ([User] TO [User]);

ALTER TABLE Uses
ADD CONSTRAINT EC_Uses CONNECTION ([User] TO App);

ALTER TABLE Created
ADD CONSTRAINT EC_Created CONNECTION ([User] TO Track);

ALTER TABLE Likes
ADD CONSTRAINT EC_Likes CONNECTION ([User] TO Track);

-- Вставка данных в таблицу [User]
INSERT INTO [User] (Username, [Password])
VALUES 
    ('John Smith', 'john_password'),
    ('Emily Johnson', 'emily_password'),
    ('Michael Brown', 'michael_password'),
    ('Sarah Davis', 'sarah_password'),
    ('James Wilson', 'james_password'),
    ('Jennifer Moritz', 'jennifer_password'),
    ('Robert Taylor', 'robert_password'),
    ('Linda Anderson', 'linda_password'),
    ('William Thomas', 'william_password'),
    ('Karen Clark', 'karen_password');

-- Вставка данных в таблицу App
INSERT INTO App (AppName)
VALUES 
    ('Music Maker'),
    ('Beat Builder'),
    ('Sound Studio'),
    ('Melody Creator'),
    ('Track Master'),
    ('Rhythm Composer'),
    ('Songwriter Pro'),
    ('Harmony Genius'),
    ('Chord Composer'),
    ('Lyricist Tool');

-- Вставка данных в таблицу Track
INSERT INTO Track (TrackName, Duration)
VALUES 
    ('Summer Vibes', '00:03:45'),
    ('Groove Machine', '00:04:10'),
    ('Dreamy Melodies', '00:02:55'),
    ('Funky Beats', '00:03:30'),
    ('Smooth Jazz', '00:05:20'),
    ('Electro Pop', '00:03:15'),
    ('Acoustic Jam', '00:04:45'),
    ('Rock Anthem', '00:03:50'),
    ('Hip Hop Hype', '00:04:25'),
    ('Classical Sonata', '00:06:00');

INSERT INTO FriendOf ($from_id, $to_id)
VALUES  ((SELECT $node_id FROM [User] WHERE id = 1),
		(SELECT $node_id FROM [User] WHERE id = 6)),		((SELECT $node_id FROM [User] WHERE id = 1),
		(SELECT $node_id FROM [User] WHERE id = 8)),		((SELECT $node_id FROM [User] WHERE id = 3),
		(SELECT $node_id FROM [User] WHERE id = 4)),		((SELECT $node_id FROM [User] WHERE id = 5),
		(SELECT $node_id FROM [User] WHERE id = 9)),		((SELECT $node_id FROM [User] WHERE id = 5),
		(SELECT $node_id FROM [User] WHERE id = 10)),		((SELECT $node_id FROM [User] WHERE id = 8),
		(SELECT $node_id FROM [User] WHERE id = 2)),		((SELECT $node_id FROM [User] WHERE id = 8),
		(SELECT $node_id FROM [User] WHERE id = 5)),		((SELECT $node_id FROM [User] WHERE id = 9),
		(SELECT $node_id FROM [User] WHERE id = 7)),		((SELECT $node_id FROM [User] WHERE id = 9),
		(SELECT $node_id FROM [User] WHERE id = 3)),		((SELECT $node_id FROM [User] WHERE id = 10),
		(SELECT $node_id FROM [User] WHERE id = 3));INSERT INTO Uses ($from_id, $to_id)
VALUES ((SELECT $node_id FROM [User] WHERE ID = 1),
		(SELECT $node_id FROM App WHERE ID = 1)),		((SELECT $node_id FROM [User] WHERE ID = 1),
		(SELECT $node_id FROM App WHERE ID = 6)),		((SELECT $node_id FROM [User] WHERE ID = 2),
		(SELECT $node_id FROM App WHERE ID = 7)),		((SELECT $node_id FROM [User] WHERE ID = 2),
		(SELECT $node_id FROM App WHERE ID = 8)),		((SELECT $node_id FROM [User] WHERE ID = 3),
		(SELECT $node_id FROM App WHERE ID = 9)),		((SELECT $node_id FROM [User] WHERE ID = 4),
		(SELECT $node_id FROM App WHERE ID = 6)),		((SELECT $node_id FROM [User] WHERE ID = 5),
		(SELECT $node_id FROM App WHERE ID = 3)),		((SELECT $node_id FROM [User] WHERE ID = 6),
		(SELECT $node_id FROM App WHERE ID = 1)),		((SELECT $node_id FROM [User] WHERE ID = 7),
		(SELECT $node_id FROM App WHERE ID = 5)),		((SELECT $node_id FROM [User] WHERE ID = 7),
		(SELECT $node_id FROM App WHERE ID = 10)),		((SELECT $node_id FROM [User] WHERE ID = 8),
		(SELECT $node_id FROM App WHERE ID = 2)),		((SELECT $node_id FROM [User] WHERE ID = 9),
		(SELECT $node_id FROM App WHERE ID = 5)),		((SELECT $node_id FROM [User] WHERE ID = 9),
		(SELECT $node_id FROM App WHERE ID = 4)),		((SELECT $node_id FROM [User] WHERE ID = 10),
		(SELECT $node_id FROM App WHERE ID = 4)),		((SELECT $node_id FROM [User] WHERE ID = 10),
		(SELECT $node_id FROM App WHERE ID = 3));
INSERT INTO Created ($from_id, $to_id)
VALUES ((SELECT $node_id FROM [User] WHERE ID = 1),
		(SELECT $node_id FROM Track WHERE ID = 1)),		((SELECT $node_id FROM [User] WHERE ID = 2),
		(SELECT $node_id FROM Track WHERE ID = 9)),		((SELECT $node_id FROM [User] WHERE ID = 3),
		(SELECT $node_id FROM Track WHERE ID = 4)),		((SELECT $node_id FROM [User] WHERE ID = 3),
		(SELECT $node_id FROM Track WHERE ID = 10)),		((SELECT $node_id FROM [User] WHERE ID = 4),
		(SELECT $node_id FROM Track WHERE ID = 2)),		((SELECT $node_id FROM [User] WHERE ID = 4),
		(SELECT $node_id FROM Track WHERE ID = 3)),		((SELECT $node_id FROM [User] WHERE ID = 5),
		(SELECT $node_id FROM Track WHERE ID = 8)),		((SELECT $node_id FROM [User] WHERE ID = 6),
		(SELECT $node_id FROM Track WHERE ID = 1)),		((SELECT $node_id FROM [User] WHERE ID = 6),
		(SELECT $node_id FROM Track WHERE ID = 5 )),		((SELECT $node_id FROM [User] WHERE ID = 7),
		(SELECT $node_id FROM Track WHERE ID = 6 )),		((SELECT $node_id FROM [User] WHERE ID = 8),
		(SELECT $node_id FROM Track WHERE ID = 5)),		((SELECT $node_id FROM [User] WHERE ID = 8),
		(SELECT $node_id FROM Track WHERE ID = 9)),		((SELECT $node_id FROM [User] WHERE ID = 9),
		(SELECT $node_id FROM Track WHERE ID = 9)),		((SELECT $node_id FROM [User] WHERE ID = 10),
		(SELECT $node_id FROM Track WHERE ID = 7));INSERT INTO Likes ($from_id, $to_id, rating)
VALUES ((SELECT $node_id FROM [User] WHERE ID = 1),
		(SELECT $node_id FROM Track WHERE ID = 5), 9),		((SELECT $node_id FROM [User] WHERE ID = 2),
		(SELECT $node_id FROM Track WHERE ID = 10), 7),		((SELECT $node_id FROM [User] WHERE ID = 3),
		(SELECT $node_id FROM Track WHERE ID = 8), 7),		((SELECT $node_id FROM [User] WHERE ID = 3),
		(SELECT $node_id FROM Track WHERE ID = 6), 10),		((SELECT $node_id FROM [User] WHERE ID = 4),
		(SELECT $node_id FROM Track WHERE ID = 1), 9),		((SELECT $node_id FROM [User] WHERE ID = 5),
		(SELECT $node_id FROM Track WHERE ID = 9), 10),		((SELECT $node_id FROM [User] WHERE ID = 5),
		(SELECT $node_id FROM Track WHERE ID = 7), 7),		((SELECT $node_id FROM [User] WHERE ID = 6),
		(SELECT $node_id FROM Track WHERE ID = 2), 7),		((SELECT $node_id FROM [User] WHERE ID = 6),
		(SELECT $node_id FROM Track WHERE ID = 3), 10),		((SELECT $node_id FROM [User] WHERE ID = 7),
		(SELECT $node_id FROM Track WHERE ID = 4), 10),		((SELECT $node_id FROM [User] WHERE ID = 7),
		(SELECT $node_id FROM Track WHERE ID = 10), 7),		((SELECT $node_id FROM [User] WHERE ID = 8),
		(SELECT $node_id FROM Track WHERE ID = 1), 10),		((SELECT $node_id FROM [User] WHERE ID = 9),
		(SELECT $node_id FROM Track WHERE ID = 5), 5),		((SELECT $node_id FROM [User] WHERE ID = 10),
		(SELECT $node_id FROM Track WHERE ID = 3), 10),		((SELECT $node_id FROM [User] WHERE ID = 10),
		(SELECT $node_id FROM Track WHERE ID = 4), 9);