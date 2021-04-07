
DROP TABLE temptable;
DROP TABLE etemptable;
DROP TABLE ttemptable;
DROP TABLE mtemptable;
DROP TABLE temptable1;
DROP TABLE etemptable1;
DROP TABLE ttemptable1;
DROP TABLE mtemptable1;

CREATE TABLE temptable (
    --Serial_no SERIAL,
    ID TEXT, ---  tiltle.basics x1
    --ordering INT,
    ordering INT,
    Original_Title TEXT , -- title.basics x4
    plot_outline TEXT , -- title.basics x3
    genres TEXT, ---  tiltle.basics x9
    
    Anti_social_elements TEXT,
    soundtrack TEXT,
    websites TEXT
);

INSERT INTO temptable(ID, ordering, genres, Original_Title, plot_outline)
SELECT titles.x1, titles.x2, t1.x9, titles.x3, t1.x3
FROM titles, t1
WHERE t1.x2 != 'tvEpisode' and titles.x1 = t1.x1;

ALTER TABLE temptable RENAME TO temptable1;

CREATE TABLE temptable (
    --Serial_no SERIAL,
    ID TEXT, ---  tiltle.basics x1
    --ordering INT,
    ordering INT,
    Original_Title TEXT , -- title.basics x4
    plot_outline TEXT , -- title.basics x3
    genres TEXT, ---  tiltle.basics x9
    
    Anti_social_elements TEXT,
    soundtrack TEXT,
    websites TEXT
);

INSERT INTO temptable
(select * from temptable1 ORDER BY ID, ordering);

ALTER TABLE temptable ADD COLUMN Serial_no SERIAL;

CREATE TABLE etemptable (
  --ESerial_no SERIAL,
  Episode_ID TEXT, -- title.episode x1
  ordering INT,
  Episode_name TEXT,
  TV_series_ID TEXT NOT NULL, -- title.episode x2 
  --ep_ordering INT NOT NULL, -- -- to be obtained from Tv series ordering 
  Season_Number INT, -- title.episode x3
  Episode_Number INT, -- title.episode x4
  lang TEXT,      -- to be obtained from Tv series ordering
  Rating NUMERIC(3,1), -- title.ratings x2
  Region_name TEXT,
  types TEXT,
  attributes TEXT,
  isOriginalTitle BIT
);

INSERT INTO etemptable(Episode_ID, ordering, Episode_name, TV_series_ID, Season_Number, Episode_Number, lang, Rating, Region_name, types, attributes, isOriginalTitle)
SELECT titles.x1, titles.x2, titles.x3, t4.x2, t4.x3, t4.x4, titles.x5, t6.x2, titles.x4, titles.x6, titles.x7, titles.x8
FROM titles,t4, t6, t1
WHERE titles.x1 = t4.x1 AND t4.x1 = t6.x1 AND titles.x1 = t1.x1 AND t1.x2 = 'tvEpisode';

ALTER TABLE etemptable RENAME TO etemptable1;

CREATE TABLE etemptable (
  --ESerial_no SERIAL,
  Episode_ID TEXT, -- title.episode x1
  ordering INT,
  Episode_name TEXT,
  TV_series_ID TEXT NOT NULL, -- title.episode x2 
  --ep_ordering INT NOT NULL, -- -- to be obtained from Tv series ordering 
  Season_Number INT, -- title.episode x3
  Episode_Number INT, -- title.episode x4
  lang TEXT,      -- to be obtained from Tv series ordering
  Rating NUMERIC(3,1), -- title.ratings x2
  Region_name TEXT,
  types TEXT,
  attributes TEXT,
  isOriginalTitle BIT
);

INSERT INTO etemptable
select * from etemptable1 ORDER BY Episode_ID, ordering;

ALTER TABLE etemptable ADD COLUMN ESerial_no SERIAL;


