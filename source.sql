------------------------- q1 -----------------------------

WITH T AS (
        SELECT  Movies.Movie_name as Movie, mu_worked_by.Role_ as MRole
        FROM    Movies, Multimedia, mu_worked_by 
        WHERE   Movies.Movie_ID = Multimedia.ID AND 
                Movies.ordering = Multimedia.ordering AND
                Multimedia.Serial_no = mu_worked_by.Serial_no AND
                Role_ = 'director'
        )

SELECT Movie, COUNT(*) as Count
FROM T
GROUP BY Movie
HAVING COUNT(*) >= 2;

---------------------------- q2 -------------------------
 
WITH temp as (
               SELECT a.Crew_ID as director, b.Crew_ID as actor, COUNT(*) as count_
               FROM mu_worked_by as a JOIN mu_worked_by as b
               ON a.ID = b.ID
               WHERE a.Role_ = 'director' and ( b.Role_ = 'actor' or b.Role_ = 'actress')
               GROUP BY director, actor
            ),
         
  
   zack as (
            SELECT Crew_ID as id
            FROM Crew
            WHERE Crew.Name_ = 'Zack Snyder'
           ),
 
   max_movies as (
                    SELECT actor as actor, MAX(count_) as count_
                    FROM temp
                    GROUP BY actor
                ),
 
 
   actor AS (
            SELECT t.actor as id, t.count_ as c
            FROM temp as t, zack, max_movies
            WHERE NOT EXISTS (
                        SELECT 1
                        FROM temp, max_movies
                        WHERE temp.director != zack.id and
                        temp.actor = t.actor and
                        temp.actor = max_movies.actor and
                        temp.count_ = max_movies.count_
                    ) and
                t.director = zack.id and
                t.actor = max_movies.actor and
                t.count_ = max_movies.count_   
            )
 
SELECT Crew.Name_ as name_, actor.id as id, actor.c as no_of_movies
FROM Crew, actor
WHERE Crew.Crew_ID = actor.id;

-------------------------- q3 ------------------------------------

WITH T1 AS (
            SELECT Movies.Movie_name AS Movie, COUNT(multimedia_nomination.Award_ID) AS cnt
            FROM Movies, Multimedia, multimedia_nomination
            WHERE   Movies.Movie_ID = Multimedia.ID AND 
                    Movies.ordering = Multimedia.ordering AND
                    Multimedia.Serial_no = multimedia_nomination.Serial_no AND 
                    multimedia_nomination.won_the_award = '1'
            GROUP BY Movies.Movie_ID, Movies.ordering
            ),
    T2 AS (
            SELECT Movies.Movie_name as Movie
            FROM Movies, Multimedia
            WHERE   Movies.Movie_ID = Multimedia.ID AND 
                    Movies.ordering = Multimedia.ordering AND
                    NOT EXISTS (
                                SELECT 1
                                FROM multimedia_nomination
                                WHERE Multimedia.Serial_no = multimedia_nomination.Serial_no AND 
                                multimedia_nomination.won_the_award = '1'
                                ) 
        )

SELECT Movie FROM T1 WHERE T1.cnt < 2
UNION
SELECT Movie from T2;

----------------------------- q4 -------------------------- 
 
 
WITH q4 AS (
            SELECT a.Crew_ID as director, b.Crew_ID as actor, a.ID as m_id
            FROM mu_worked_by as a JOIN mu_worked_by as b ON a.ID = b.ID, Movies as m
            WHERE a.Role_ = 'director' and 
            (b.Role_ = 'actor' or b.Role_ = 'actress') and
            m.Movie_ID = a.ID and m.Rating > 7
            ),
 
     temp AS (
            SELECT q4.director as director, q4.actor as actor, COUNT(*) as count_
            FROM q4
            GROUP BY director, actor
            )
 
    SELECT a.Name_ as director, b.Name_ as actor
    FROM Crew as a, Crew as b, temp as t
    WHERE t.count_ <= 2 and a.Crew_ID = t.director and b.Crew_ID = t.actor;

