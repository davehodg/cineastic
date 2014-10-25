#!/usr/bin/perl

use strict;
use warnings;

use lib qw /lib/ ;
use Input::Lovefilm;
use Output::Database;
use Data::Dumper;

my $a = Input::Lovefilm->new ;
my $o = Output::Database->new;

my $stuff = $a->read_input;
#$o->product_save_xxx();


