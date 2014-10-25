use strict;
use warnings;

use Data::Dumper;
use Test::More;
use LWP::Simple;
use URI::Escape;
use URI;
use JSON;


my $BASE = 'http://localhost:5003/' ;
my $uri = URI->new($BASE) ;

my $email = rand(10000) . 'test@test.com' ;

# first login
$uri->query_form(
		 rm        => 'register',
		 email     => $email,
		 password  => 'password',
		 firstname => 'Dave',
		 lastname  => 'Hodgkinson',
		 ) ;

ok(my $user1 = decode_json(get($uri->as_string)), "Register") ;
is($user1->{status}, 'ok', "Registered OK") ;

ok($user1 = decode_json(get($uri->as_string)), "Register") ;
is($user1->{status}, 'already registered', "Not Registered OK") ;

done_testing;