---------------------------- q5 --------------------------------

WITH T AS (
            SELECT MAX(Dur) as Duration
            FROM (  
                    SELECT MAX(endDate - startDate) AS Dur
                    FROM run_info 
                    WHERE endDate IS NOT NULL AND startDate IS NOT NULL
                            UNION
                    SELECT MAX(date_part('year', CURRENT_DATE) - startDate) AS Dur
                    FROM run_info
                    WHERE endDate is NULL AND startDate is NOT NULL
                ) 
                AS TT
            )
SELECT Name_ AS longest_aired_series, (endDate-startDate) as duration
FROM TV_Series, run_info, T
WHERE   TV_Series.TSerial_no = run_info.Serial_no AND 
        endDate IS NOT NULL AND startDate IS NOT NULL 
        AND endDate - startDate = T.Duration
    UNION
SELECT Name_ AS longest_aired_series, (date_part('year', CURRENT_DATE) - startDate) as duration
FROM TV_Series, run_info, T
WHERE   TV_Series.TSerial_no = run_info.Serial_no AND 
        endDate IS NULL AND startDate IS NOT NULL 
        AND date_part('year', CURRENT_DATE) - startDate = T.Duration;

-------------------------- q6 ---------------------------
 
WITH time_ as (
                SELECT MIN( runtime ) as min 
                FROM release_info
                WHERE runtime > ( SELECT MIN(runtime)
                                FROM release_info )
            ),
 
     movie_id as (
                    SELECT Movies.Movie_ID as movie_id, time_.min as runtime
                    FROM Movies, release_info, time_
                    WHERE release_info.runtime = time_.min and
                    Movies.MSerial_no = release_info.Serial_no and
                    release_info.release_date = 2020
                ),
 
     director_id as (
                     SELECT mu_worked_by.Crew_ID as id, movie_id.movie_id as movie_id, movie_id.runtime as runtime
                     FROM mu_worked_by, movie_id
                     WHERE movie_id.movie_id = mu_worked_by.ID and
                     mu_worked_by.Role_ = 'director'
                    )
 
SELECT Crew.Name_ as director_name, director_id.movie_id as movie_id, director_id.runtime as runtime
FROM Crew, director_id
WHERE Crew.Crew_ID = director_id.id;
 



-------------------- q7 -------------------------

SELECT  Movie_name AS Movie, Movies.Rating AS Rating
FROM    Movies, Multimedia
WHERE   Multimedia.ID = Movies.Movie_ID AND 
        Multimedia.ordering = Movies.ordering AND
        Multimedia.IsAdult = '1' AND
        Movies.Rating =(SELECT MIN(Movies.Rating)
                        FROM Movies, Multimedia
                        WHERE   Multimedia.ID = Movies.Movie_ID AND 
                                Multimedia.ordering = Movies.ordering AND
                                Multimedia.IsAdult = '1');
                                
SELECT  Name_ AS TV_Series, TV_series.Rating AS Rating
FROM    TV_series, Multimedia
WHERE   Multimedia.ID = TV_series.TV_series_ID AND 
        Multimedia.ordering = TV_series.ordering AND
        Multimedia.IsAdult = '1' AND
        TV_series.Rating =(     SELECT MIN(TV_series.Rating)
                                FROM TV_series, Multimedia
                                WHERE   Multimedia.ID = TV_series.TV_series_ID AND 
                                Multimedia.ordering = TV_series.ordering AND
                                Multimedia.IsAdult = '1');

--------------------------- q8 -----------------------
 
WITH director_id as (
                SELECT mu_worked_by.Crew_ID as director_id, AVG(Movies.Rating) as rating
                FROM mu_worked_by JOIN Movies ON mu_worked_by.ID = Movies.Movie_ID
                WHERE mu_worked_by.Role_ = 'director' and Movies.Rating IS NOT NULL
                GROUP BY mu_worked_by.Crew_ID
                ),
 
    max_rating as ( 
                SELECT rating as r
                FROM director_id
                ORDER BY rating DESC
                LIMIT 1 OFFSET 4
                )
 
