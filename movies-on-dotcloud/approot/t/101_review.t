use strict;
use warnings;

use Data::Dumper;
use Test::More;
use LWP::Simple;
use URI::Escape;
use JSON;


my $BASE = 'http://localhost:5001/' ;

# first login

ok(my $user = decode_json(get($BASE . '?rm=auth&email=davehodg@me.com&password=password')), "Login") ;
is($user->{email}, 'davehodg@me.com', "Got right email") ;

my $token = $user->{token} ;
my $user_id = $user->{user_id} ;
ok($token, "token") ;

# now get back a movie

ok(my $movie = decode_json(get($BASE . '?rm=movie_by_name&title=The+Bourne+Ultimatum&year=2007')), "Get movie") ;
is($movie->[0]->{title}, 'The Bourne Ultimatum',"Right title") ;

#warn Dumper($movie) ;
my $movie_id = $movie->[0]->{id} ;
#warn $movie_id;
ok(my $review = decode_json(get($BASE . "?rm=review&token=$token&wanttosee=1&movie_id=$movie_id&user_id=$user_id")), "Wanttosee") ;

ok(my $review1 = decode_json(get($BASE . "?rm=review&token=$token&wanttosee=0&review=quite+good&rating=5&movie_id=$movie_id&user_id=$user_id")), "Get movie") ;

ok(my $user_reviews = decode_json(get($BASE . "?rm=user_reviews&token=$token&user_id=$user_id")), "Get user review") ;

#warn Dumper($user_reviews) ;
is ($user_reviews->[0]->{review},"quite good","Review text") ;

ok(my $movie_reviews = decode_json(get($BASE . "?rm=movie_reviews&token=$token&movie_id=$movie_id")), "Get movie review") ;

#warn Dumper($movie_reviews) ;
is ($movie_reviews->[0]->{review},"quite good","Review text") ;

done_testing;
