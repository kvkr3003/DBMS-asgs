-- INSERT INTO Multimedia(ID, ordering, genres, Original_Title, plot_outline)
-- SELECT titles.x1, titles.x2, t1.x9, titles.x3, t1.x3
-- FROM titles, t1
-- WHERE t1.x2 != 'tvEpisode' and titles.x1 = t1.x1;

-- ---------------------------
-- ALTER TABLE Multimedia RENAME TO Multimedia1;

-- CREATE TABLE Multimedia (
--     --Serial_no SERIAL,
--     ID TEXT, ---  tiltle.basics x1
--     ordering INT,
--     Original_Title TEXT , -- title.basics x4
--     plot_outline TEXT , -- title.basics x3
--     genres TEXT, ---  tiltle.basics x9

--     Anti_social_elements TEXT,
--     soundtrack TEXT,
--     websites TEXT
-- );

-- INSERT INTO Multimedia
-- (SELECT ID, ordering, Original_Title, plot_outline, genres, Anti_social_elements, soundtrack, websites from Multimedia1 ORDER BY ID, ordering);

-- ALTER TABLE Multimedia ADD COLUMN Serial_no SERIAL PRIMARY KEY;
---------------------------------------------------------------------

INSERT INTO Movies
  (Movie_ID, ordering, movie_name, lang, Rating)
SELECT titles.x1, titles.x2, titles.x3, titles.x5, t6.x2
FROM titles, t6, t1
WHERE titles.x1 = t1.x1 AND titles.x1 = t6.x1 AND t1.x2 != 'tvSeries' AND t1.x2 != 'tvEpisode';

-------------------------------------------------------------------
ALTER TABLE Movies RENAME TO Movies1;

CREATE TABLE Movies --  SELECT x1, _, x3, _, x2 
(
  --MSerial_no SERIAL PRIMARY KEY, -- serial number
  Movie_ID TEXT,
  -- title.akas x1
  ordering INT NOT NULL,
  -- title.akas x4
  Movie_name TEXT,
  --title.akas.title
  lang TEXT,
  -- title.akas.language
  Rating NUMERIC(3,1)
  -- title.ratings x2
  -- budget INT,    -- NULL  
  -- box_office_gross INT,  -- NULL
  --PRIMARY KEY (Serial_no),
  --FOREIGN KEY (Movie_ID) REFERENCES Multimedia(ID)
);

INSERT INTO Movies
(
SELECT Movie_ID, ordering, Movie_name, lang, Rating
from Movies1
ORDER BY Movie_ID, ordering
);

ALTER TABLE Movies ADD COLUMN MSerial_no SERIAL PRIMARY KEY;
---------------------------------------------------------------------------

INSERT INTO TV_series
  (TV_series_ID,ordering, Name_, lang, Rating)
SELECT titles.x1, titles.x2, titles.x3, titles.x5, t6.x2
FROM titles, t1, t6
WHERE titles.x1 = t1.x1 AND t6.x1 = t1.x1 AND t1.x2 = 'tvSeries';

-------------------------------------------------------------------------------
ALTER TABLE TV_series RENAME TO TV_series1;

CREATE TABLE TV_series
(
  --TSerial_no SERIAL PRIMARY KEY,
  TV_series_ID TEXT,
  -- title.episode x2,( x1 is episode id)
  ordering INT,
  -- title.akas x2
  Name_ TEXT ,
  -- title.basics /x
  lang TEXT,
  -- title.akas x5
  No_of_episodes INT,
  -- not there(max episode no. is same as the no. of episodes)
  Rating NUMERIC(3,1)
  -- title.ratings x2
  -- PRIMARY KEY (Serial_no),
  --FOREIGN KEY (TV_series_ID) REFERENCES Multimedia(ID)
);

INSERT INTO TV_series
(
SELECT TV_series_ID, ordering, Name_, lang, No_of_episodes, Rating
from TV_series1
ORDER BY TV_series_ID, ordering
);

ALTER TABLE TV_series ADD COLUMN TSerial_no SERIAL PRIMARY KEY;
-------------------------------------------------------------------------------------------

INSERT INTO Episodes
  (Episode_ID, ep_ordering, Episode_name, TV_series_ID, Season_Number, Episode_Number, lang, Rating)
