package BeerColle::Controller::Auth;
use Mojo::Base 'Mojolicious::Controller';
use Facebook::Graph;
use BeerColle::Util qw/hash_sha256/;

sub index {
    my $self = shift;
    my ($user, $friends);

    #ログイン済みでアクセストークンを持っているか確認
    if(my $access_token = $self->session('access_token')){
        my $fb = $self->facebook;
        $fb->access_token($access_token);
        $user = $fb->fetch('me');
        $friends = $fb->fetch('me/friends')->{data};

        $self->app->log->info("access_token: $access_token");
    }
        $self->stash->{user} = $user;
        $self->stash->{friends} = $friends;
        $self->render('index');
}

sub login {
    my $self = shift;
    my $fb = $self->facebook;
    #OAuthで委譲してもらう権限の設定
    #qwは空白区切りで配列に文字列を格納するPerlの演算子
    # my $uri = $fb->authorize->extend_permissions(qw/user_events/)->uri_as_string;
    my $uri = $fb->authorize->uri_as_string;
    $self->redirect_to($uri);
}


sub callback {
    my $self = shift;
    my $fb = $self->facebook;
    #reqは何
    $fb->request_access_token($self->req->param('code'));
    $self->session('access_token' => $fb->access_token);

    $self->redirect_to('/');
}

sub logout {
    my $self = shift;
    $self->session('access_token' => undef);
    $self->redirect_to('/');
}

#iPhoneからのサインイン
sub signin {
    my $self = shift;

    #POSTされたJSONからハッシュが一致するかチェック
    my $auth = $self->req->json->{auth};
    my $hash = BeerColle::Util::hash_sha256($auth->{id}, $self->app->secret);
    unless (BeerColle::Util::hash_sha256($auth->{id}, $self->app->secret) eq $auth->{hash}){
        #403 Forbidden
        $self->render(text => 'Authorization error', status => 403);
        return;
    }
    
    #新規のユーザー登録
    $self->model->insert_new_user($auth->{service}, $auth->{id});
    #200 OK 
    $self->render(text => 'Accept signin', status => 200);
}
1;
