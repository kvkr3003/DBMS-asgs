# DBMS2 ASG3

## TEAM 9
    K Vamshi Krishna Reddy  - CS18BTECH11024 
    K Havya Sree            - CS18BTECH11022
    D Krishna Pawan         - CS18BTECH11008  
    P Sai Varshittha        - CS18BTECH11035
### **We are submitting the files of asg2 again as there have been some modifications in the way data is populated and attributes in tables**  

## Files submitted
```
create_tables.sql
populate_temp_tables.sql
insert.sql
Report.pdf 
README.md

source.sql
```
## How to run:
Assuming **psql** is installed already,  
### CREATING AND POPULATING DATABASE(ASG2)
Open the terminal and cd into the directory of the sql files
  * enter the postgres server by using
    * **sudo -u postgres psql**
  * In this postgres interface, create a new database using
    * **CREATE DATABASE imdb**;
  * enter the IMDB postgress interface by using
    * **sudo -u postgres psql -d imdb**
  * now we run the sql files by using
    * **\i \<absolute path to the directory\>/file.sql**
  * to get the absolute path, copy the output of the following command
    * **\\\! pwd**
  * In the **queries.sql** file, the user need to manually enter the absolute path of those dataset files
  * Finally, we run all the sql files in the following order 
   


    1) create_tables.sql - creating all the actual tables needed for the database we create
    2) populate_temp_tables.sql - copying the data in the tsv files to the created temporary tables
    3) insert.sql - populating the actual tables of the database we create
### QUERYING THE DATABASE(ASG3)
    1) source.sql - sql for the querying of database
