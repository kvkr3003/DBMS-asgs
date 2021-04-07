# DBMS2 ASG2

## TEAM 9
    K Vamshi Krishna Reddy  - CS18BTECH11024 
    K Havya Sree            - CS18BTECH11022
    D Krishna Pawan         - CS18BTECH11008  
    P Sai Varshittha        - CS18BTECH11035
## Files submitted
```
temp.sql update.sql temptable.sql
new.sql  insert.sql  queries.sql
Report.pdf README.md
```
## How to run:

Assuming **psql** is installed already,  
Open the terminal and cd into the directory of the sql files
  * enter the postgres server by using
    * **sudo -u postgres psql**
  * In this postgres interface, create a new database using
    * CREATE DATABASE imdb;
  * enter the IMDB postgress interface by using
    * **sudo -u postgres psql -d imdb**
  * now we run the sql files by using
    * **\i \<absolute path to the directory\>/file.sql**
  * to get the absolute path, copy the output of the following command
    * **\! pwd**
  * run all the sql files in the following order 

    1) **temptable.sql** - creating temporary tables, used to store the data in tsv files
    2) **queries.sql** - copying the data in the tsv files to the created temporary tables
    3) **new.sql** - creating few other temporary tables, which are used to populate the actual tables
    4) **update.sql**
    5) **temp.sql** - creating all the actual tables needed for the database we create
    6) **insert.sql** - populating the actual tables of the database we create