load data infile "/home/nakatani/beercolle/git/beercolle/mysql/Country.csv"
  into table Country
  fields terminated by ','
  enclosed by '"'
  (name, ename, id);
