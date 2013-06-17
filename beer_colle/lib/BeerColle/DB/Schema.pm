package BeerColle::DB::Schema;
use DateTime;
use DateTime::Format::Strptime;
use DateTime::Format::MySQL;
use DBIx::Skinny::Schema;

install_table User => schema{
    pk 'unique_id';
    columns qw/unique_id screen_name fb_id tw_id/;
};

install_table BeerAlbum => schema{
    pk 'id';
    columns qw/id beer_id user_id rating note tstamp appearance aroma flavor taste/;
};

install_inflate_rule 'tstamp' => callback {
    inflate {
        my $value = shift;
        my $dt = DateTime::Format::Strptime->new(
            pattern => '%Y-%m-%d %H:%M:%S',
            time_zone => 'Asia/Tokyo',
        )->parse_datetime($value);
        return DateTime->from_object(object => $dt);
    };
    deflate{
        my $value = shift;
        return DateTime::Format::MySQL->format_datetime($value);
    };
};

1;
