package BeerColle::Controller::API;
use Mojo::Base 'Mojolicious::Controller';
use BeerColle::Util qw/check_hash/;

#iPhoneからのサインイン
sub signin {
    my $self = shift;

    #POSTされたJSONからハッシュが一致するかチェック
    my $auth = $self->req->json->{auth};
    unless (BeerColle::Util::check_hash($auth->{id}, $self->app->secret, $auth->{hash})){
        #403 Forbidden
        $self->render(text => 'Authorization error', status => 403);
        return;
    }

    #新規のユーザー登録
    $self->model->insert_new_user($auth->{service}, $auth->{id});
    #200 OK
    $self->render(text => 'Accept signin', status => 200);
}

#iPhoneからデータを受け取ってDBを更新し、iPhoneの最終更新より新しいデータを返す
#認証も忘れずに
sub sync{
    my $self = shift;
    my $last_updated = $self->req->json->{last_updated};
    my $auth = $self->req->json->{auth};
    my $send_beeralbums = $self->req->json->{beeralbums};

    my $hash = BeerColle::Util::hash_sha256($auth->{id}, $self->app->secret);
    unless (BeerColle::Util::hash_sha256($auth->{id}, $self->app->secret) eq $auth->{hash}){
        #403 Forbidden
        $self->render(text => 'Authorization error', status => 403);
        return;
    }

    my $user_id = $self->model->select_user_id($auth->{service}, $auth->{id});

    #iPhoneでの変更をDBに送信
    $self->model->update_beeralbums($user_id, $send_beeralbums);

    #DBからiPhoneの最終更新日より新しいbeeralbumを取得
    my $receive_beeralbums = $self->model->select_updated_beeralbums($user_id, $last_updated);

    $self->render(json => $receive_beeralbums, status => 200);

    # $self->render(json => {beer_id => 1}, status => 200);
}
1;
