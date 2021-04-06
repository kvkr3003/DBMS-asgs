InINSERT INTO Multimedia(ID, genres, Original_Title, plot_outline)
SELECT x1, x9, x4, x3
FROM temporary1
WHERE temporary1.x2 != 'tvEpisode';

INSERT INTO Movies(Movie_ID, movie_name, lang, Rating)
SELECT titles.x1, titles.x3, titles.x5, temporary6.x2
FROM titles, temporary6, temporary1
WHERE titles.x1 = temporary1.x1 AND titles.x1 = temporary6.x1 AND temporary1.x2 = 'Movie';

INSERT INTO TV_series(TV_series_ID, Name_, lang, Rating)
SELECT titles.x1, titles.x3, titles.x5, temporary6.x2
FROM titles, temporary1, temporary6
WHERE titles.x1 = temporary1.x1 AND temporary6.x1 = temporary1.x1 AND temporary1.x2 = 'TV_series';

INSERT INTO Episodes(Episode_ID, Episode_name, TV_series_ID, Season_Number, Episode_Number, lang, Rating)
SELECT titles.x1, titles.x3, temporary4.x2, temporary4.x3, temporary4.x4, titles.x5, temporary6.x2
FROM titles,temporary4, temporary6, temporary1
WHERE titles.x1 = temporary4.x1 AND temporary4.x1 = temporary6.x1 AND titles.x1 = temporary1.x1 AND temporary1.x2 = 'TV_episode';

INSERT INTO Crew(Crew_ID, Name_, Year_of_Birth, Year_of_Death, No_of_films)
SELECT temporary7.x1, temporary7.x2, temporary7.x3, temporary7.x4, COUNT(temporary7.x6)
FROM temporary7;

INSERT INTO Locality(Region_name)
SELECT titles.x5
FROM titles
;

INSERT INTO  mu_worked_by(ID,Crew_ID,Role_)
SELECT titles.x1,temporary7.x1,
FROM titles,temporary7
WHERE 
;


INSERT INTO Air_info()


-- INSERT INTO aka_ids 
-- SELECT temporary2.x1
-- FROM temporary2;

-- INSERT INTO titles
-- SELECT temporary1.x1
-- WHERE temporary1.x1 NOT IN aka_ids;

--INSERT INTO Movies(lang, Movie_name, Rating, Movie_ID, ordering)
