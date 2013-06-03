use strict;
use warnings;
use Model::DB;

my $db = Model::DB->new();
# $db->do(q{
#     create table User(
#     fb_id INTEGER PRIMARY KEY,
#     fb_access_token VARCHAR(256)
#     ) 
# });

# my $row = $db->create('user', {fb_id => 4, fb_access_token => 'neko'});
# print $row->id;
# print $row->fb_access_token;
# 
# $db->update('user', {fb_access_token => 'dog'}, {id => $row->id});

#1行だけ読み出し
my $row = $db->single('user', {fb_id => 1});
print $row->fb_id, "\n";
print $row->fb_access_token, "\n";

#条件に合うrowをイテレーターで取得
my $iter = $db->search('user');
while (my $row = $iter->next){
    print $row->fb_id, "\n";
    print $row->fb_access_token, "\n";
}
