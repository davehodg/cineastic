#!/usr/bin/perl

use strict;
use warnings;

use lib qw /lib/ ;
use Input::Amazon_delta;
use Output::Database;
use Data::Dumper;

my $a = Input::Amazon_delta->new ;

my $stuff = $a->read_input ;

my $o = Output::Database->new;
$o->product_save($stuff);


