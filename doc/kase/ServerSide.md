#サーバーサイドの環境
##Perl
###Perlのバージョン
全員Perlを知らないということで、最近リリースされた最新のPerl 5.18にしておきます。
途中で問題が起きたら5.16に下げる。

###Perlbrew
自分の環境（Mac OSX 10.7）で以下のサイトを参考にインストールした
http://ash.roova.jp/perl-to-the-people/install-perl-by-perlbrew.html

##フレームワーク
###Catalyst
- フルスタック
- 依存モジュールたくさん
- 2006~2008年頃の資料が多い。ググっても最近の資料が見つからない・・・
- 公式を見ると、開発は続いているらしい

###Mojolicious
- 万能？
 - Mojolicious::Liteを使うとSinatraのように1スクリプトで完結させることも可能
 - Mojolicious::Liteを解説した資料が多い
- 依存モジュール無し
- ググると比較的最近の資料が多い

迷ったらフルスタックとか言ってしまったけど、Catalystが最近でも使われているか分からないということと、最初の頃はiPhoneアプリとDBを繋ぐ役割しかしないと思われるので、資料の多そうなMojolicious::Liteから勉強してみる予定。
