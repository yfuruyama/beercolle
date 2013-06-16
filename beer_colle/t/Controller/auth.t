use strict;
use warnings;
use utf8;
use Test::More tests => 2;
use Test::Mojo;
use lib '../../lib';
use BeerColle::Util qw/hash_sha256/;
use Mojo::JSON;

my $json = Mojo::JSON->new;

my $t = Test::Mojo->new('BeerColle');
use_ok('BeerColle::Controller::Auth');

subtest '/signin' => sub{
    my $auth = {auth => {
            service => 'facebook',
            id => 123456789123456,
            hash => BeerColle::Util::hash_sha256(123456789123456, $t->app->secret)
        }
    };
    #Authorization success
    $t->post_ok('/signin' => $json->encode($auth))
      ->status_is(200);

    #Authorization fail
    $auth->{auth}->{hash} = 'some_different_hash_value';
    $t->post_ok('/signin' => $json->encode($auth))
      ->status_is(403);
}
