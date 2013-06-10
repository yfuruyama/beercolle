# Sho Nakatani <lay.sakura@gmail.com>

use strict;
use warnings;
use utf8;
use Test::More tests => 10;
use Test::Exception;
use Furigana qw(normalize_furigana);


# ふりがなの使用可能文字
# keys Furigana::norm_rule1
#
# 正規化後のふりがなに含まれ得る文字
# values Furigana::norm_rule%d


# 文字変換
is(normalize_furigana('ぺーるえーる'), 'ぺえるええる');
is(normalize_furigana('ぼっく'), 'ぼつく');
is(normalize_furigana('にゅーとん'), 'にゆうとん');
is(normalize_furigana('どぅんける'), 'でゆんける');
is(normalize_furigana('７７7'), '777');


# 不正文字チェック
# 不正文字はクライアントサイドで入力禁止にもしたい
dies_ok { normalize_furigana('ぺーる・えーる'); }
dies_ok { normalize_furigana('ぺーる えーる'); }
dies_ok { normalize_furigana('ぺーる　えーる'); }
dies_ok { normalize_furigana('@'); }
dies_ok { normalize_furigana('ABCエール'); }  # アルファベットが入ったもののふりがなは 'えーびーしーえーる' とか書いてもらう



