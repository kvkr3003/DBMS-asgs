DROP TABLE titles;
-- CREATE table titles (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT, x8 BIT);

SELECT * 
INTO titles 
FROM temporary2;

--\copy temporary2 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.akas.tsv';
INSERT INTO titles(x1, x3)
SELECT temporary1.x1, temporary1.x4
FROM temporary1
WHERE temporary1.x1 NOT IN (SELECT temporary2.x1 FROM temporary2);
