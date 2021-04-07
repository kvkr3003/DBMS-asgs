-- DROP TABLE titles;
-- CREATE table titles (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT, x8 BIT);

SELECT * 
INTO titles 
FROM t2;

INSERT INTO titles(x1, x2, x3)
SELECT x1, 1, x4 
FROM t1
WHERE NOT EXISTS (SELECT 1 
                    FROM  t2
                    WHERE t2.x1 = t1.x1);

ALTER TABLE titles RENAME TO titles1;

CREATE table titles (x1 TEXT, x2 INT, x3 TEXT, x4 TEXT, x5 TEXT, x6 TEXT, x7 TEXT, x8 BIT);

INSERT INTO titles
select * from titles1 ORDER BY x1, x2;








-- SELECT Column_Fname, Column_Lname, table_Department.Column_Dname
-- FROM Table_Employee
-- WHERE Table_Employee.Column_DeptNo = table_Department.Column_DeptNo


-- SELECT titles.x1
-- FROM titles
-- WHERE titles.x1 = t6.x1