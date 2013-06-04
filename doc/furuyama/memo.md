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
