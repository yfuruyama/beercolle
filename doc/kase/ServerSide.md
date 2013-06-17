#サーバーサイドの環境
##Perl
###Perlのバージョン
Perl 5.18.x
途中で問題が起きたら5.16.xに下げる

###Perlbrew
自分の環境（Mac OSX 10.7）で以下のサイトを参考にインストールした
http://ash.roova.jp/perl-to-the-people/install-perl-by-perlbrew.html


##Mojolicious
###Mojoliciousについて
- 万能？
 - Mojolicious::Liteを使うとSinatraのように1スクリプトで完結させることも可能
 - Mojolicious::Liteを解説した資料が多い
- 依存モジュール無し
- ググると比較的最近の資料が多い

###開発Tips
- ログの確認
 - `tail -f log/development.log`

- Mojoliciousのテストスクリプト内でのデバッグログの確認
 - `prove -v test.t`
 - [参考](https://groups.google.com/forum/?fromgroups#!topic/mojolicious/X09J7ms7MQw)

##CPAN
最近はcpanmというのいがクールらしい [参考](http://www.omakase.org/perl/cpanm.html)

- CPANが落ちてる場合
 - ミラーサーバを使う
 - `cpanm --mirror ftp://ftp.riken.jp/lang/CPAN/ MODULE_NAME`

###各モジュールで踏んだ地雷
- Facebook::Graph
 - LWP::Protocol::httpsを先にインストールする必要がある
 - それでもまだテストにコケたが(MacOS 10.7)、コケてるのは人を検索するメソッドでurlの順番が違うだけなのでOKとみなして、ローカルの環境ではテスト無しでインストールした
 - Facebook-Graph-1.0600, perl-5.18, OSX 10.7

```エラーメッセージ
Failed test 'seems to generate uris correctly'
   at t/03_public_query.t line 14.
          got: 'https://graph.facebook.com/sarahbownds?metadata=1&fields=name%2Cid'
     expected: 'https://graph.facebook.com/sarahbownds?fields=name%2Cid&metadata=1'
```

- DBIx::Skinny
 - DBD::mysql（perlのmysqlドライバ）をインストールしないと使えない
 - macportでMySQL5を入れるとパスが通常と異なるので、テストでコケてcpanmでインストールできない
  - 自分でMakefileをMakeする。[参考](http://d.hatena.ne.jp/littlebuddha/20101128/1290937785)

