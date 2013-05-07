#!/usr/bin/perl

use strict;
use warnings;

use lib qw /lib/ ;
use Input::IMDB;
use Output::Database;
#use Regexp::Debugger;

my $a = Input::IMDB->new ;
my $o = Output::Database->new;

$o->data_save($a->read_input);
$o->ratings_save($a->read_ratings);
