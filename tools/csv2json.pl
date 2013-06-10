#!/usr/bin/env perl

use strict;
use warnings;
use Text::CSV_XS;
use List::MoreUtils qw(zip); 
use Getopt::Long qw(:config posix_default no_ignore_case gnu_compat);
use JSON;
use Data::Dumper;

sub parse_mysql_schema {
    my $csv = Text::CSV_XS->new({sep_char=>'	'});
    my $fh = shift;

    # skip header
    <$fh>;

    my @schema;
    while (<$fh>) {
        next unless $csv->parse($_);
        my($field, $type) = $csv->fields;
        $type =~ s/(.*)\(.*\)/$1/;
        my $column = {
            field => $field,
            type => $type
        };
        push(@schema, $column);
    }
    return \@schema;
}

sub read_rows {
    my($schema, $fh) = @_;
    # set binary=>1 to parse Japanese
    my $csv = Text::CSV_XS->new({binary=>1});

    my @rows;
    while (<$fh>) {
        next unless $csv->parse($_);
        my @fields = $csv->fields;
        my %row;
        for (my $i = 0; $i < @fields; $i++) {
            my $field = $$schema[$i]->{field};
            my $mysql_type = $$schema[$i]->{type};
            my $value = $fields[$i];
            $row{$field} = mysql_type_to_native_type($mysql_type, $value);
        }
        push(@rows, \%row);
    }
    return \@rows;
}

sub mysql_type_to_native_type {
    my($mysql_type,$value) = @_;
    if ($value eq "\\N") {
        return undef;
    }

    if ($mysql_type =~ /char|varchar/) {
        return $value;
    } elsif ($mysql_type =~ /int|decimal/) {
        return $value + 0;
    }
}

sub out_json {
    my($rows, $fh) = @_;
    my $json = JSON->new->allow_nonref->pretty;
    print $fh $json->encode($rows);
}

sub main {
    my $schema_file;
    GetOptions(
        "schema|s=s" => \$schema_file,
    );

    # read schema and rows
    open my $fh, "<", $schema_file or die;
    my $schema = parse_mysql_schema($fh);
    my $rows = read_rows($schema, *STDIN);

    # output
    out_json($rows, *STDOUT);
}

# executed if this script is executed directly. 
unless (caller) {
    main();
}
