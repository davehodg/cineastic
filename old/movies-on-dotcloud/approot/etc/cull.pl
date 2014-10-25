#!/usr/bin/perl
use lib qw /lib/ ;

use Output::Database ;
use Config::Any;
use Data::Dumper;

my $cfg = Config::Any->load_files({files => ['config.yml'] });

my $o = Output::Database->new($cfg->[0]{'config.yml'});
my $dbh = $o->{dbh} ;

my $sql = "select id  FROM movie LEFT OUTER JOIN product ON movie.id = product.movie_id where product.product_id IS NULL" ;

my $ary_ref  = $dbh->selectall_arrayref($sql);

#warn Dumper($ary_ref);


my $sth = $dbh->prepare("DELETE FROM movie WHERE id = ?") or die "prepare";

foreach my $id ( @{ $ary_ref} ) {
    $sth->execute($id->[0]) or die $dbh->errstr;
}
