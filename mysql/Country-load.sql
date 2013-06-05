create table Country (
  id CHAR(2) PRIMARY KEY,   -- Country code
  j_name VARCHAR(64) NOT NULL UNIQUE,
  e_name VARCHAR(64) NOT NULL UNIQUE  -- English name
);

load data infile "/home/nakatani/beercolle/git/beercolle/mysql/Country.csv"
  into table Country
  fields terminated by ','
  enclosed by '"'
  (j_name, e_name, id);
