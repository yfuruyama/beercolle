-- Beerテーブルはビールの客観的な特徴のみから成る．
-- 一方，個人の主観的な感想などはBeerAlbumテーブルに反映されている．

create table Beer (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  name VARCHAR(128) NOT NULL,
  style_id INTEGER,
  brewery_id INTEGER,
  ABV DECIMAL(3,1),  -- Alcohol by Volume (e.g. 5.4%)
  IBU INTEGER,       -- 国際苦味単位
  SRM DECIMAL(3,1),  -- 標準参照法．色合いの暗さ．
  -- OG  DECIMAL(4,3),  -- Original Gravity. 初期比重．

  -- Foreign keys
  foreign key(style_id) references BeerStyle(id),
  foreign key(brewery_id) references Brewery(id)
)
