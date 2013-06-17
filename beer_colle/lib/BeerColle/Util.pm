package BeerColle::Util;
use strict;
use warnings;
use utf8;
use Digest::SHA qw(hmac_sha256_hex);

sub get_hash{
    my ($value, $secret) = @_;
    return hmac_sha256_hex($value, $secret);
}

sub check_hash{
    my ($id, $secret, $cmp_hash) = @_;
    if (get_hash($id, $secret) eq $cmp_hash){
        return 1;
    }
    else{
        return 0;
    }
}
1;
