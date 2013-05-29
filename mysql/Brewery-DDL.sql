create table Brewery (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  c_id CHAR(2) NOT NULL,   -- Country code

  -- Foreign keys
  foreign key(c_id) references Country(id)
);
