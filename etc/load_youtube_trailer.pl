#!/usr/bin/env perl

#!/usr/bin/perl

use strict;
use warnings;

use lib qw /lib/ ;
use Input::YouTubeTrailer;
use Output::Database;
use Data::Dumper;

my $a = Input::YouTubeTrailer->new ;

my $stuff = $a->read_input ;

my $o = Output::Database->new;
#$o->product_save($stuff);


