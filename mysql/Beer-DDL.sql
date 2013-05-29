-- Beerテーブルはビールの客観的な特徴のみから成る．
-- 一方，個人の主観的な感想などはBeerAlbumテーブルに反映されている．

create table Beer (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  style_id INTEGER,
  ABV DECIMAL(3,1),  -- Alcohol by Volume (e.g. 5.4%)
  IBU DECIMAL(4,1),  -- IBU(国際苦味単位)
  brewery_id INTEGER,

  -- Foreign keys
  foreign key(style_id) references BeerStyle(id),
  foreign key(brewery_id) references Brewery(id)
)
