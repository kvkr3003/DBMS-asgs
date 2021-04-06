-- DROP TABLE temporary1;
-- DROP TABLE temporary2;
-- DROP TABLE temporary3;
-- DROP TABLE temporary4;
-- DROP TABLE temporary5;
-- DROP TABLE temporary6;
-- DROP TABLE temporary7;

-- create
-- for title.basics file
CREATE table temporary1 (x1 TEXT, x2 TEXT, x3 TEXT, x4 TEXT, x5 BIT, x6 INT, x7 INT, x8 INT, x9  TEXT;

-- for title.akas file
CREATE table temporary2 (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT, x8 BIT);

-- for title.crew file
CREATE table temporary3 (x1 TEXT, x2 TEXT, x3 TEXT);

-- for title.episode file
CREATE table temporary4 (x1 TEXT, x2 TEXT, x3 INT, x4 INT);

-- for title.principals file
CREATE table temporary5 (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT);

-- for title.ratings file
CREATE table temporary6 (x1 TEXT, x2 NUMERIC(3, 1), x3 INT);

-- for name.basics file
CREATE table temporary7 (x1 TEXT, x2 TEXT, x3 INT, x4 INT, x5 TEXT, x6 TEXT);