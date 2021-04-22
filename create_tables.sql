-- DROPPING tables(uncomment these lines if you are running more than once)
-- DROP TABLE mu_worked_by;
-- DROP TABLE ep_worked_by;
-- DROP TABLE Air_info;
-- DROP TABLE release_info;
-- DROP TABLE run_info;
-- DROP TABLE Episodes;
-- DROP TABLE Crew;
-- DROP TABLE Locality;
-- DROP TABLE TV_series;
-- DROP TABLE Movies;
-- DROP TABLE Multimedia;
-- DROP TABLE Awards;
-- DROP TABLE Production_Company;
-- DROP TABLE crew_nomination;
-- DROP TABLE multimedia_nomination;
-- DROP TABLE produced_by;

CREATE TABLE Multimedia
(
  Serial_no SERIAL PRIMARY KEY,
  ID TEXT, 
  ordering INT NOT NULL,
  --------------
  Title TEXT,
  IsOriginal BIT,
  IsAdult BIT,
  ---------------
  plot_outline TEXT, 
  genres TEXT, 
  Anti_social_elements TEXT,
  soundtrack TEXT,
  websites TEXT
);

CREATE TABLE Movies 
(
  MSerial_no SERIAL PRIMARY KEY, 
  Movie_ID TEXT, 
  ordering INT NOT NULL,
  Movie_name TEXT, 
  lang TEXT,
  Rating NUMERIC(3,1),
  budget INT,
  box_office INT
);

CREATE TABLE TV_series
(
  TSerial_no SERIAL PRIMARY KEY,
  TV_series_ID TEXT, 
  ordering INT,  
  Name_ TEXT , 
  lang TEXT, 
  No_of_episodes INT,
  Rating NUMERIC(3,1)
);

CREATE TABLE Episodes 
(
  ESerial_no SERIAL PRIMARY KEY,
  Episode_ID TEXT,
  ep_ordering INT,
  Episode_name TEXT,
  TV_series_ID TEXT,
  Season_Number INT,
  Episode_Number INT,
  lang TEXT, 
  Rating NUMERIC(3,1)
);

CREATE TABLE Crew
(
  Crew_ID TEXT NOT NULL,
  Name_ TEXT ,
  Year_of_Birth INT, 
  Year_of_Death INT,
  No_of_known_films INT,
  Top_three_professions TEXT,
  PRIMARY KEY (Crew_ID)
);


CREATE TABLE Locality
(
  Location_ID serial PRIMARY KEY, 
  Region_name TEXT, 
  Country_name TEXT 
);

CREATE TABLE mu_worked_by 
(
  Serial_no INT NOT NULL,
  ID TEXT,
  Crew_ID TEXT NOT NULL, 
  Role_ TEXT,
  Specific_Role TEXT,
  PRIMARY KEY (Serial_no, Crew_ID, Role_)
);

CREATE TABLE ep_worked_by
(
  Serial_no INT NOT NULL, 
  Crew_ID TEXT NOT NULL, 
  Episode_ID TEXT, 
  TV_series_ID TEXT, 
  Role_ TEXT, 
  Specific_Role TEXT,
  PRIMARY KEY (Crew_ID, Serial_no, Role_)
);

CREATE TABLE Air_info
(
  Serial_no INT NOT NULL, 
  Location_ID INT NOT NULL, 
  runtime INT,
  Air_date INT , 
  PRIMARY KEY (Location_ID, Serial_no)
);

CREATE TABLE release_info -- movies
(
  Serial_no INT NOT NULL, 
  Location_ID INT NOT NULL, 
  runtime INT ,
  ------------
  IsAdult BIT,
  ------------
  release_date INT,
  PRIMARY KEY (Location_ID, Serial_no)
  
);

CREATE TABLE run_info -- TV_series
(
  Serial_no INT NOT NULL,
  Location_ID INT NOT NULL, 
  -----------
  IsAdult BIT, 
  -----------
  startDate INT, 
  endDate INT,
  runtime INT ,
  PRIMARY KEY (Location_ID, Serial_no)
);


CREATE TABLE Production_Company -- NULL
(
  Company_ID SERIAL PRIMARY KEY,
  Name_ TEXT NOT NULL
);

CREATE TABLE Awards -- NULL
(
  Award_ID SERIAL PRIMARY KEY,
  Award_Name TEXT,
  Category TEXT
);

-----------------------------------------------------------------------------
CREATE TABLE crew_nomination
(
  won_the_award BIT,
  Award_ID INT NOT NULL,
  Crew_ID TEXT NOT NULL,
  Year_ INT,
  PRIMARY KEY (Award_ID, Crew_ID, Year_)
);

CREATE TABLE multimedia_nomination
(
  won_the_award BIT,
  Award_ID INT NOT NULL, 
  Serial_no INT NOT NULL,
  PRIMARY KEY (Award_ID, Serial_no)
);

CREATE TABLE produced_by -- NULL
(
  serial_no INT NOT NULL,
  Company_ID INT NOT NULL,
  PRIMARY KEY (serial_no, Company_ID)
);
-----------------------------------------------------------------------------

-- creating temporary tables which are later used for populating tables.
--#### Uncomment these lines for dropping existing temporary tables. ####--
-- DROP TABLE t1;
-- DROP TABLE t2;
-- DROP TABLE t3;
-- DROP TABLE t4;
-- DROP TABLE t5;

-- DROP TABLE t6;
-- DROP TABLE t7;

-- -- for title.basics file
-- --                tconst, titletype,  primarytitle, originaltitle, isadult, startyr,  endyr, runtime min, genres 
-- CREATE table t1 (x1 TEXT, x2 TEXT,    x3 TEXT,      x4 TEXT,       x5 BIT,  x6 INT,   x7 INT, x8 INT,    x9  TEXT);
-- -- for title.akas file
--                titleid, ordering, title,   region,  language, types,  attributes, isoriginaltitle
-- CREATE table t2 (x1 TEXT, x2 INT,    x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT,    x8 BIT);
-- for title.crew file
--                tconst, directors, writers
-- CREATE table t3 (x1 TEXT, x2 TEXT,   x3 TEXT);
-- -- for title.episode file
-- --                tconst, parenttconst, seasonno.,ep no.
-- CREATE table t4 (x1 TEXT, x2 TEXT,      x3 INT,   x4 INT);
-- -- for title.principals file
-- --                tconst, ordering, nconst, category, job,    characters
-- CREATE table t5 (x1 TEXT, x2 INT,   x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT);
-- -- for title.ratings file
-- --                tconst, averageg rating,  num votes
-- CREATE table t6 (x1 TEXT, x2 NUMERIC(3, 1), x3 INT);
-- -- for name.basics file
-- --                nconst, primaryname, birthyr, deathyr, primary profession, knownfortitles
-- CREATE table t7 (x1 TEXT, x2 TEXT,     x3 INT,  x4 INT,  x5 TEXT,           x6 TEXT);

----
-- not using
-- titles.x5,x6
-- t3
-- t5.x5,x6
-- t6.x3
