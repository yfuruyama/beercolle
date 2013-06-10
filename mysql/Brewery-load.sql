-- 0. /home/nakatani/beercolle/git/beercolle/mysql/Brewery.csv is in this format:
-- さんくとがーれん,サンクトガーレン,Sankt Gallen,日本,神奈川,Kanagawa,http://www.sanktgallenbrewery.com/,,1,0,10
-- べあーどぶるーいんぐ,ベアードブルーイング,Baird Brewing,日本,静岡,Shizuoka,http://bairdbeer.com/ja/,,1,0,10
-- ぶりゅーどっぐ,BrewDog,BrewDog,イギリス,スコットランド,Scotland,http://www.brewdog.com/,,1,0,10
-- ,,,,,,,,1,0,10
-- ...


-- 1. Load data from Excel CSV temporarily
create table BreweryExcel (
  furigana VARCHAR(128) NOT NULL,
  j_name VARCHAR(128) NOT NULL,
  e_name VARCHAR(128) NOT NULL,
  country VARCHAR(64) NOT NULL,
  j_state VARCHAR(64),
  e_state VARCHAR(64)
);

load data infile "/home/nakatani/beercolle/git/beercolle/mysql/Brewery.csv"
  into table BreweryExcel
  fields terminated by ','
  enclosed by '"'
  (furigana, j_name, e_name, country, j_state, e_state);


-- 2. Create table
create table Brewery (
  id INTEGER PRIMARY KEY AUTO_INCREMENT,
  j_name VARCHAR(128) NOT NULL,
  e_name VARCHAR(128) NOT NULL,
  furigana VARCHAR(128) NOT NULL,
  country_id CHAR(2) NOT NULL,   -- Country code
  j_state VARCHAR(64) DEFAULT NULL,           -- 都道府県・州・地名
  e_state VARCHAR(64) DEFAULT NULL,           -- 都道府県・州・地名

  -- Foreign keys
  foreign key(country_id) references Country(id)
)
-- 3. Load joined data from BrewerExcel & Country
as select
  NULL id,
  B.j_name,
  B.e_name,
  B.furigana,
  C.id country_id,
  B.j_state,
  B.e_state
from
  BreweryExcel B,
  Country C
where
  B.country = C.j_name and
  furigana != '';


-- 4. Drop temporary table
drop table BreweryExcel;
