package BeerColle::Model;
use Mojo::Base -base;

my $_db;

sub new{
    my ($class, $db) = @_;
    $_db = $db;

    bless {};
}

#fb_idもtw_idも登録されていない新規のユーザー登録
sub create_new_user{
    my ($self, $service, $id) = @_;
    my $row;
    if ($service eq 'facebook'){
        $row = $_db->find_or_create('User', {fb_id => $id});
    }
    elsif ($service eq 'twitter'){
        $row = $_db->find_or_create('User', {tw_id => $id});
    }
    return $row;
}

#SNSのIDからユニークユーザーIDの特定
# sub select_user_id{
#     my ($self, $service, $id) = @_;
#     my $row;
#     if ($service eq 'facebook'){
#         $row = $_db->single('User', {fb_id => $id});
#     }
#     elsif ($service eq 'twitter'){
#         $row = $_db->single('User', {tw_id => $id});
#     }
#
#     return $row->unique_id;
# }

#セッションIDからユニークユーザーIDの特定
sub select_userid{
    my ($self, $session) = @_;
    my $row = $_db->search('Session', {'session' => $session});
    return $row->user_id;
}

#本人のbeeralbumをすべて取得
sub select_beeralbums{
    my ($self, $user_id) = @_;
    my @row = $_db->search('BeerAlbum',
        {
            'user_id' => $user_id
        });
    return @row;
}

#引数の日付より新しいbeeralbumを取得
sub select_updated_beeralbums{
    my ($self, $user_id, $last_updated) = @_;
    my @row = $_db->search('BeerAlbum',
        {
            'user_id' => $user_id,
            'tstamp' => {'>' => $last_updated},
        });
    return @row;
}

#新しいbeeralbumの作成
sub create_beeralbum{
    my ($self, $user_id, $beeralbum) = @_;
    $beeralbum->{user_id} = $user_id;
    my $row = $_db->create('BeerAlbum', $beeralbum);
    return $row;
}

#既存のbeeralbumの更新
sub update_beeralbum{
    my ($self, $user_id, $beeralbum_id, $beeralbum) = @_;
    my $row = $_db->update('BeerAlbum', $beeralbum, {id => $beeralbum_id, user_id => $user_id});
    return $row;
}

#既存のbeeralbumの削除
sub delete_beeralbum{
    my ($self, $user_id, $beeralbum_id) = @_;
    $_db->delete('BeerAlbum', {id => $beeralbum_id, user_id => $user_id});
}

#beeralbumを更新
# sub update_beeralbums{
#     my ($self, $user_id, $send_beeralbums) = @_;
#     my $row;
#     foreach my $beeralbum (@$send_beeralbums){
#         #新しいレコードの追加
#         if ($beeralbum->{id} == 0){
#             delete($beeralbum->{id});
#             $_db->create('BeerAlbum', $beeralbum);
#         }
#         #idが一致するレコードの更新
#         else{
#             $_db->update('BeerAlbum', $beeralbum, {id => $beeralbum->{id}})
#         }
#     }
# }

1;
