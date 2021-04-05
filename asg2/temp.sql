-- DROP TABLE Multimedia;
-- DROP TABLE Movies;
-- DROP TABLE TV_series;
-- DROP TABLE Production_Company;
-- DROP TABLE Crew;
-- DROP TABLE User_;
-- DROP TABLE Awards;
-- DROP TABLE Episodes;
-- DROP TABLE Location;
-- DROP TABLE Review;
-- DROP TABLE produced_by;
-- DROP TABLE mu_worked_by;
-- DROP TABLE ep_worked_by;
-- DROP TABLE Air_info;
-- DROP TABLE release_info;
-- DROP TABLE run_info;
-- DROP TABLE nomination;
-- DROP TABLE Is_filmed_at;
-- DROP TABLE Crew_languages;

-- CREATE TABLE Multimedia_Titles_in_other_languages -- string array
-- CREATE TABLE Multimedia_Genre -- string array
-- CREATE TABLE Multimedia_websites -- string array
-- CREATE TABLE Multimedia_Anti_social_elements -- string array
-- CREATE TABLE Multimedia_soundtracks


CREATE TABLE Multimedia  -- that x2 not equal to tvEpisode
(
  ID TEXT NOT NULL, ---  tiltle.basics xx1e
  --ordering INT NOT NULL,
  genres TEXT,
  websites TEXT,
  Anti_social_elements TEXT,
  soundtrack TEXT,
  Original_Title TEXT NOT NULL, -- title.basics x4
  plot_outline TEXT NOT NULL, -- title.basics x3
  PRIMARY KEY (ID)
);

CREATE TABLE Movies -- 1. CREATE  
(
  box_office_gross INT,  -- NULL
  lang TEXT,   -- title.akas.language
  Movie_name TEXT, --title.akas.title
  budget INT,    -- NULL  
  Rating NUMERIC(3,1), -- title.ratings x2
  Movie_ID TEXT NOT NULL, -- title.akas x1
  ordering INT NOT NULL, -- title.akas x4
  PRIMARY KEY (Movie_ID, ordering),
  FOREIGN KEY (Movie_ID) REFERENCES Multimedia(ID)
);


CREATE TABLE TV_series
(
  Name_ TEXT NOT NULL,
  lang TEXT,
  No_of_episodes INT NOT NULL,
  Rating NUMERIC(3,1),
  TV_series_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  PRIMARY KEY (TV_series_ID, ordering),
  FOREIGN KEY (TV_series_ID) REFERENCES Multimedia(ID)
);

CREATE TABLE Production_Company -- NULL
(
  Company_ID TEXT NOT NULL,
  Name_ TEXT NOT NULL,
  PRIMARY KEY (Company_ID)
);

CREATE TABLE Crew
(
  Name_ TEXT NOT NULL,  -- name.basics x2
  Crew_ID TEXT NOT NULL, -- name.basics (temporary7) x1
  Gender CHAR NOT NULL, -- NULL
  Year_of_Birth INT NOT NULL, -- name.basics x3
  Year_of_Death INT,  -- name.basics x4
  No_of_films INT,  -- COUNT(x6)
  PRIMARY KEY (Crew_ID)
);

CREATE TABLE User_
(
  User_ID TEXT NOT NULL,
  Name_ TEXT NOT NULL,
  Year_of_Birth INT NOT NULL,
  PRIMARY KEY (User_ID)
);

CREATE TABLE Awards
(
  Award_Name TEXT NOT NULL,
  Year INT NOT NULL,
  Category TEXT NOT NULL,
  ID TEXT NOT NULL,
  PRIMARY KEY (Award_Name),
  ordering INT NOT NULL,
  FOREIGN KEY (ID) REFERENCES Multimedia(ID)--, ordering)
);

CREATE TABLE Episodes
(
  Episode_Number INT NOT NULL,
  lang TEXT,
  Season_Number INT NOT NULL,
  TV_series_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  PRIMARY KEY (Episode_Number, TV_series_ID, ordering),
  FOREIGN KEY (TV_series_ID, ordering) REFERENCES TV_series(TV_series_ID, ordering)
);

CREATE TABLE Location
(
  Region_name TEXT NOT NULL,
  Country_name TEXT NOT NULL,
  Location_ID TEXT NOT NULL,
  PRIMARY KEY (Location_ID)
);

