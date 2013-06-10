package BeerColle;
use Mojo::Base 'Mojolicious';

# This method will run once at server start
sub startup {
    my $self = shift;

    $self->helper(
        'facebook' => sub{
            my $c = shift;
            my $fb = Facebook::Graph->new(
                app_id => '131156153751414',
                secret => '64d3412a6a479ce63c1bab7aa75f58ef',
                postback => 'http://localhost:3000/callback'
            );
        }
    );

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  # Normal route to controller
  $r->get('/')->to('auth#index');
  $r->get('/login')->to('auth#login');
  $r->get('/callback')->to('auth#callback');
  $r->get('/logout')->to('auth#logout');
}

1;
