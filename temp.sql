---
-- order of populating tables
-- multimedia
-- movies
-- tv series
-- (tconst, ordering) = ID
---

DROP TABLE mu_worked_by;
DROP TABLE ep_worked_by;
DROP TABLE Air_info;
DROP TABLE release_info;
DROP TABLE run_info;
DROP TABLE Episodes;
DROP TABLE Crew;
DROP TABLE Locality;
DROP TABLE TV_series;
DROP TABLE Movies;
DROP TABLE Multimedia;

CREATE TABLE Multimedia  -- that x2 not equal to tvEpisode
(
  Serial_no SERIAL PRIMARY KEY,
  ID TEXT, ---  tiltle.basics x1
  ordering INT NOT NULL,
  Original_Title TEXT , -- title.basics x4
  plot_outline TEXT , -- title.basics x3
  genres TEXT, ---  tiltle.basics x9
  
  Anti_social_elements TEXT,
  soundtrack TEXT,
  websites TEXT
  --PRIMARY KEY (ID)
);
-----------------------------------------------------------------------

-------------------------------------------------------------------------
CREATE TABLE Movies --  select x1, _, x3, _, x2 
(
  MSerial_no SERIAL PRIMARY KEY, -- serial number
  Movie_ID TEXT, -- title.akas x1
  ordering INT NOT NULL, -- title.akas x4
  Movie_name TEXT, --title.akas.title
  lang TEXT,   -- title.akas.language
  Rating NUMERIC(3,1) -- title.ratings x2
  -- budget INT,    -- NULL  
  -- box_office_gross INT,  -- NULL
  --PRIMARY KEY (Serial_no),
  --FOREIGN KEY (Movie_ID) REFERENCES Multimedia(ID)
);
-----------------------------------------------------------------------



CREATE TABLE TV_series
(
  TSerial_no SERIAL PRIMARY KEY,
  TV_series_ID TEXT, -- title.episode x2,( x1 is episode id)
  ordering INT,  -- title.akas x2
  Name_ TEXT , -- title.basics /x
  lang TEXT, -- title.akas x5
  No_of_episodes INT, -- not there(max episode no. is same as the no. of episodes)
  Rating NUMERIC(3,1) -- title.ratings x2
  -- PRIMARY KEY (Serial_no),
  --FOREIGN KEY (TV_series_ID) REFERENCES Multimedia(ID)
);

------------------------------------------------------------------------


CREATE TABLE Episodes 
(
  ESerial_no SERIAL PRIMARY KEY,
  Episode_ID TEXT, -- title.episode x1
  ep_ordering INT , -- -- to be obtained from Tv series ordering 
  Episode_name TEXT,
  TV_series_ID TEXT, -- title.episode x2 
  
  Season_Number INT, -- title.episode x3
  Episode_Number INT, -- title.episode x4
  
  lang TEXT,      -- to be obtained from Tv series ordering
  Rating NUMERIC(3,1) -- title.ratings x2
  --PRIMARY KEY (Serial_no) -- episode id is unique
  --FOREIGN KEY (TV_series_ID) REFERENCES TV_series(TV_series_ID) 
  -- FOREIGN KEY ()
);
-------------------------------------------------------------------------


-----------------------------------------------------------------------

CREATE TABLE Crew
(
  Crew_ID TEXT NOT NULL, -- name.basics (temporary7) x1
  Name_ TEXT ,  -- name.basics x2
  -- Gender CHAR , -- NULL
  Year_of_Birth INT , -- name.basics x3
  Year_of_Death INT,  -- name.basics x4
  No_of_known_films INT,  -- COUNT(x6)
  Top_three_professions TEXT,
  PRIMARY KEY (Crew_ID)
);


CREATE TABLE Locality
(
  Location_ID serial PRIMARY KEY, -- Serial numbers 
  Region_name TEXT, -- title.akas (x4)
  Country_name TEXT -- NULL
  -- PRIMARY KEY (Location_ID)
);

CREATE TABLE mu_worked_by -- 
(
  Serial_no INT NOT NULL,
  ID TEXT,  ---  t1 x1
  Crew_ID TEXT NOT NULL, -- name.basics t7 x1
  Role_ TEXT , -- name.basics x5
  -- ordering INT NOT NULL,
  PRIMARY KEY (Serial_no, Crew_ID, Role_)
  --FOREIGN KEY (Serial_no) REFERENCES Multimedia(Serial_no)
--   -- (Crew_ID) REFERENCES Crew(Crew_ID)
);

CREATE TABLE ep_worked_by
(
  Serial_no INT NOT NULL, -- 
  Crew_ID TEXT NOT NULL, -- name.basics t7.x1
  Episode_ID TEXT, -- t4.x1
  TV_series_ID TEXT, -- t4.x2
  Role_ TEXT, -- t7.x5
  -- ordering INT NOT NULL,
  PRIMARY KEY (Crew_ID, Serial_no, Role_)
--   FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID),
  --FOREIGN KEY (Serial_no) REFERENCES Episodes(ESerial_no)
);

