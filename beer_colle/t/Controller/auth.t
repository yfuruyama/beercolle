use strict;
use warnings;
use utf8;
use Test::More tests => 2;
use Test::Mojo;
use lib '../../lib';
use BeerColle::Util qw/get_hash check_hash/;
use Mojo::JSON;

my $json = Mojo::JSON->new;

my $t = Test::Mojo->new('BeerColle');
use_ok('BeerColle::Controller::Auth');

subtest '/api/signin' => sub{
    my $auth = {auth => {
            service => 'facebook',
            id => 123456789123456,
            hash => BeerColle::Util::get_hash(123456789123456, $t->app->secret)
        }
    };
    #Authorization success
    $t->post_ok('/api/signin' => $json->encode($auth))
      ->status_is(200);

    #Authorization fail
    $auth->{auth}->{hash} = 'some_different_hash_value';
    $t->post_ok('/api/signin' => $json->encode($auth))
      ->status_is(403);
}
