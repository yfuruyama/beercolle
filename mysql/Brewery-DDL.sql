create table Brewery (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  country_id CHAR(2) NOT NULL,   -- Country code
  state VARCHAR(64),             -- 都道府県・州・地名

  -- Foreign keys
  foreign key(country_id) references Country(id)
);
