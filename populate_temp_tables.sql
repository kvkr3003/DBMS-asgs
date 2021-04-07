------------------------------------
/*
please replace [/home/dkprio/] in all thses 7 lines with 
the absolute path before running
*/
\copy t1 from program 'tail -n +2 /home/dkprio/title.basics.tsv';
\copy t2 from program 'tail -n +2 /home/dkprio/title.akas.tsv';
\copy t3 from program 'tail -n +2 /home/dkprio/title.crew.tsv';
\copy t4 from program 'tail -n +2 /home/dkprio/title.episode.tsv';
\copy t5 from program 'tail -n +2 /home/dkprio/title.principals.tsv';
\copy t6 from program 'tail -n +2 /home/dkprio/title.ratings.tsv';
\copy t7 from program 'tail -n +2 /home/dkprio/name.basics.tsv';
--------------------------------------

SELECT * 
INTO titles 
FROM t2;

INSERT INTO titles(x1, x2, x3)     
SELECT x1, 1, x4 
FROM t1
WHERE NOT EXISTS (SELECT 1 
                    FROM  t2
                    WHERE t2.x1 = t1.x1);

ALTER TABLE titles RENAME TO titles1;  -- Renaming table

CREATE table titles (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT, x8 BIT);

INSERT INTO titles
select * from titles1 ORDER BY x1, x2;  -- Sorting table by indices as x1,x2

DROP TABLE titles1;
