package Model::DB;
use DBIx::Skinny connect_info => +{
    dsn => "DBI:mysql:database=test",
    username => "beercolle",
    password => "dena"
};
1;

package Model::DB::Schema;
use DBIx::Skinny::Schema;

install_table user => schema{
    pk 'fb_id';
    columns qw/fb_id fb_access_token/;
};
1;
