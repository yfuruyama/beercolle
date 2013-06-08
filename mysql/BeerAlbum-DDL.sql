create table BeerAlbum (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  beer_id INTEGER NOT NULL,
  rating DECIMAL(3,2),  -- From 1.00 to 5.00 (like Tabelog)
  note TEXT,
  tstamp TIMESTAMP,     -- 登録時刻

  -- 官能評価
  appearance VARCHAR(32),
  aroma VARCHAR(32),  -- 鼻から香る匂い
  flavor VARCHAR(32),  -- 口に入れた後，鼻から抜ける匂い
  taste VARCHAR(32),

  -- Foreign keys
  foreign key(beer_id) references Beer(id)
)
