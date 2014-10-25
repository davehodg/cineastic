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



LOGIN: {
  my $BASE = 'http://localhost:5001/site/loginsubmit' ;
  my $uri = URI->new($BASE) ;

  # first login
  $uri->query_form(
		   email    => 'davehodg@me.com',
		   password => 'password'
		  ) ;
  ok(my $user1 = get($uri->as_string), "Login") ;
}


done_testing;