SELECT Crew.Name_ as director_name, director_id.rating as rating
FROM Crew, director_id, max_rating
WHERE Crew.Crew_ID = director_id.director_id and director_id.rating >= max_rating.r
ORDER BY rating DESC;

---------------------- q9 ------------------------------------
WITH 
T1 AS
(SELECT TV_Series.TV_series_ID as TID, COUNT(Production_Company.Company_ID) as Pcount
FROM    Production_Company, produced_by, TV_Series, Multimedia
WHERE   TV_series.TV_series_ID = Multimedia.ID AND 
        TV_Series.ordering = Multimedia.ordering AND
        produced_by.Serial_no = Multimedia.Serial_no AND
        Production_Company.Company_ID = produced_by.Company_ID AND
GROUP BY TV_Series.TV_series_ID),
T2 AS
(SELECT TV_Series.TV_series_ID as TID, TV_series.Name_ as TName, COUNT(Locality.Location_ID) as Lcount
FROM    Locality, TV_Series, run_info
WHERE   TV_Series.TSerial_no = run_info.Serial_no AND
        run_info.Location_ID = Locality.Location_ID
GROUP BY TV_Series.TV_series_ID, TV_series.Name_)

SELECT T2.TName as TV_Series
FROM T1, T2
WHERE T1.TID = T2.TID AND T1.Pcount >= 2 AND T2.Lcount >= 3;

--------------------------- q10 -----------------------------------------

SELECT Crew.Crew_ID as id, Crew.Name_ as name_,crew_nomination.Year_ as year_
FROM crew_nomination JOIN Crew ON crew_nomination.Crew_ID = Crew.Crew_ID, Awards
WHERE Awards.Award_ID = crew_nomination.Award_ID and
     Awards.Award_Name = 'Oscar' and  
    crew_nomination.won_the_award = '1' and
    Awards.Category = 'actor'
ORDER BY year_ DESC


----------------------- q11 ---------------------------------

WITH 
asst_dir AS
(SELECT mu_worked_by.Crew_ID AS Asst_dir_Crew_ID, COUNT(Multimedia.Serial_no) AS Asst_dir_exp, AVG(Movies.Rating) as Asst_dir_avg_rating
FROM mu_worked_by, Movies, Multimedia
WHERE   Multimedia.ID = Movies.Movie_ID AND 
        Multimedia.ordering = Movies.ordering AND
        Multimedia.Serial_no = mu_worked_by.Serial_no AND
        mu_worked_by.Specific_Role = 'assistant director'
GROUP BY mu_worked_by.Crew_ID),
dir AS
(SELECT mu_worked_by.Crew_ID AS dir_Crew_ID, COUNT(Multimedia.Serial_no) AS Dir_exp, AVG(Movies.Rating) AS Dir_avg_rating
FROM mu_worked_by, Movies, Multimedia
WHERE   Multimedia.ID = Movies.Movie_ID AND 
        Multimedia.ordering = Movies.ordering AND
        Multimedia.Serial_no = mu_worked_by.Serial_no AND
        mu_worked_by.Specific_Role = 'director'
GROUP BY mu_worked_by.Crew_ID)

SELECT Crew.Name_ as director, 0.3 *(Dir_exp + Asst_dir_exp) + 0.7 * (0.8 * Dir_avg_rating + 0.2 * Asst_dir_avg_rating) AS Score
FROM dir, asst_dir, Crew
WHERE dir.dir_Crew_ID = asst_dir.Asst_dir_Crew_ID AND dir.dir_Crew_ID = Crew.Crew_ID
ORDER BY Score DESC;

----------------------------- q 12  ------------------------------------------