SELECT titles.x1, titles.x2, titles.x3, t4.x2, t4.x3, t4.x4, titles.x5, t6.x2
FROM titles, t4, t6, t1
WHERE titles.x1 = t4.x1 AND t4.x1 = t6.x1 AND titles.x1 = t1.x1 AND t1.x2 = 'tvEpisode';

------------------------------------------------------------------------------------------------
ALTER TABLE Episodes RENAME TO Episodes1;

CREATE TABLE Episodes
(
  --ESerial_no SERIAL PRIMARY KEY,
  Episode_ID TEXT,
  -- title.episode x1
  ep_ordering INT ,
  -- -- to be obtained from Tv series ordering 
  Episode_name TEXT,
  TV_series_ID TEXT,
  -- title.episode x2 

  Season_Number INT,
  -- title.episode x3
  Episode_Number INT,
  -- title.episode x4

  lang TEXT,
  -- to be obtained from Tv series ordering
  Rating NUMERIC(3,1)
  -- title.ratings x2
  --PRIMARY KEY (Serial_no) -- episode id is unique
  --FOREIGN KEY (TV_series_ID) REFERENCES TV_series(TV_series_ID) 
  -- FOREIGN KEY ()
);

INSERT INTO Episodes
(
SELECT Episode_ID, ep_ordering, Episode_name, TV_series_ID, Season_Number, Episode_Number, lang, Rating
from Episodes1
ORDER BY Episode_ID, ep_ordering
);

ALTER TABLE Episodes ADD COLUMN ESerial_no SERIAL PRIMARY KEY;
------------------------------------------------------------------------------------------

INSERT INTO Crew
  (Crew_ID, Name_, Year_of_Birth, Year_of_Death, No_of_known_films, Top_three_professions)
SELECT t7.x1, t7.x2, t7.x3, t7.x4, length(t7.x6) - length(replace(t7.x6, ',', '')), t7.x5
FROM t7;

INSERT INTO Locality
  (Region_name)
-- DISTINCT REGIONS TO BE FILLED
SELECT titles.x4
FROM titles
GROUP BY titles.x4
;

INSERT INTO  mu_worked_by
  (Serial_no, ID,Crew_ID,Role_)
SELECT temptable.Serial_no, t5.x1, t5.x3, t5.x4
FROM t5, temptable
WHERE temptable.ID = t5.x1 AND temptable.ordering = t5.x2
;

INSERT INTO ep_worked_by
  (Serial_no, Crew_ID, Episode_ID, TV_series_ID, Role_)
SELECT etemptable.ESerial_no, t5.x3, t5.x1 , t4.x2, t5.x4
FROM t5, t4, etemptable
WHERE etemptable.Episode_ID = t5.x1 AND etemptable.ordering = t5.x2 AND t4.x1 = t5.x1
;

INSERT INTO Air_info
  (Serial_no, Location_ID,Air_date)
SELECT etemptable.ESerial_no, Locality.Location_ID , t1.x6
FROM t1, etemptable, Locality
WHERE etemptable.Episode_ID = t1.x1 AND Locality.Region_name = etemptable.Region_name
;

INSERT INTO release_info
  (Serial_no,Location_ID,runtime,release_date)
SELECT mtemptable.MSerial_no, Locality.Location_ID, t1.x8, t1.x6
FROM mtemptable, Locality, t1
WHERE mtemptable.Movie_ID = t1.x1 AND Locality.Region_name = mtemptable.Region_name
;

INSERT INTO run_info
  (Serial_no, Location_ID, startDate, endDate, runtime)
SELECT ttemptable.TSerial_no, Locality.Location_ID, t1.x6 , t1.x7 , t1.x8
FROM ttemptable, Locality, t1
WHERE ttemptable.TV_series_ID = t1.x1 AND Locality.Region_name = ttemptable.Region_name
;

-- INSERT INTO aka_ids 
-- SELECT t2.x1
-- FROM t2;

-- INSERT INTO titles
-- SELECT t1.x1
-- WHERE t1.x1 NOT IN aka_ids;

--INSERT INTO Movies(lang, Movie_name, Rating, Movie_ID, ordering)

-- tt0000022  |     1
--  tt0000023  |     1

--  tt8543710 |  1 | The Grace Lee Project                                                                                                                              |    |    |    |    | 
--  tt8545576 |  1 | Karma Polishing                                                                                                                                    |    |    |    |    | 
--  tt8547678
