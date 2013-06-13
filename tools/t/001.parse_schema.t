#!/usr/bin/env perl

use strict;
use warnings;
use JSON;
use Test::More;
require 'csv2json.pl';

my $schema = <<'EOS';
Field	Type	Null	Key	Default	Extra
id	int(11)	NO	PRI	NULL	auto_increment
foo	varchar(128)	NO		NULL	
bar	char(2)	NO	MUL	NULL	
baz	decimal(3,1)	YES		NULL	
EOS

my $data = <<'EOS';
"1","foo","Fooo","4.12"
"2","バー","Bar","3.00"
"3","バズ","Baz",\N
EOS

my $types = [
    {
        field => "id",
        type => "int",
    },
    {
        field => "foo",
        type => "varchar",
    },
    {
        field => "bar",
        type => "char",
    },
    {
        field => "baz",
        type => "decimal",
    },
];

my $rows = [
    {
        id => 1,
        foo => "foo",
        bar => "Fooo",
        baz => 4.12,
    },
    {
        id => 2,
        foo => "バー",
        bar => "Bar",
        baz => 3.0,
    },
    {
        id => 3,
        foo => "バズ",
        bar => "Baz",
        baz => undef,
    },
];

my $json = <<'EOS';
[
    {
        "id": 1,
        "foo": "foo",
        "bar": "Fooo",
        "baz": 4.12
    },
    {
        "id": 2,
        "foo": "バー",
        "bar": "Bar",
        "baz": 3.0
    },
    {
        "id": 3,
        "foo": "バズ",
        "bar": "Baz",
        "baz": null
    }
]
EOS

subtest "parse mysql schema" => sub {
    open my $fh, "<", \$schema or die;
    my $got = parse_mysql_schema($fh);
    my $expected = $types;
    is_deeply $got, $expected;
};

subtest "read mysql data" => sub {
    open my $fh, "<", \$data or die;
    my $got = read_rows($types, $fh);
    my $expected = $rows;
    is_deeply $got, $expected;
};

subtest "output json data" => sub {
    my $got;
    my $expected = JSON->new->decode($json);
    open my $fh, ">", \$got or die;
    out_json($rows, $fh);
    $got = JSON->new->decode($got);

    is_deeply $got, $expected;
};

done_testing;
