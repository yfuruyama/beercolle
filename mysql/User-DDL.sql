-- ユーザーはランダムに生成するunique_idで管理
-- screen_nameは後からユーザーに入力してもらう
-- fb_id, tw_idはFacebook, Twitterが管理しているそれぞれでの固有ID

create table User (
  unique_id INTEGER PRIMARY KEY AUTO_INCREMENT,
  screen_name VARCHAR(128),
  fb_id VARCHAR(128) UNIQUE,
  tw_id VARCHAR(128) UNIQUE
)
