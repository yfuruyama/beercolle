-- セッションID管理用テーブル
-- 複数デバイスでログインし直さなくて済むように1ユーザーが複数のセッションIDを持つことを許す
-- バッチ処理などでexpiresが切れたレコードは消去していく(MySQLに自動的に削除する機能があるならばそれを使いたい)

create table Session(
  session VARCHAR(128) PRIMARY KEY, --文字列長はセッションIDを割り振るモジュール等に依存する
  user_id INTEGER NOT NULL,
  expires TIMESTAMP NOT NULL,

 -- Foreign keys
 foreign key(user_id) references User(unique_id)
)
