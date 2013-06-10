create table BeerStyle (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  j_name VARCHAR(64) NOT NULL UNIQUE,
  e_name VARCHAR(64) NOT NULL UNIQUE   -- English name
);

load data infile "/home/nakatani/beercolle/git/beercolle/mysql/BeerStyle.csv"
  into table BeerStyle
  fields terminated by ','
  enclosed by '"'
  (j_name, e_name);
