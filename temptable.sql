-- DROP TABLE t1;
-- DROP TABLE t2;
-- DROP TABLE t3;
-- DROP TABLE t4;
-- DROP TABLE t5;
-- DROP TABLE t6;
-- DROP TABLE t7;

-- create
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