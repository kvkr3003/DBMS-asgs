\copy t1 from program 'tail -n +2 /home/dkprio/title.basics.tsv';
\copy t2 from program 'tail -n +2 /home/dkprio/title.akas.tsv';
\copy t3 from program 'tail -n +2 /home/dkprio/title.crew.tsv';
\copy t4 from program 'tail -n +2 /home/dkprio/title.episode.tsv';
\copy t5 from program 'tail -n +2 /home/dkprio/title.principals.tsv';
\copy t6 from program 'tail -n +2 /home/dkprio/title.ratings.tsv';
\copy t7 from program 'tail -n +2 /home/dkprio/name.basics.tsv'