WITH genres_earning AS (
        SELECT Multimedia.Serial_no AS serial_no,
                Movies.Movie_name AS Movie, 
                regexp_split_to_table(Multimedia.genres, E',') AS Genre, 
                box_office - budget AS earning,
                row_number() over (
                                    partition by genres_table.Genre
                                    order by earning DESC
                                    ) row_num
        FROM Movies, Multimedia 
        WHERE   Multimedia.ID = Movies.Movie_ID AND 
                Multimedia.ordering = Movies.ordering
        ),

    new AS (
        SELECT Genre, earning
        FROM    genres_earning
        WHERE   genres_earning.row_num = 5
        )

SELECT  genres_earning.Movie as Movie, Crew.Name_ , genres_earning.earning as Earnings
FROM    genres_earning, new, mu_worked_by, Crew
WHERE   new.Genre = genres_earning.Genre AND  
        genres_earning.earning >= new.earning AND
        genres_earning.serial_no = mu_worked_by.Serial_no AND
        mu_worked_by.Role_ = 'director' AND
        Crew.Crew_ID = mu_worked_by.Crew_ID;
 

-------------------------- q13 -------------------------------- 
WITH 
Movie_Crew AS 
(SELECT Crew.Name_ as MCrew
FROM Crew, mu_worked_by, Multimedia, Movies
WHERE Crew.Crew_ID = mu_worked_by.Crew_ID AND 
        (mu_worked_by.Role_ = 'actor' OR mu_worked_by.Role_ = 'actress') AND
        Multimedia.Serial_no = mu_worked_by.Serial_no AND
        Multimedia.ID = Movies.Movie_ID AND Multimedia.ordering = Movies.ordering),
TV_series_Crew AS 
(SELECT Crew.Name_ as TCrew
FROM Crew, mu_worked_by, Multimedia, TV_series
WHERE Crew.Crew_ID = mu_worked_by.Crew_ID AND 
        (mu_worked_by.Role_ = 'actor' OR mu_worked_by.Role_ = 'actress') AND
        Multimedia.Serial_no = mu_worked_by.Serial_no AND
        Multimedia.ID = TV_series.TV_series_ID AND Multimedia.ordering = TV_series.ordering)
SELECT Movie_Crew.MCrew as Actors
FROM Movie_Crew, TV_series_Crew
WHERE Movie_Crew.MCrew = TV_series_Crew.TCrew;

---------------------------- q 14 -----------------------------
 
WITH temp as ( 
                SELECT Air_date as air_date, MIN(runtime) as runtime
                FROM Air_info
                WHERE Air_date IS NOT NULL AND runtime IS NOT NULL
                GROUP BY Air_date 
            )
 
SELECT Air_info.Air_date as Year_, Air_info.runtime as runtime, Episodes.Episode_ID as episode_ID, Episodes.Episode_name as episode_name    
FROM Air_info, Episodes, temp
WHERE Air_info.Air_date = temp.air_date and
      Air_info.runtime = temp.runtime and
      Episodes.ESerial_no = Air_info.Serial_no
ORDER BY Year_ DESC;


-------------------------- q15 ---------------------------------
WITH genres_table AS
E',') As GenreCT regexp_split_to_table(Multimedia.genres, E
FROM Multimedia)
,genres_rating AS
 Genre, Movies.Rating AS GRating,e, genres_table.genre as  
row_number() over (
        partition by genres_table.Genre
        ORDER BY Movies.Rating DESC
) row_num
FROM Movies, Multimedia, genres_table
WHERE   Multimedia.ID = Movies.Movie_ID AND 
        Multimedia.ordering = Movies.ordering AND 
        Movies.Rating is NOT NULL AND
        Multimedia.IsOriginal = '1')
        
select * from genres_rating as gr
where gr.row_num<=3
order by gr.genre,gr.Grating DESC;

------------------------ q 16 -------------------------------
 
WITH location_id as (
                    SELECT Location_ID  as id
                    FROM Locality
                    WHERE Locality.Region_name = 'CH'
                    )
 
SELECT DISTINCT Movies.Movie_ID as ID, Movies.Movie_name as title, 'Movie' AS Title_type
FROM Movies, release_info, location_id
WHERE release_info.Location_ID = location_id.id and
       Movies.MSerial_no = release_info.Serial_no
