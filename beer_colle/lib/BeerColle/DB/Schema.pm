package BeerColle::DB::Schema;
use DBIx::Skinny::Schema;

install_table User => schema{
    pk 'unique_id';
    columns qw/unique_id screen_name fb_id tw_id/;
};
1;
