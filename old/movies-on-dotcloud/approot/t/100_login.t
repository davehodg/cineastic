
use Data::Dumper;
use Test::More;
use LWP::Simple;
use JSON;


my $BASE = 'http://localhost:5001/' ;

# first login

ok(my $user = decode_json(get($BASE . '?rm=auth&email=davehodg@me.com&password=password')), "Login") ;
is($user->{email}, 'davehodg@me.com', "Got right email") ;

warn Dumper($user) ;

# now get back a movie

ok(my $movie = decode_json(get($BASE . '?rm=movie&title=The+Bourne+Identity&year=2002')), "Get movie") ;
is($movie->[0]->{title}, 'The Bourne Identity',"Right title") ;


done_testing;