CREATE TABLE Review
(
  Rating NUMERIC(3,1) NOT NULL,
  Content TEXT NOT NULL,
  Parental_Guide TEXT,
  Review_ID TEXT NOT NULL,
  Title TEXT NOT NULL,
  Episode_Number INT,
  TV_series_ID TEXT,
  ID TEXT,
  User_ID TEXT,
  ordering INT NOT NULL,
  PRIMARY KEY (Review_ID),
  FOREIGN KEY (Episode_Number, TV_series_ID, ordering) REFERENCES Episodes(Episode_Number, TV_series_ID, ordering),
  FOREIGN KEY (ID) REFERENCES Multimedia(ID),
  FOREIGN KEY (User_ID) REFERENCES User_(User_ID)
);

CREATE TABLE produced_by
(
  ID TEXT NOT NULL,
  Company_ID TEXT NOT NULL,
  PRIMARY KEY (ID, Company_ID),
  ordering INT NOT NULL,
  FOREIGN KEY (ID) REFERENCES Multimedia(ID),
  FOREIGN KEY (Company_ID) REFERENCES Production_Company(Company_ID)
);

CREATE TABLE mu_worked_by
(
  Role_ TEXT NOT NULL,
  ID TEXT NOT NULL,
  Crew_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  PRIMARY KEY (ID, Crew_ID, ordering),
  FOREIGN KEY (ID) REFERENCES Multimedia(ID),
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID)
);

CREATE TABLE ep_worked_by
(
  Role_ TEXT NOT NULL,
  Crew_ID TEXT NOT NULL,
  Episode_Number INT NOT NULL,
  TV_series_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  PRIMARY KEY (Crew_ID, Episode_Number, TV_series_ID, ordering),
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID),
  FOREIGN KEY (Episode_Number, TV_series_ID, ordering) REFERENCES Episodes(Episode_Number, TV_series_ID, ordering)
);

CREATE TABLE Air_info
(
  Air_date INT NOT NULL,
  Location_ID TEXT NOT NULL,
  Episode_Number INT NOT NULL,
  TV_series_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  PRIMARY KEY (Location_ID, Episode_Number, TV_series_ID, ordering),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
  FOREIGN KEY (Episode_Number, TV_series_ID, ordering) REFERENCES Episodes(Episode_Number, TV_series_ID, ordering)
);

CREATE TABLE release_info
(
  runtime INT NOT NULL,
  release_date INT NOT NULL,
  languages_of_release TEXT, -- DOUBT TO BE CHECKED
  certificate_ TEXT NOT NULL,
  Location_ID TEXT NOT NULL,
  Movie_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  PRIMARY KEY (Location_ID, Movie_ID, ordering),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID),
  FOREIGN KEY (Movie_ID, ordering) REFERENCES Movies(Movie_ID, ordering)
);

CREATE TABLE run_info
(
  languages_of_release TEXT, -- DOUBT TO BE CHECKED
  startDate INT NOT NULL, 
  running_status BIT NOT NULL, -- DOUBT 
  endDate INT,
  runtime INT NOT NULL,
  certificate_ TEXT NOT NULL,
  TV_series_ID TEXT NOT NULL,
  ordering INT NOT NULL,
  Location_ID TEXT NOT NULL,
  PRIMARY KEY (TV_series_ID,ordering, Location_ID),
  FOREIGN KEY (TV_series_ID,ordering) REFERENCES TV_series(TV_series_ID,ordering),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

CREATE TABLE nomination
(
  won_the_award BIT NOT NULL,
  Award_Name TEXT NOT NULL,
  Crew_ID TEXT NOT NULL,
  PRIMARY KEY (Award_Name, Crew_ID),
  FOREIGN KEY (Award_Name) REFERENCES Awards(Award_Name),
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID)
);

CREATE TABLE Is_filmed_at
(
  ID TEXT NOT NULL,
  Location_ID TEXT NOT NULL,
  PRIMARY KEY (ID, Location_ID),
  ordering INT NOT NULL,
  FOREIGN KEY (ID) REFERENCES Multimedia(ID),
  FOREIGN KEY (Location_ID) REFERENCES Location(Location_ID)
);

-- CREATE TABLE Multimedia_Titles_in_other_languages -- string array
-- (
--   Titles_in_other_languages TEXT,
--   ID TEXT NOT NULL,
--   PRIMARY KEY (Titles_in_other_languages, ID),
--   ordering INT NOT NULL,
--   FOREIGN KEY (ID) REFERENCES Multimedia(ID)
-- );

CREATE TABLE Crew_languages
(
  languages TEXT NOT NULL,
  Crew_ID TEXT NOT NULL,
  PRIMARY KEY (languages, Crew_ID),
  FOREIGN KEY (Crew_ID) REFERENCES Crew(Crew_ID)
);

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