CREATE TABLE mtemptable (
--   MSerial_no SERIAL, -- serial number
  Movie_ID TEXT NOT NULL, -- title.akas x1
  ordering INT,
  Movie_name TEXT, --title.akas.title
  lang TEXT,   -- title.akas.language
  Rating NUMERIC(3,1), -- title.ratings x2
  Region_name TEXT,
  types TEXT,
  attributes TEXT,
  isOriginalTitle BIT
);

INSERT INTO mtemptable(Movie_ID, ordering, movie_name, lang, Rating, Region_name, types, attributes, isOriginalTitle)
SELECT titles.x1,titles.x2, titles.x3, titles.x5, t6.x2, titles.x4, titles.x6, titles.x7, titles.x8
FROM titles, t6, t1
WHERE titles.x1 = t1.x1 AND titles.x1 = t6.x1 AND t1.x2 != 'tvSeries' AND t1.x2 != 'tvEpisode';

ALTER TABLE mtemptable RENAME TO mtemptable1;

CREATE TABLE mtemptable (
  --MSerial_no SERIAL, -- serial number
  Movie_ID TEXT NOT NULL, -- title.akas x1
  ordering INT,
  Movie_name TEXT, --title.akas.title
  lang TEXT,   -- title.akas.language
  Rating NUMERIC(3,1), -- title.ratings x2
  Region_name TEXT,
  types TEXT,
  attributes TEXT,
  isOriginalTitle BIT
);

INSERT INTO mtemptable
select * from mtemptable1 ORDER BY Movie_ID, ordering;

ALTER TABLE mtemptable ADD COLUMN MSerial_no SERIAL;


CREATE TABLE ttemptable
(
--   TSerial_no SERIAL,
  TV_series_ID TEXT NOT NULL, -- title.episode x2,( x1 is episode id)
  --ordering INT NOT NULL,  -- title.akas x2
  ordering INT,
  Name_ TEXT , -- title.basics /x
  lang TEXT, -- title.akas x5
  No_of_episodes INT, -- not there(max episode no. is same as the no. of episodes)
  Rating NUMERIC(3,1), -- title.ratings x2
  -- PRIMARY KEY (Serial_no),
  --FOREIGN KEY (TV_series_ID) REFERENCES Multimedia(ID)
  Region_name TEXT,
  types TEXT,
  attributes TEXT,
  isOriginalTitle BIT
);

INSERT INTO ttemptable(TV_series_ID, ordering, Name_, lang, Rating, Region_name, types, attributes, isOriginalTitle)
SELECT titles.x1, titles.x2, titles.x3, titles.x5, t6.x2, titles.x4, titles.x6, titles.x7, titles.x8
FROM titles, t1, t6
WHERE titles.x1 = t1.x1 AND t6.x1 = t1.x1 AND t1.x2 = 'tvSeries';

ALTER TABLE ttemptable RENAME TO ttemptable1;

CREATE TABLE ttemptable
(
  --TSerial_no SERIAL,
  TV_series_ID TEXT NOT NULL, -- title.episode x2,( x1 is episode id)
  --ordering INT NOT NULL,  -- title.akas x2
  ordering INT,
  Name_ TEXT , -- title.basics /x
  lang TEXT, -- title.akas x5
  No_of_episodes INT, -- not there(max episode no. is same as the no. of episodes)
  Rating NUMERIC(3,1), -- title.ratings x2
  -- PRIMARY KEY (Serial_no),
  --FOREIGN KEY (TV_series_ID) REFERENCES Multimedia(ID)
  Region_name TEXT,
  types TEXT,
  attributes TEXT,
  isOriginalTitle BIT
);

INSERT INTO ttemptable
select * from ttemptable1 ORDER BY TV_series_ID, ordering;

ALTER TABLE ttemptable ADD COLUMN TSerial_no SERIAL;

-- DROP TABLE ttemptable1;
-- DROP TABLE etemptable1;
-- DROP TABLE mtemptable1;
-- DROP TABLE temptable1;