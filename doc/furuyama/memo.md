Xcode 共同開発
--------------
- http://uneri-no-shinzui.blogspot.jp/2011/02/xcode-iphone.html
- バージョン管理する対象
-- http://blog.ishkawa.org/blog/2012/10/27/xcode-git/
-- beercolle.xcodeproj/内はproject.pbxprojのみ管理するようにさせる


気をつけること
--------------
- XCodeプロジェクト内で見えるディレクトリツリーと、実際のファイルシステムにあるディレクトリツリーは対応していない
    - 混乱のもとになるのでなるべく対応させるように気をつける(同名のディレクトリ名(Xcode内ではグループ名)を付けるなど)
- project.pbxprojは自動マージさせるべきではないらしい(プロジェクトが壊れる？)が、とりあえず様子見

ガイドライン
------------
Coding Style:
- GoogleのObjective-C Coding Style
- http://google-styleguide.googlecode.com/svn/trunk/objcguide.xml



memo
------
2013/6/8
- アプリ名
    - MyBeerCellar みたいなのはどうか
        - 自分だけのビールのコレクションという意味合いから
        - homebrew(Macのパッケージ管理システム)もCellarという単語を使ってる
        - ワインセラーとは言うけど、ビールセラーとは言わない？？
- マスターデータを使った初期化方法
    - マスターデータは別のフォーマットで用意しておき、初期起動時にパースしてCore Dataに保存する
        - 利点: リーダブルなマスターデータをそのまま使える
        - 欠点: パースして、さらにCore Dataのエンティティを作る必要があるので遅い(結局はSQLiteに保存するのだから二度手間を踏んでいる)
    - SQLite形式のマスターデータを用意しておいて、初期起動時に読み込ませる
        - 利点: マスターデータをパースして読み込ませるより速いはず
        - 欠点: SQLite形式のファイルを用意しないといけない
    - JSONやXMLのようなヒューマンリーダブルなコードを準備しておいて、あらかじめSQLiteの形式に変換できるようなツールが欲しい
        - Core Dataのモデル定義とも連動するようなもの
- 次回まで
    - マスターデータに基づいたデータの初期化ロジック(MySQL->SQLiteフォーマットのファイル->iOS組み込み)
    - iPhoneサイドのtwitter or facebook認証(サーバサイドとの連携もしたい)
    - クライアントサイドのテーブル定義
    - iPhoneアプリのワイヤーフレーム構想
