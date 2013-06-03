-- ユーザーはFacebookのIDで管理
-- Facebook以外のアカウントでもログインできるように拡張するなら別のキーを考える

create table User (
  fb_id INTEGER PRIMARY KEY,
  fb_access_token VARCHAR(256)
)
