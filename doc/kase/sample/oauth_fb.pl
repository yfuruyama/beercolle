#!/usr/bin/env perl
use Mojolicious::Lite;
use Facebook::Graph;

helper 'facebook' => sub{
    my $c = shift;
    my $fb = Facebook::Graph->new(
        app_id => '131156153751414',
        secret => '64d3412a6a479ce63c1bab7aa75f58ef',
        postback => 'http://localhost:3000/callback'
    );
};

get '/' => sub {
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
};

get '/login' => sub{
    my $self = shift;
    my $fb = $self->facebook;
    #OAuthで委譲してもらう権限の設定
    #qwは空白区切りで配列に文字列を格納するPerlの演算子
    # my $uri = $fb->authorize->extend_permissions(qw/user_events/)->uri_as_string;
    my $uri = $fb->authorize->uri_as_string;
    $self->redirect_to($uri);
};

get '/callback' => sub{
    my $self = shift;
    my $fb = $self->facebook;
    #reqは何
    $fb->request_access_token($self->req->param('code'));
    $self->session('access_token' => $fb->access_token);

    $self->redirect_to('/');
};

get '/logout' => sub{
    my $self = shift;
    $self->session('access_token' => undef);
    $self->redirect_to('/');
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
% if($user){
    Welcome <%= $user->{name} %><br/>
    <%= link_to Logout => 'logout' %><br/>

    Your friend:<br/>
%   foreach my $friend (@$friends){
    <%= $friend->{name} %><br/>
%   }
%}else{
    <%= link_to Login => 'login' %>
%}

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %></body>
</html>
