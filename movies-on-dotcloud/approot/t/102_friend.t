use strict;
use warnings;

use Data::Dumper;
use Test::More;
use LWP::Simple;
use URI::Escape;
use URI;
use JSON;

use strict;
use warnings;

my $BASE = 'http://localhost:5001/' ;
my $uri = URI->new($BASE) ;


# first login
$uri->query_form(
		 rm       => 'auth',
		 email    => 'davehodg@me.com',
		 password => 'password'
		 ) ;
ok(my $user1 = decode_json(get($uri->as_string)), "Login") ;
is($user1->{email}, 'davehodg@me.com', "Got right email") ;


# second login
$uri->query_form(
		 rm       => 'auth',
		 email    => 'davehodg+1@me.com',
		 password => 'password',
		 ) ;

ok(my $user2 = decode_json(get($uri->as_string)), "Login") ;
is($user2->{email}, 'davehodg+1@me.com', "Got right email") ;
my $token = $user2->{token} ;


# make a friend request
$uri->query_form(
		 rm       => 'friend_request',
		 token    =>  $user1->{token},
		 friend   =>  $user2->{email},
		 ) ;

ok(my $friend = decode_json(get($uri->as_string)), "Friend request") ;
is($friend->{status}, 'friendship requested',"friend request accepted") ;

# accept the friend request
$uri->query_form(
		 rm       => 'friend_accept',
		 token    =>  $user2->{token},
		 friend   =>  $user1->{email},
		 ) ;
ok(my $friend_a = decode_json(get($uri->as_string)), "Friend accept") ;
is($friend_a->{status}, 'friendship requested',"friend request accepted") ;

# who are my friends?
$uri->query_form(
		 rm       => 'friend_list',
		 token    =>  $user1->{token},
		 ) ;
ok(my $friends = decode_json(get($uri->as_string)), "Friend list") ;
warn Dumper($friends) ;

# who lists me as a friend?
$uri->query_form(
		 rm       => 'friended_list',
		 token    =>  $user1->{token},
		 ) ;
ok(my $friends = decode_json(get($uri->as_string)), "Friend list") ;
warn Dumper($friends) ;



done_testing;
