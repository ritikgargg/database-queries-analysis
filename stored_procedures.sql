--- Stored procedure to populate a table using a CSV file as input.
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