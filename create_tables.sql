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

CREATE TABLE Multimedia
(
  Serial_no SERIAL PRIMARY KEY,
  ID TEXT, 
  ordering INT NOT NULL,
  Original_Title TEXT , 
  plot_outline TEXT , 
  genres TEXT, 
  Anti_social_elements TEXT,
  soundtrack TEXT,
  websites TEXT
);

CREATE TABLE Movies 
(
  MSerial_no SERIAL PRIMARY KEY, -- serial number
  Movie_ID TEXT, 
  ordering INT NOT NULL,
  Movie_name TEXT, 
  lang TEXT,
  Rating NUMERIC(3,1) 
);

CREATE TABLE TV_series
(  TSerial_no SERIAL PRIMARY KEY,
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

CREATE TABLE mu_worked_by -- 
(
  Serial_no INT NOT NULL,
  ID TEXT,
  Crew_ID TEXT NOT NULL, 
  Role_ TEXT,
  PRIMARY KEY (Serial_no, Crew_ID, Role_)
);

CREATE TABLE ep_worked_by
(
  Serial_no INT NOT NULL, 
  Crew_ID TEXT NOT NULL, 
  Episode_ID TEXT, 
  TV_series_ID TEXT, 
  Role_ TEXT, 
  PRIMARY KEY (Crew_ID, Serial_no, Role_)
);

CREATE TABLE Air_info
(
  Serial_no INT NOT NULL, 
  Location_ID SERIAL NOT NULL, 
  Air_date INT , 
  PRIMARY KEY (Location_ID, Serial_no)
);

CREATE TABLE release_info -- movies
(
  Serial_no INT NOT NULL, 
  Location_ID INT NOT NULL, 
  runtime INT ,
  release_date INT, 
  PRIMARY KEY (Location_ID, Serial_no)
  
);

CREATE TABLE run_info
(
  Serial_no INT NOT NULL,
  Location_ID INT NOT NULL,  
  startDate INT, 
  endDate INT,
  runtime INT ,
  PRIMARY KEY (Location_ID, Serial_no)
);

--- no need ---
CREATE TABLE Production_Company -- NULL
(
  Company_ID TEXT NOT NULL,
  Name_ TEXT NOT NULL,
  PRIMARY KEY (Company_ID)
);
--- no need ---
CREATE TABLE Awards -- NULL
(
  Award_Name TEXT NOT NULL,
  Year INT NOT NULL,
  Category TEXT NOT NULL,
  ID TEXT NOT NULL,
  PRIMARY KEY (Award_Name),
  ordering INT NOT NULL
);

-- creating temporary tables which are later used for populating tables.
--#### Uncomment these lines for dropping existing temporary tables. ####--
-- DROP TABLE t1;
-- DROP TABLE t2;
-- DROP TABLE t3;
-- DROP TABLE t4;
-- DROP TABLE t5;
-- DROP TABLE t6;
-- DROP TABLE t7;

-- for title.basics file
CREATE table t1 (x1 TEXT, x2 TEXT, x3 TEXT, x4 TEXT, x5 BIT, x6 INT, x7 INT, x8 INT, x9  TEXT);
-- for title.akas file
CREATE table t2 (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT, x8 BIT);
-- for title.crew file
CREATE table t3 (x1 TEXT, x2 TEXT, x3 TEXT);
-- for title.episode file
CREATE table t4 (x1 TEXT, x2 TEXT, x3 INT, x4 INT);
-- for title.principals file
CREATE table t5 (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT);
-- for title.ratings file
CREATE table t6 (x1 TEXT, x2 NUMERIC(3, 1), x3 INT);
-- for name.basics file
CREATE table t7 (x1 TEXT, x2 TEXT, x3 INT, x4 INT, x5 TEXT, x6 TEXT);
