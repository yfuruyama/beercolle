use strict;
use warnings;
use utf8;
use Test::More tests => 2;
use lib '../lib';

use_ok('BeerColle::Util');

my $hash = BeerColle::Util->hash_sha256('value', 'secret');
is $hash, 'cd26cf4827f0e065ccffe024e8b602c7a3a0b421e5eb81de7184e744ef186dfa';
