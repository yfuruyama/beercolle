package BeerColle::Model;
use Mojo::Base -base; 

my $_db;

sub new{
    my ($class, $db) = @_;
    $_db = $db;

    bless {};
}

#fb_idもtw_idも登録されていない新規のユーザー登録
sub insert_new_user{
    my ($self, $service, $id) = @_;
    my $row;
    if ($service eq 'facebook'){
        $row = $_db->find_or_create('User', {fb_id => $id});
    }
    elsif ($service eq 'twitter'){
        $row = $_db->find_or_create('User', {tw_id => $id});
    }
}

1;