CREATE TABLE Air_info
(
  Serial_no INT NOT NULL, -- Episodes (ESerial_no)
  Location_ID SERIAL NOT NULL, --title.akas x4
--   TV_series_ID TEXT NOT NULL, -- Epiosdes (TV_series_ID)
--   Episode_ID TEXT NOT NULL, -- Episodes (Episode_ID)
  --ordering INT NOT NULL,
  Air_date INT ,  --title.basics x6
  PRIMARY KEY (Location_ID, Serial_no)
  --FOREIGN KEY (Location_ID) REFERENCES Locality(Location_ID),
  --FOREIGN KEY (Serial_no) REFERENCES Episodes(ESerial_no)
);

CREATE TABLE release_info -- movies
(
  Serial_no INT NOT NULL, --title.akas (x2)
  Location_ID INT NOT NULL, -- title.basics(x5)
--   Movie_ID TEXT NOT NULL, -- title.basics (x1)
  runtime INT , -- title.basics(x8)
  release_date INT, -- title.basics(x6)
  -- languages_of_release TEXT,
  --certificate_ TEXT, 
  PRIMARY KEY (Location_ID, Serial_no)
  --FOREIGN KEY (Location_ID) REFERENCES Locality(Location_ID),
  --FOREIGN KEY (Serial_no) REFERENCES Movies(MSerial_no)
);

CREATE TABLE run_info
(
  Serial_no INT NOT NULL,
  Location_ID INT NOT NULL,  
--   TV_series_ID TEXT NOT NULL,
  startDate INT, 
  endDate INT,
  runtime INT ,
  --certificate_ TEXT,
  --ordering INT NOT NULL,
  PRIMARY KEY (Location_ID, Serial_no)
  --FOREIGN KEY (Serial_no) REFERENCES TV_series(TSerial_no),
 -- FOREIGN KEY (Location_ID) REFERENCES Locality(Location_ID)
);

--- no need ---
-- CREATE TABLE Production_Company -- NULL
-- (
--   Company_ID TEXT NOT NULL,
--   Name_ TEXT NOT NULL,
--   PRIMARY KEY (Company_ID)
-- );
--------

--- no need ---
-- CREATE TABLE User_  -- NULL
-- (
--   User_ID TEXT NOT NULL,
--   Name_ TEXT NOT NULL,
--   Year_of_Birth INT NOT NULL,
--   PRIMARY KEY (User_ID)
-- );

--- no need ---
-- CREATE TABLE Awards -- NULL
-- (
--   Award_Name TEXT NOT NULL,
--   Year INT NOT NULL,
--   Category TEXT NOT NULL,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (Award_Name),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)--, ordering)
-- );

--- no need ---
-- CREATE TABLE Review -- TV series ID doubt
-- (
--   Rating NUMERIC(3,1), -- title.ratigns (x2)
--   -- Content TEXT,
--   -- Parental_Guide TEXT,
--   Review_ID TEXT NOT NULL, -- Serial numbers
--   Title TEXT NOT NULL,
--   Episode_Number INT,
--   TV_series_ID TEXT,
--   ID TEXT,
--   -- User_ID TEXT,
--   ordering INT NOT NULL,
--   PRIMARY KEY (Review_ID),
--   FOREIGN KEY (Episode_Number, TV_series_ID, ordering) REFERENCES Episodes(Episode_Number, TV_series_ID, ordering),
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID),
--   FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
-- );

--- no need ---
-- CREATE TABLE produced_by -- NULL
-- (
--   ID TEXT NOT NULL,
--   Company_ID TEXT NOT NULL,
--   PRIMARY KEY (ID, Company_ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID),
--   FOREIGN KEY (Company_ID) REFERENCES Production_Company(Company_ID)
-- );

-- CREATE TABLE nomination
-- (
--   won_the_award BIT NOT NULL,
--   Award_Name TEXT NOT NULL,
--   Crew_ID TEXT NOT NULL,
--   PRIMARY KEY (Award_Name, Crew_ID),
--   FOREIGN KEY (Award_Name) REFERENCES Awards(Award_Name),
--   FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID)
-- );

-- CREATE TABLE Is_filmed_at
-- (
--   ID TEXT NOT NULL,
--   Location_ID TEXT NOT NULL,
--   PRIMARY KEY (ID, Location_ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID),
--   FOREIGN KEY (Location_ID) REFERENCES Locality(Location_ID)
-- );

-- CREATE TABLE Multimedia_Titles_in_other_languages -- string array
-- (
--   Titles_in_other_languages TEXT,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (Titles_in_other_languages, ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)
-- );

-- CREATE TABLE Crew_languages
-- (
--   languages TEXT NOT NULL,
--   Crew_ID TEXT NOT NULL,
--   PRIMARY KEY (languages, Crew_ID),
--   FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID)
-- );

-- CREATE TABLE Multimedia_Genre -- string array
-- (
--   Genre TEXT NOT NULL,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (Genre, ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)
-- );

-- CREATE TABLE Multimedia_websites -- string array
-- (
--   websites TEXT,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (websites, ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)
-- );
-- ---------------------
-- CREATE TABLE Multimedia_Anti_social_elements -- string array
-- (
--   Anti_social_elements TEXT NOT NULL,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (Anti_social_elements, ID),ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)
-- );
-- ----------------------

-- CREATE TABLE Multimedia_soundtracks
-- (
--   soundtracks TEXT,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (soundtracks, ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)
-- );
