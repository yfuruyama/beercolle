package BeerColle::DB::Schema;
use DBIx::Skinny::Schema;

install_table user => schema{
    pk 'hash_id';
    columns qw/hash_id service id/;
};
1;
