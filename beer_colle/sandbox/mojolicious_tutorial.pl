#!/usr/bin/env perl
use Mojolicious::Lite;

# Documentation browser under "/perldoc"
plugin 'PODRenderer';

get '/' => sub {
	my $self = shift;
	$self->render('index');
};

#テキストを返す
get '/text' => {text => 'I love mojolicious'};

#プレースホルダーを使ったルート
get '/place/:foo' => sub{
	my $self = shift;
	my $foo = $self->param('foo');
	$self->render(text => "Hello from $foo!");
};

#stashはテンプレートに変数を渡せる
get '/num' => sub{
    my $self = shift;
    my $num = $self->param('q');
    $self->stash(one => $num);
    $self->render('num', two => $num+2);
};

#テンプレートが存在すれば省略可能
#ブロックはテンプレート内でperlの関数のように利用できる
get '/block';

#content_forはキャプチャーされたブロックを渡す
get 'login';

#セッション開始
post 'login' => sub{
    my $self = shift;
    my $id = $self->param('id');
    my $passwd = $self->param('passwd');
    $self->session(id => $id);
    $self->session(passwd => $passwd);
    $self->redirect_to('/')
};

#セッション終了。クッキーの破棄
get 'logout' => sub{
    my $self = shift;
    # clear session
    $self->session(expires => 1);
    $self->redirect_to('/')
};

#/json
get 'json' => sub{
    my $self = shift;
    $self->render(json => {hello => 'world', perl => 'mojolicious'});
};

app->start;
__DATA__

@@ index.html.ep
% layout 'default';
% title 'Welcome';
Welcome to the Mojolicious real-time web framework!

@@ layouts/default.html.ep
<!DOCTYPE html>
<html>
  <head><title><%= title %></title></head>
  <body><%= content %><br>
    Welcome: <%= session 'id' %><br>
    Your password: <%= session 'passwd' %><br>
    %= link_to Login => 'login'
    %= link_to Logout => 'logout'
  </body>
</html>

@@ num.html.ep
You GET <%= $one%> and <%= $one%> + 2 = <%= $two%>.

@@block.html.ep
% my $button = begin
    % my ($url, $name) = @_;
    Try <%= link_to $url => begin %><%= $name %><% end %>.
% end
<html>
    <body>
        %= $button->('http://mojolicious.us', 'Mojolicious')
    </body>
</html>

@@login.html.ep
% content_for form => begin
    <form method="POST" action="/login">
        <input type="text" name="id">
        <input type="text" name="passwd">
        <input type="submit" value="login">
    </form>
% end
<!DOCTYPE html>
<html>
  <head></head>
  <body>
    <%= content_for 'form' %>
  </body>
</html>
