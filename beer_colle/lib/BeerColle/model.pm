package BeerColle::Model;
use Mojo::Base -base; 

my $_db;

sub new{
    my ($class, $db) = @_;
    $_db = $db;

    bless {};
}

sub single{
    my $self = shift;
    my $number = $_db->single('user', {service => 'Facebook'});
    return $number;
}

1;
