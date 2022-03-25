CREATE TABLE IF NOT EXISTS actor (
   a_id INT PRIMARY KEY NOT NULL UNIQUE,
   name VARCHAR(15) NOT NULL
);

CREATE TABLE IF NOT EXISTS production_company (
   pc_id INT PRIMARY KEY NOT NULL UNIQUE,
   name VARCHAR(10) NOT NULL,
   address VARCHAR(30) NOT NULL
);

CREATE TABLE IF NOT EXISTS movie (
   m_id INT PRIMARY KEY NOT NULL UNIQUE,
   name VARCHAR(10) NOT NULL,
   year INT NOT NULL,
   imdb_score NUMERIC(2, 1) NOT NULL,
   pc_id INT NOT NULL,
   FOREIGN KEY (pc_id) REFERENCES production_company (pc_id)
);

CREATE TABLE IF NOT EXISTS casting(
	  m_id INT NOT NULL,
	  a_id INT NOT NULL,
	  PRIMARY KEY (m_id, a_id),
	  FOREIGN KEY (m_id) REFERENCES movie (m_id),
	  FOREIGN KEY (a_id) REFERENCES actor (a_id)
);

CREATE INDEX idx_actor_aid ON actor(a_id);
CREATE INDEX idx_movie_mid ON movie(m_id);
CREATE INDEX idx_movie_imdb ON movie(imdb_score);
CREATE INDEX idx_movie_year ON movie(year);
CREATE INDEX idx_movie_pcid ON movie(pc_id);
CREATE INDEX idx_casting_mid ON casting(m_id);
CREATE INDEX idx_casting_aid ON casting(a_id);