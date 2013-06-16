-- Beerテーブルはビールの客観的な特徴のみから成る．
-- 一方，個人の主観的な感想などはBeerAlbumテーブルに反映されている．


-- 0. /home/nakatani/beercolle/git/beercolle/mysql/Brewery.csv is in this format:
-- ごーるでんえーる,ゴールデンエール,Golden Ale,さんくとがーれん,ペール・エール,アメリカン,,4.8 ,21,3.5 ,http://www.sanktgallenbrewery.com/beers/golden-ale/,,1,0 ,10
-- あんばーえーる,アンバーエール,Amber Ale,さんくとがーれん,アンバー・エール,アメリカン,,5.2 ,24,15.3 ,http://www.sanktgallenbrewery.com/beers/amber-ale/,,1,0 ,10
-- らいじんぐさんぺーるえーる,ライジングサンペールエール,Rising Sun Pale Ale,べあーどぶるーいんぐ,ペール・エール,アメリカン,,5.1 ,,,http://bairdbeer.com/ja/shop/products/detail.php?product_id=57,http://www.ratebeer.com/beer/baird-rising-sun-pale-ale/22734/,1,0 ,10
-- ぱんくあいぴーえー,パンク・IPA,Punk IPA,ぶりゅーどっぐ,インディア・ペール・エール (IPA),,,5.6 ,45,,http://www.brewdog.com/product/punk-ipa,,1,0 ,10
-- でっどぽにーくらぶ,デッドポニークラブ,Dead Pony Club,ぶりゅーどっぐ,ペール・エール,アメリカン,,3.8 ,,,http://www.brewdog.com/product/dead-pony-club,,1,0 ,10
-- ふぁいぶえいえむせいんと,5am・セイント,5am Saint,ぶりゅーどっぐ,レッド・エール,,,5.0 ,25,,http://www.brewdog.com/product/5am-saint,,1,0 ,10
-- はーどこああいぴーえー,ハードコア・IPA,Hardcore IPA,ぶりゅーどっぐ,イングリッシュ・ペール・エール,,,9.2 ,150,,http://www.brewdog.com/product/hardcore-ipa,,1,0 ,10
-- りばてぃんぶらっくえーる,リバティン・ブラック・エール,Libertine Black Ale,ぶりゅーどっぐ,ブラック・エール,,,7.2 ,,,http://www.brewdog.com/product/libertine-black-ale,,1,0 ,10
-- さくら,さくら,Sakura,さんくとがーれん,スパイス/ハーブ/ベジタブル,,,5.0 ,17,4.2 ,http://www.sanktgallenbrewery.com/beers/sakura/,,1,0 ,10
-- ,,,,,,,,,,,,,,
-- ...


-- 1. Load data from Excel CSV temporarily
create table BeerExcel (
  furigana VARCHAR(128) NOT NULL,
  j_name VARCHAR(128) NOT NULL,
  e_name VARCHAR(128) NOT NULL,
  brewery VARCHAR(128) NOT NULL,
  style1 VARCHAR(64) NOT NULL,
  style2 VARCHAR(64) DEFAULT NULL,
  style3 VARCHAR(64) DEFAULT NULL,
  ABV DECIMAL(3,1) DEFAULT NULL,  -- Alcohol by Volume (e.g. 5.4%)
  IBU INTEGER DEFAULT NULL,       -- 国際苦味単位
  SRM DECIMAL(3,1) DEFAULT NULL   -- 標準参照法．色合いの暗さ．
);

load data infile "/home/nakatani/beercolle/git/beercolle/mysql/Beer.csv"
  into table BeerExcel
  fields terminated by ','
  enclosed by '"'
  (furigana, j_name, e_name, brewery, style1, @vstyle2, @vstyle3, @vABV, @vIBU, @vSRM)
set
  style2 = nullif(@vstyle2,''),
  style3 = nullif(@vstyle3,''),
  ABV = nullif(@vABV,''),
  IBU = nullif(@vIBU,''),
  SRM = nullif(@vSRM,'');


-- 2. Create table
create table Beer (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  is_master BOOL NOT NULL,
  j_name VARCHAR(128) NOT NULL,
  e_name VARCHAR(128) NOT NULL,
  furigana VARCHAR(128) NOT NULL,
  style_id1 INTEGER NOT NULL,
  style_id2 INTEGER DEFAULT NULL,
  style_id3 INTEGER DEFAULT NULL,
  brewery_id INTEGER NOT NULL,
  ABV DECIMAL(3,1) DEFAULT NULL,  -- Alcohol by Volume (e.g. 5.4%)
  IBU INTEGER DEFAULT NULL,       -- 国際苦味単位
  SRM DECIMAL(3,1) DEFAULT NULL,  -- 標準参照法．色合いの暗さ．
  -- OG DECIMAL(4,3) DEFAULT NULL,  -- Original Gravity. 初期比重．

  -- Foreign keys
  foreign key(style_id1) references BeerStyle(id),
  foreign key(style_id2) references BeerStyle(id),
  foreign key(style_id3) references BeerStyle(id),
  foreign key(brewery_id) references Brewery(id)
)
-- 3. Load joined data from BrewerExcel, BeerStyle, Brewery
as select
  NULL id,
  1,
  BeerExcel.j_name,
  BeerExcel.e_name,
  BeerExcel.furigana,
  Style1.id style_id1,
  Style2.id style_id2,
  Style3.id style_id3,
  Brewery.id brewery_id,
  BeerExcel.ABV,
  BeerExcel.IBU,
  BeerExcel.SRM
from
  BeerExcel,
  Brewery,
  (select BeerExcel.furigana, BeerStyle.id from BeerExcel left join BeerStyle on (BeerStyle.j_name = BeerExcel.style1) where BeerExcel.furigana != '') Style1,
  (select BeerExcel.furigana, BeerStyle.id from BeerExcel left join BeerStyle on (BeerStyle.j_name = BeerExcel.style2) where BeerExcel.furigana != '') Style2,
  (select BeerExcel.furigana, BeerStyle.id from BeerExcel left join BeerStyle on (BeerStyle.j_name = BeerExcel.style3) where BeerExcel.furigana != '') Style3
where
  BeerExcel.furigana is not NULL and
  Style1.furigana = BeerExcel.furigana and
  Style2.furigana = BeerExcel.furigana and
  Style3.furigana = BeerExcel.furigana and
  Brewery.furigana = BeerExcel.brewery;
