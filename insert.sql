-- populating multimedia table
INSERT INTO Multimedia(ID, ordering, genres, Original_Title, plot_outline)
SELECT titles.x1, titles.x2, t1.x9, titles.x3, t1.x3
FROM titles, t1
WHERE t1.x2 != 'tvEpisode' and titles.x1 = t1.x1;
---------------------------
ALTER TABLE Multimedia RENAME TO Multimedia1;
CREATE TABLE Multimedia (
    ID TEXT, 
    ordering INT,
    Original_Title TEXT , 
    plot_outline TEXT , 
    genres TEXT, 
    Anti_social_elements TEXT,
    soundtrack TEXT,
    websites TEXT
);
-- sorting the Multimedia table in reference with serial no.(by using a duplicate table Multimedia1)
INSERT INTO Multimedia
(select ID, ordering, Original_Title, plot_outline, genres, Anti_social_elements, soundtrack, websites from Multimedia1 ORDER BY ID, ordering);
ALTER TABLE Multimedia ADD COLUMN Serial_no SERIAL PRIMARY KEY;
DROP TABLE Multimedia1;
---------------------------------------------------------------------


-- populating movies table
INSERT INTO Movies(Movie_ID, ordering, movie_name, lang, Rating)
SELECT titles.x1, titles.x2, titles.x3, titles.x5, t6.x2
FROM titles, t6, t1
WHERE titles.x1 = t1.x1 AND titles.x1 = t6.x1 AND t1.x2 != 'tvSeries' AND t1.x2 != 'tvEpisode';

-------------------------------------
ALTER TABLE Movies RENAME TO Movies1;
CREATE TABLE Movies
(
  Movie_ID TEXT, 
  ordering INT NOT NULL, 
  Movie_name TEXT, 
  lang TEXT,
  Rating NUMERIC(3,1)
);
-- sorting the Movies table in reference with serial no.(by using a duplicate table Movies1)
INSERT INTO Movies
(select Movie_ID, ordering, Movie_name, lang, Rating from Movies1 ORDER BY Movie_ID, ordering);
ALTER TABLE Movies ADD COLUMN MSerial_no SERIAL PRIMARY KEY;
DROP TABLE Movies1;
---------------------------------------------------------------------


-- populating TV_series table
INSERT INTO TV_series(TV_series_ID,ordering, Name_, lang, Rating)
SELECT titles.x1, titles.x2, titles.x3, titles.x5, t6.x2
FROM titles, t1, t6
WHERE titles.x1 = t1.x1 AND t6.x1 = t1.x1 AND t1.x2 = 'tvSeries';
-------------------------------------------
ALTER TABLE TV_series RENAME TO TV_series1;
CREATE TABLE TV_series
(
  TV_series_ID TEXT, 
  ordering INT, 
  Name_ TEXT , 
  lang TEXT, 
  No_of_episodes INT, 
  Rating NUMERIC(3,1) 
);
-- sorting the TV_series table in reference with serial no.(by using a duplicate table TV_series)
INSERT INTO TV_series
(select TV_series_ID, ordering, Name_, lang, No_of_episodes, Rating from TV_series1 ORDER BY TV_series_ID, ordering);
ALTER TABLE TV_series ADD COLUMN TSerial_no SERIAL PRIMARY KEY;
DROP TABLE TV_series1;
-------------------------------------------------------------------------------------------

INSERT INTO Episodes(Episode_ID, ep_ordering, Episode_name, TV_series_ID, Season_Number, Episode_Number, lang, Rating)
SELECT titles.x1, titles.x2, titles.x3, t4.x2, t4.x3, t4.x4, titles.x5, t6.x2
FROM titles,t4, t6, t1
WHERE titles.x1 = t4.x1 AND t4.x1 = t6.x1 AND titles.x1 = t1.x1 AND t1.x2 = 'tvEpisode';

------------------------------------------------------------------------------------------------
ALTER TABLE Episodes RENAME TO Episodes1;

CREATE TABLE Episodes 
(
  Episode_ID TEXT,
  ep_ordering INT,
  Episode_name TEXT,
  TV_series_ID TEXT,
  Season_Number INT,
  Episode_Number INT,
  lang TEXT, 
  Rating NUMERIC(3,1)
);

-- sorting the Episodes table in reference with serial no.(by using a duplicate table Episodes1)
INSERT INTO Episodes
(select Episode_ID, ep_ordering, Episode_name, TV_series_ID, Season_Number, Episode_Number, lang, Rating from Episodes1 ORDER BY Episode_ID, ep_ordering);

ALTER TABLE Episodes ADD COLUMN ESerial_no SERIAL PRIMARY KEY;
DROP TABLE Episodes1;
------------------------------------------------------------------------------------------

-- populating Crew table
INSERT INTO Crew(Crew_ID, Name_, Year_of_Birth, Year_of_Death, No_of_known_films, Top_three_professions)
SELECT t7.x1, t7.x2, t7.x3, t7.x4, length(t7.x6) - length(replace(t7.x6, ',', '')), t7.x5
FROM t7;

-- populating Locality table
INSERT INTO Locality(Region_name) -- DISTINCT REGIONS TO BE FILLED
SELECT titles.x4
FROM titles
GROUP BY titles.x4
;

-- populating mu_worked_by table
INSERT INTO  mu_worked_by(Serial_no, ID,Crew_ID,Role_)
SELECT Multimedia.Serial_no, t5.x1, t5.x3, t5.x4
FROM t5, Multimedia
WHERE Multimedia.ID = t5.x1 AND Multimedia.ordering = t5.x2
;

-- populating ep_worked_by table
INSERT INTO ep_worked_by(Serial_no, Crew_ID, Episode_ID, TV_series_ID, Role_)
SELECT Episodes.ESerial_no, t5.x3, t5.x1 ,t4.x2, t5.x4 
FROM t5, t4, Episodes
WHERE Episodes.Episode_ID = t5.x1 AND Episodes.ep_ordering = t5.x2 AND t4.x1 = t5.x1
;

-- populating Air_info table
INSERT INTO Air_info(Serial_no, Location_ID,Air_date)
SELECT Episodes.ESerial_no, Locality.Location_ID , t1.x6
FROM t1,Episodes, Locality, titles
WHERE Episodes.Episode_ID = t1.x1 AND Episodes.Episode_ID = titles.x1 AND 
Episodes.ep_ordering = titles.x2 AND Locality.Region_name = titles.x4
;

-- populating release_info table
INSERT INTO release_info(Serial_no,Location_ID,runtime,release_date)
SELECT Movies.MSerial_no, Locality.Location_ID, t1.x8, t1.x6
FROM Movies, Locality, t1, titles
WHERE Movies.Movie_ID = t1.x1 AND Movies.Movie_ID = titles.x1 AND
Movies.ordering = titles.x2 AND Locality.Region_name = titles.x4
;

-- populating run_info table
INSERT INTO run_info(Serial_no, Location_ID, startDate, endDate, runtime)
SELECT TV_series.TSerial_no, Locality.Location_ID, t1.x6 , t1.x7 , t1.x8
FROM TV_series, Locality, t1, titles
WHERE TV_series.TV_series_ID = t1.x1 AND TV_series.TV_series_ID = titles.x1 AND 
TV_series.ordering = titles.x2 AND Locality.Region_name = titles.x4
;

DROP TABLE titles;
DROP TABLE t1;
DROP TABLE t2;
DROP TABLE t3;
DROP TABLE t4;
DROP TABLE t5;
DROP TABLE t6;
DROP TABLE t7;
