-- create temporary table t (x1 integer, ... , x10 text)-- \copy Multimedia(ID)
-- from program 'tail -n +2 ../dataset/title.basics.tsv'; 
-- DELIMITER '\t' TSV;
\copy temporary1 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.basics.tsv';

\copy temporary2 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.akas.tsv';

\copy temporary3 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.crew.tsv';

\copy temporary4 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.episode.tsv';

\copy temporary5 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.principals.tsv';

\copy temporary6 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/title.ratings.tsv';

\copy temporary7 from program 'tail -n +2 /home/kvkr_3003/assignments/dbms/dataset/name.basics.tsv';a