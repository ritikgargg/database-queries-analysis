## Database Queries' Execution Plans Analysis

**Details of datasets created:**

(a) Table **Actor**: consists of the following two attributes:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(1) `a_id`(a random integer between 1 and 300000) and

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) `name` (a random string of length 15 characters).

- `a_id` is the primary key of the table. So as expected two actors should not have the same id. We have 300000 actors.

(b) Table **Production Company**: consists of following attributes:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(1) `pc_id` (a random integer between 1 and 80000;

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) `name` (a random string of length 10 characters);

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(3) `address` (a random string of length 30 characters).

- We have 80000 companies.

(c) Table **Movie**: consists of following attributes:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(1) `m_id` (a random integer between 1 and 1000000);

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) `name` (a random string of length 10 characters;

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(3) `year` (a random integer between 1900 and 2000);

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(4) `imdb_score` (a random float between 1 and 5);

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(5) `production_company` (foreign key referencing to pc_id of the table production company).

- As expected all the production companies in this table should be a valid company in the production company table.
- `m_id` is the primary key of this table.
- `pc_id` is a random integer between 1 and 80000.

(d) Table **Casting**: consists of following attributes:

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(1) `m_id` and

&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(2) `a_id`.

- `m_id` is a foreign key reference to the movie table.
- `a_id` is a foreign key referencing the actor table.
- `m_id` and `a_id` together form the primary key of this table.
- Each movie has 4 actors and all movies have actors.
- `a_id` follow uniformly random distribution.

**Details of indexes created**  
Indexes created on the following attributes:  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(a) a_id in the actor table;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(b) m_id in the movie table;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(c) imdb score in the movie table;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(d) year in the movie;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(e) m_id in the casting table;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(f) a_id in the casting table;  
&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;(g) pc_id in movie table.

#### Part A: Experimenting with Query Selectivity

1. Consider following range queries:

```SQL
Q1: SELECT name FROM movie WHERE imdb_score < 2;
Q2: SELECT name FROM movie WHERE imdb_score between 1.5 and 4.5;
Q3: SELECT name FROM movie WHERE year between 1900 and 1990;
Q4: SELECT name FROM movie WHERE year between 1990 and 1995;
Q5: SELECT * FROM movie WHERE pc_id < 50;
Q6: SELECT * FROM movie WHERE pc_id > 20000;
```

2. We ran the explain analyze command for Q1, Q2, Q3, Q4 and Q5 and briefly explained the query strategy adopted by the query optimizer in each of the queries.

Thereafter, we addressed the following questions:

3. Is the index on `imdb_score` used for Q1 and Q2 queries? Give an intuitive explanation of the observed results in terms of parameters like query selectivity (which can computed by using `COUNT(*)`).

4. Is the index on `year` used for both Q3 and Q4 queries? Give an intuitive explanation of the observed results in terms of parameters like query selectivity (which can computed by using `COUNT(*)`).

5. Is the index on `pc_id` used for both Q5 and Q6 queries? Give an intuitive explanation of the observed results in terms of parameters like query selectivity (which can computed by using `COUNT(*)`).

#### Part B: Join Strategies

1. Consider the following SQL queries  
   Q1: Join Actor, Movie and Casting; Where a_id < 50; finally, the query outputs actor name and movie name.

   ```SQL
   SELECT actor.name, movie.name
   FROM actor, movie, casting
   WHERE casting.m_id = movie.m_id
   AND casting.a_id = actor.a_id
   AND actor.a_id < 50;
   ```

   Q2: Join Actor and Casting; Where m_id < 50; finally, the query outputs actor name.

   ```SQL
   SELECT actor.name
   FROM actor, casting
   WHERE actor.a_id = casting.a_id
   AND casting.m_id < 50;
   ```

   Q3: Join Movie and Production Company; where imdb score is less than 1.5. Finally, the query outputs the movie name and production company.

   ```SQL
   SELECT movie.name, production_company.name
   FROM movie, production_company
   WHERE movie.pc_id = production_company.pc_id
   AND movie.imdb_score < 1.5;
   ```

   Q4: Join Movie and Production Company; where year is between 1950 and 2000. Finally, the query outputs the movie name and production company.

   ```SQL
   SELECT movie.name, production_company.name
   FROM movie, production_company
   WHERE movie.pc_id = production_company.pc_id
   AND movie.year BETWEEN 1950 AND 2000;
   ```

2. We ran the explain analyze command for each Q1, Q2, Q3 and Q4 and thereafter, provided an explanation for the query strategy adopted by the query optimizer in each of the queries.

3. We then tried to briefly justify (to the extent possible) the query optimizer choices (choice of query processing algorithms) in these queries based on parameters like **query selectivity** and **cost models**.
