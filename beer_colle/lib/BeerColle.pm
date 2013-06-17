package BeerColle;
use Mojo::Base 'Mojolicious';
use BeerColle::DB;
use BeerColle::Model;

# This method will run once at server start
sub startup {
    my $self = shift;
    my $config = $self->plugin('Config', {file => 'beercolle.conf'});

    $self->attr(db => sub{ BeerColle::DB->new($config->{db}) } );
    $self->attr(secret => $config->{secret});

    $self->helper(
        facebook => sub{
            return Facebook::Graph->new($config->{facebook});
        }
    );
    $self->helper(
        'model' => sub{
            return BeerColle::Model->new($self->db);
        }
    );

  # Documentation browser under "/perldoc"
  $self->plugin('PODRenderer');

  # Router
  my $r = $self->routes;

  $r->namespaces(['BeerColle::Controller']);
  # Normal route to controller
  $r->get('/')->to('auth#index');
  $r->get('/login')->to('auth#login');
  $r->get('/callback')->to('auth#callback');
  $r->get('/logout')->to('auth#logout');
  $r->post('/api/signin')->to('API#signin');
}

1;
