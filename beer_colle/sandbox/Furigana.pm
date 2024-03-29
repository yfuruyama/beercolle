# Sho Nakatani <lay.sakura@gmail.com>


use strict;
use warnings;
use utf8;


# Keys represent characters users can use.
# Values are used for normalized furigana.
my %norm_rule1 = (  # 1-char rules
    'あ' => 'あ',
    'い' => 'い',
    'う' => 'う',
    'え' => 'え',
    'お' => 'お',
    'か' => 'か',
    'き' => 'き',
    'く' => 'く',
    'け' => 'け',
    'こ' => 'こ',
    'さ' => 'さ',
    'し' => 'し',
    'す' => 'す',
    'せ' => 'せ',
    'そ' => 'そ',
    'た' => 'た',
    'ち' => 'ち',
    'つ' => 'つ',
    'て' => 'て',
    'と' => 'と',
    'な' => 'な',
    'に' => 'に',
    'ぬ' => 'ぬ',
    'ね' => 'ね',
    'の' => 'の',
    'は' => 'は',
    'ひ' => 'ひ',
    'ふ' => 'ふ',
    'へ' => 'へ',
    'ほ' => 'ほ',
    'ま' => 'ま',
    'み' => 'み',
    'む' => 'む',
    'め' => 'め',
    'も' => 'も',
    'や' => 'や',
    'ゆ' => 'ゆ',
    'よ' => 'よ',
    'ら' => 'ら',
    'り' => 'り',
    'る' => 'る',
    'れ' => 'れ',
    'ろ' => 'ろ',
    'わ' => 'わ',
    'を' => 'を',
    'ん' => 'ん',
    'ぁ' => 'あ',
    'ぃ' => 'い',
    'ぅ' => 'う',
    'ぇ' => 'え',
    'ぉ' => 'お',
    'っ' => 'つ',
    'ゃ' => 'や',
    'ゅ' => 'ゆ',
    'ょ' => 'よ',
    'ゎ' => 'わ',
    'ゐ' => 'い',
    'ゑ' => 'え',
    'が' => 'が',
    'ぎ' => 'ぎ',
    'ぐ' => 'ぐ',
    'げ' => 'げ',
    'ご' => 'ご',
    'ざ' => 'ざ',
    'じ' => 'じ',
    'ず' => 'ず',
    'ぜ' => 'ぜ',
    'ぞ' => 'ぞ',
    'だ' => 'だ',
    'ぢ' => 'ぢ',
    'づ' => 'づ',
    'で' => 'で',
    'ど' => 'ど',
    'ば' => 'ば',
    'び' => 'び',
    'ぶ' => 'ぶ',
    'べ' => 'べ',
    'ぼ' => 'ぼ',
    'ぱ' => 'ぱ',
    'ぴ' => 'ぴ',
    'ぷ' => 'ぷ',
    'ぺ' => 'ぺ',
    'ぽ' => 'ぽ',
    '0' => '0',
    '1' => '1',
    '2' => '2',
    '3' => '3',
    '4' => '4',
    '5' => '5',
    '6' => '6',
    '7' => '7',
    '8' => '8',
    '9' => '9',
    '０' => '0',
    '１' => '1',
    '２' => '2',
    '３' => '3',
    '４' => '4',
    '５' => '5',
    '６' => '6',
    '７' => '7',
    '８' => '8',
    '９' => '9',
    'ー' => 'ー',
);

my %norm_rule2 = (
    'あー' => 'ああ',
    'いー' => 'いい',
    'うー' => 'うう',
    'えー' => 'ええ',
    'おー' => 'おお',
    'かー' => 'かあ',
    'きー' => 'きい',
    'くー' => 'くう',
    'けー' => 'けえ',
    'こー' => 'こお',
    'さー' => 'さあ',
    'しー' => 'しい',
    'すー' => 'すう',
    'せー' => 'せえ',
    'そー' => 'そお',
    'たー' => 'たあ',
    'ちー' => 'ちい',
    'つー' => 'つう',
    'てー' => 'てえ',
    'とー' => 'とお',
    'なー' => 'なあ',
    'にー' => 'にい',
    'ぬー' => 'ぬう',
    'ねー' => 'ねえ',
    'のー' => 'のお',
    'はー' => 'はあ',
    'ひー' => 'ひい',
    'ふー' => 'ふう',
    'へー' => 'へえ',
    'ほー' => 'ほお',
    'まー' => 'まあ',
    'みー' => 'みい',
    'むー' => 'むう',
    'めー' => 'めえ',
    'もー' => 'もお',
    'やー' => 'やあ',
    'ゆー' => 'ゆう',
    'よー' => 'よお',
    'らー' => 'らあ',
    'りー' => 'りい',
    'るー' => 'るう',
    'れー' => 'れえ',
    'ろー' => 'ろお',
    'わー' => 'わあ',
    'をー' => 'をお',
    'んー' => 'んん',
    'ぁー' => 'ああ',
    'ぃー' => 'いい',
    'ぅー' => 'うう',
    'ぇー' => 'ええ',
    'ぉー' => 'おお',
    'っー' => 'つう',
    'ゃー' => 'やあ',
    'ゅー' => 'ゆう',
    'ょー' => 'よお',
    'ゎー' => 'わあ',
    'ゐー' => 'いい',
    'ゑー' => 'ええ',
    'がー' => 'があ',
    'ぎー' => 'ぎい',
    'ぐー' => 'ぐう',
    'げー' => 'げえ',
    'ごー' => 'ごお',
    'ざー' => 'ざあ',
    'じー' => 'じい',
    'ずー' => 'ずう',
    'ぜー' => 'ぜえ',
    'ぞー' => 'ぞお',
    'だー' => 'だあ',
    'ぢー' => 'ぢい',
    'づー' => 'づう',
    'でー' => 'でえ',
    'どー' => 'どお',
    'ばー' => 'ばあ',
    'びー' => 'びい',
    'ぶー' => 'ぶう',
    'べー' => 'べえ',
    'ぼー' => 'ぼお',
    'ぱー' => 'ぱあ',
    'ぴー' => 'ぴい',
    'ぷー' => 'ぷう',
    'ぺー' => 'ぺえ',
    'ぽー' => 'ぽお',

    'どぅ' => 'でゅ',
    'とぅ' => 'てゅ',
);

sub _normalize_furigana {
    (my $furigana, my %rule) = @_;
    foreach my $k (keys %rule) {
        $furigana =~ s/$k/$rule{$k}/g;
    }
    return $furigana;
}

sub normalize_furigana {
    (my $furigana) = @_;
    utf8::is_utf8($furigana) or die;
    is_valid_chars($furigana) or die;

    $furigana = _normalize_furigana($furigana, %norm_rule2);
    $furigana = _normalize_furigana($furigana, %norm_rule1);

    return $furigana;
}

sub is_valid_chars {
    (my $furigana) = @_;

    foreach my $c (split(//, $furigana)) {
        if (!grep(/$c/, keys %norm_rule1)) { return 0; }
    }
    return 1;
}
