use strict;
use warnings;
use utf8;
use Test::More tests => 3;
use Test::Mojo;
use lib '../lib';
use Test::mysqld;
use DateTime;
use BeerColle::DB;
use BeerColle::Model;

my $t = Test::Mojo->new('BeerColle');

my $mysqld = Test::mysqld->new(
    my_cnf => {'skip-networking' => ''}
) or plan skip_all => $Test::mysqld::errstr;

my $db = BeerColle::DB->new({dsn => $mysqld->dsn});
my $model = BeerColle::Model->new($db);

my $sql;
{
    local $/ = undef;
    open(my $fh, '<', '../../mysql/User-DDL.sql') or die 'Failed to open User-DDL.sql';
    $sql = <$fh>;
    close($fh);

    $db->do($sql);
    open($fh, '<', '../../mysql/BeerAlbum-DDL.sql') or die 'Failed to open BeerAlbum-DDL.sql';
    $sql = <$fh>;
    close($fh);
}

my $test_userid;

subtest 'create_new_user' => sub{
    my $row = $model->create_new_user('facebook', '10001');
    $test_userid = $row->unique_id;
    is($row->unique_id, 1);
    is($row->fb_id, '10001');
};

subtest 'create_beeralbum' => sub{
    my $beeralbum = {
        user_id => $test_userid,
        beer_id => 1,
        rating => 4.50,
        note => 'update record',
        tstamp => DateTime->now(time_zone => 'local'),
        appearance => '黒',
        aroma => '鼻から香る匂い',
        flavor => '口に入れた後、鼻から抜ける匂い',
        taste => '苦い'
    };
    my $row = $model->create_beeralbum($test_userid, $beeralbum);
    is($row->id, 1);
};
