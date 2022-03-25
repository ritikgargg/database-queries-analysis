CREATE OR REPLACE FUNCTION fill_table(IN table_name VARCHAR(50), IN file_path VARCHAR(500))
  RETURNS TEXT
  LANGUAGE plpgsql AS
$$
DECLARE
BEGIN
    EXECUTE format(
      'COPY %I
      FROM %L
      DELIMITER '',''
      CSV HEADER', table_name, file_path);

    RETURN 'Entries added successfully!';
    
END
$$;

-- select fill_table('movie', 'C:\Program Files\PostgreSQL\13\data\commands_movie.csv');

-- Q1: Join Actor, Movie and Casting; Where a_id < 50; finally, the query outputs actor name and movie name
-- Ans 1: explain analyze select actor.name, movie.name from actor, movie, casting where casting.m_id = movie.m_id and casting.a_id = actor.a_id and actor.a_id < 50;

-- Q2: Join Actor and Casting; Where m_id < 50; finally, the query outputs actor name and movie name
-- Ans 2: explain analyze select actor.name from actor, casting where actor.a_id = casting.a_id and casting.m_id < 50;

-- Q3: Join Movie and Production Company; where imdb score is less than 1.5. Finally, the query outputs the movie name and production company.
-- Ans 3: explain analyze select movie.name, production_company.name from movie, production_company where movie.pc_id = production_company.pc_id and movie.imdb_score < 1.5;

-- Q4: Join Movie and Production Company; where year is between 1950 and 2000. Finally, the query outputs the movie name and production company.
-- Ans 4: explain analyze select movie.name, production_company.name from movie, production_company where movie.pc_id = production_company.pc_id and movie.year between 1950 and 2000;