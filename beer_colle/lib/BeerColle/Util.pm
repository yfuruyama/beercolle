package BeerColle::Util;
use strict;
use warnings;
use utf8;
use Digest::SHA qw(hmac_sha256_hex);

sub hash_sha256{
    my ($value, $secret) = @_;
    return hmac_sha256_hex($value, $secret);
}
1;