UNION
SELECT DISTINCT TV_series.TV_series_ID as ID, TV_series.Name_ as title, 'TV Series' AS Title_type
FROM TV_series, run_info, location_id
WHERE run_info.Location_ID = location_id.id and
       TV_series.TSerial_no = run_info.Serial_no
UNION
SELECT DISTINCT Episodes.TV_series_ID as ID, TV_series.Name_ as title, 'TV Series' AS Title_type
FROM Episodes, Air_info, location_id, TV_series
WHERE Air_info.Location_ID = location_id.id and
    Episodes.ESerial_no = Air_info.Serial_no and
    Episodes.TV_series_ID = TV_series.TV_series_ID;
 

-------------------------- q17 --------------------------- 

SELECT Movies.Movie_name
FROM Locality, Multimedia, release_info, Movies
WHERE   Locality.Region_name = 'Switzerland' AND 
        Locality.Location_ID = release_info.Location_ID AND
        release_info.release_date = 1995 AND
        release_info.Serial_no = Movie.MSerial_no AND
        Movie.Movie_ID = Multimedia.ID AND
        Movie.ordering = Multimedia.ordering AND 
        Multimedia.IsAdult = '1';

-- --------------------------------- q 18 -------------------------
 
WITH  crew as (
                SELECT Crew.Crew_ID as crew_id, Crew.Name_ as crew_name, 
                    regexp_split_to_table(Crew.Top_three_professions,',') as profession, 
                    Crew.Year_of_Birth as birth_year
                FROM Crew
            ),
 
      temp as ( 
                SELECT profession as profession, MAX(birth_year) as birth_year
                FROM crew
                WHERE crew.birth_year IS NOT NULL AND crew.profession IS NOT NULL
                GROUP BY profession 
            )


SELECT crew.crew_id, crew.crew_name , crew.profession as profession, crew.birth_year
FROM crew, temp
WHERE crew.profession != '' and
      crew.profession = temp.profession and
      crew.birth_year = temp.birth_year
ORDER BY profession;
 


-------------------------- q19 -----------------------------------------
-- no data corresponding to this
-- Assuming there are crew ppl with soundtrack producer as job in titles.principal

WITH st_producer AS
(SELECT mu_worked_by.Crew_ID AS stprod_Crew_ID, COUNT(Multimedia.Serial_no) AS no_of_movies
FROM mu_worked_by, Movies, Multimedia
WHERE   Multimedia.ID = Movies.Movie_ID AND 
        Multimedia.ordering = Movies.ordering AND
        Multimedia.Serial_no = mu_worked_by.Serial_no AND
        mu_worked_by.Specific_Role = 'soundtrack producer'
GROUP BY mu_worked_by.Crew_ID)
SELECT  Crew.Name_ AS soundtrack_producer,
FROM    st_producer, Crew
WHERE   Crew.Crew_ID = st_producer.stprod_Crew_ID
        AND no_of_movies >= 5;


---------------------- q20 -----------------------------------------

WITH movie AS ( 
              SELECT Movies.Movie_ID as id
              FROM Movies
              Where Movies.Movie_name = 'One Act Play'   -- modify movie name here 
           ),
 
    crew_count AS (
               SELECT COUNT(DISTINCT mu_worked_by.Crew_ID) as c
                FROM mu_worked_by, movie
                WHERE mu_worked_by.ID = movie.id
            ),
 
     actor AS ( 
                SELECT DISTINCT mu_worked_by.Crew_ID as c_id, mu_worked_by.ID as m_id
              FROM mu_worked_by
               WHERE mu_worked_by.Role_ = 'actor' or mu_worked_by.Role_ = 'actress'
            ),
 
     count_ AS (
               SELECT actor.c_id as id, COUNT(*) as c
                FROM actor
                GROUP BY c_id
           )
 
    
     SELECT Crew.Name_, crew_count.c as no_of_movies
    FROM Crew, count_, crew_count
    WHERE Crew.Crew_ID = count_.id and count_.c = crew_count.c











