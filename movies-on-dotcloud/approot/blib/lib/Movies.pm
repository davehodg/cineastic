package Movies ;
use base 'CGI::Application' ;
use CGI::Application::Plugin::ConfigAuto (qw/cfg/);

use strict ;
use warnings ;

use JSON ;
use Data::Dumper ;
#use DateTime ;
#use String::Random;

use Encode;
use HTML::Entities;
#use Digest::MD5 qw(md5 md5_hex md5_base64);
use Digest::SHA1  qw(sha1 sha1_hex sha1_base64);

use POSIX ;

#use Util;

use Output::Database;


sub setup {
    my $self = shift; 

    $self->start_mode('test') ;
    $self->mode_param('rm');
    $self->run_modes(
		     'test'            => 'test',
		     'movie'           => 'movie',
		     'movie_by_name'   => 'movie_by_name',
	             'ean'             => 'ean',
		     'ranking'         => 'ranking',
		     'auth'            => 'auth',
		     'fbauth'          => 'fbauth',
		     'review'          => 'review',
		     'user_reviews'    => 'user_reviews',
		     'movie_reviews'   => 'movie_reviews',
		     'friend_request'  => 'friend_request',
		     'friend_accept'   => 'friend_accept',
		     'friend_list'     => 'friend_list',
		     'friended_list'   => 'friended_list',
		     'suggest'         => 'suggest',
		     'register'        => 'register',
		     'movie'           => 'movie',
		     'search'          => 'search',
		     'genres'          => 'genres',
		     'all_genres'      => 'all_genres',
		     'actors'          => 'actors',
		     'latest_reviews'  => 'latest_reviews',
		     'latest_releases' => 'latest_releases',
		     ) ;



#    $self->{u}   = Util->new() ;
    $self->{database} = Output::Database->new(\%{$self->cfg}) ;

}


sub cgiapp_prerun {
  my $self = shift ;
  my %set_headers = $self->header_add
    (
     -type=>'application/json',
     -expires=>'+1d',
     -charset => 'utf-8',
    );

  my $q       = $self->query() ;
  $self->{params} = $q->Vars;
  $self->{json} = JSON->new;

  #
  # we can do the security validation here
  #
  #return if  $self->{params}->{rm} eq "makeAPIPrivateKey" ;
  #$secretKey = $self->{db}->get_secret_key_by_id($self->{params}->{id}) ;
  #warn Dumper($self->{params}) ;

}


sub cgiapp_postrun {
   my ($self, $output_ref) = @_;

   # this is a really good place to convert a hashref to
   # JSON and encode it



}

sub test {
    my $self = shift ;

    my %stuff = (
	foo => 'bar',
	baz => 'blech',
	);
    return encode_json(\%stuff);
}

##############################################################################
#
# authenticate
#
##############################################################################


sub auth {
  my $self = shift ;
  warn "*** auth" ;
  my $m = $self->{database}->{schema}->resultset('User')->search
    (
     {
      email => $self->{params}->{email}
      },
    )->first;

  if (!defined $m) {
    warn "Unknown user " .  $self->{params}->{email} ;
    return $self->{json}->pretty->encode({status => 'unknown user'}) ;
  }


  if (defined $self->{params}->{password}) {

    if (sha1_base64($self->{params}->{password}) ne $m->password) {
      warn "invalid password " .  $self->{params}->{password} ;
      return $self->{json}->pretty->encode({status => 'invalid password'}) ;
    }
  } else {
    # FB login... validate fb_id?


  }

  $m->token(sha1_base64( time . rand(100) . $m->password)) ;
  $m->update;

  my %data = $m->get_columns ;
  delete $data{password};

  #warn Dumper(\%data) ;

  return $self->{json}->pretty->encode(\%data) ;
}


sub authenticate {
  my ($self, $token) = @_ ;

  my $m = $self->{database}->{schema}->resultset('User')->search
    ({token => $token})->first;
  return 0 if !defined $m ;

  $self->{user} = {$m->get_columns} ;
  return 1 ;
}


sub fbauth {
  my $self = shift ;

  $self->{database}->{schema}->resultset('User')->update_or_create
      ({
	  email     => $self->{params}->{email},
	  firstname => $self->{params}->{firstname},
	  lastname  => $self->{params}->{lastname},
	  password  => $self->{params}->{password},
	  #fb_id     => $self->{params}->{fb_id},
       }) ;

  my $m = $self->{database}->{schema}->resultset('User')->search
    (
     {
      email => $self->{params}->{email}
      },
    )->first;

  if (!defined $m) {
    warn "Unknown user " .  $self->{params}->{email} ;
    return $self->{json}->pretty->encode({status => 'unknown user'}) ;
  }

  $m->token(sha1_base64( time . rand(100) . $m->password)) ;
  $m->update;

  my %data = $m->get_columns ;
  delete $data{password};
  warn "fbauth OK" ;

  warn Dumper(\%data) ;

  return $self->{json}->pretty->encode(\%data) ;
}


##############################################################################

sub movie_by_name {
  my $self = shift ;

  # I'm sure there's a smarter way of doing this
  my $m;
  if (defined $self->{params}->{year}) {
    $m = $self->{database}->{schema}->resultset('Movie')->search
      ({
	'me.title' => $self->{params}->{title},
	'me.year' =>  $self->{params}->{year}
       },
       {
	result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	order_by => { -desc => 'rating' },
	prefetch => [ qw/products supplier/],
       }
      ) ;
  } else {
    $m = $self->{database}->{schema}->resultset('Movie')->search
      ({
	'me.title' => $self->{params}->{title},
       },
       {
	   order_by => { -desc => 'rating' },
	   result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	   prefetch => [ qw/products supplier/],
       }
      ) ;  }

  my @results ;
  while (my $hashref = $m->next) {
    push @results, $hashref ;
  }



  return  encode_entities($self->{json}->pretty->encode(\@results),"\200-\x{ffffff}") ;
}

sub ean {
  my $self = shift ;

  my @movies = $self->{database}->{schema}->resultset('Movie')->search
      (
       {
	  'products.ean' => $self->{params}->{ean},
       },
       {
	result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	prefetch => 'products',
       }
      )->all ;  
 return encode_entities($self->{json}->pretty->encode(\@movies),"\200-\x{ffffff}") ;
}



sub ranking {
  my $self = shift ;

  my $m = $self->{database}->{schema}->resultset('Movie')->search
   (
    {},
    {
     rows     => $self->{params}->{limit} || 10,
     order_by => { -desc => 'rating' },
     result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     prefetch => 'products',
    }
   );

  my @results ;
  while (my $hashref = $m->next) {
    push @results, $hashref ;
  }

  my $t = $self->{json}->pretty->encode(\@results) ;
  return encode_entities($t,"\200-\x{ffffff}") ;
}



##############################################################################
# review stuff

sub review {
  my $self = shift ;


  return $self->{json}->pretty->encode({status => 'token not valid'})
    if !$self->authenticate($self->{params}->{token}) ;

  delete $self->{params}->{rm} ;
  delete $self->{params}->{token} ;

  #warn Dumper($self->{params}) ;
  $self->{database}->{schema}->resultset('Review')->update_or_create($self->{params}) ;

 return $self->{json}->pretty->encode({ status => "review posted"}) ;
}

sub user_reviews {
  my $self = shift ;


  my $r = $self->{database}->{schema}->resultset('Review')->search
   (
    {
     user_id => $self->{params}->{user_id}
    },
    {
     result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     order_by     => { -desc => 'me.id' },
     rows         => $self->{params}->{limit} || 5,
     prefetch     => 'movie',
    }
   );

  my @results ;
  while (my $hashref = $r->next) {
    push @results, $hashref ;
  }
  return encode_entities($self->{json}->pretty->encode(\@results),"\200-\x{ffffff}") ;

}

sub movie_reviews {
  my $self = shift ;

  my $r = $self->{database}->{schema}->resultset('Review')->search
   (
    {
     movie_id => $self->{params}->{movie_id}
    },
    {
     result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     prefetch     => 'user',
    }
   );

  my @results ;
  while (my $hashref = $r->next) {
    push @results, $hashref ;
  }
  return encode_entities($self->{json}->pretty->encode(\@results),"\200-\x{ffffff}") ;
}


##############################################################################
# friend stuff

# Make a friend request - add ID pairs and a confirm flag

# friend=friend@friend.com

sub friend_request {
  my $self = shift ;

  return $self->{json}->pretty->encode({status => 'token not valid'})
    if !$self->authenticate($self->{params}->{token}) ;

  my $friend = $self->{database}->{schema}->resultset('User')->search
    ({email => $self->{params}->{friend}})->first;

  return  $self->{json}->pretty->encode({status => 'friend email not found'})
    if !defined $friend;

  my %data = (
	      user_id   => $self->{user}->{user_id},
	      friend_id => $friend->id,
	      pending   => 1,
	     ) ;

  $self->{database}->{schema}->resultset('Friend')->update_or_create(\%data) ;

  return $self->{json}->pretty->encode({status => "friendship requested"}) ;

}

# Accept a friend request
sub friend_accept {
  my $self = shift ;

  return $self->{json}->pretty->encode({status => 'token not valid'})
    if !$self->authenticate($self->{params}->{token}) ;

  my $friend = $self->{database}->{schema}->resultset('User')->search
    ({email => $self->{params}->{friend}})->first;

  return  $self->{json}->pretty->encode({status => 'friend email not found'})
    if !defined $friend;

  #warn "this user: ", Dumper($self->{user}) ;
  #warn "friend: ", Dumper({$friend->get_columns}) ;

  my %data = (
	      user_id   => $friend->id,
	      friend_id => $self->{user}->{user_id},
	      pending   => 0,
	     ) ;

  $self->{database}->{schema}->resultset('Friend')->update_or_create(\%data) ;

  return $self->{json}->pretty->encode({status => "friendship requested"}) ;

}

# get a list of my friends

sub friend_list {
  my $self = shift ;

  return $self->{json}->pretty->encode({status => 'token not valid'})
    if !$self->authenticate($self->{params}->{token}) ;

  my $friends_rs = $self->{database}->{schema}->resultset('Friend')->search
    ({ 'me.user_id' => $self->{user}->{user_id}},
     {result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     prefetch => 'friend',
     '+columns' => [ 'friend.email'] }
);

  my @results ;
  while (my $hashref = $friends_rs->next) {
    delete $hashref->{id} ;
    delete $hashref->{friend}->{password} ;
    delete $hashref->{friend}->{user_id} ;
    delete $hashref->{friend}->{token} ;

    push @results, $hashref ;
  }
  return $self->{json}->pretty->encode(\@results) ;
}



# get a list of who has friended me

sub friended_list {
   my $self = shift ;

  return $self->{json}->pretty->encode({status => 'token not valid'})
    if !$self->authenticate($self->{params}->{token}) ;

  my $friends_rs = $self->{database}->{schema}->resultset('Friend')->search
    ({ 'me.friend_id' => $self->{user}->{user_id}},
     {result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     prefetch => 'friend',
     '+columns' => [ 'friend.email'] }
);

  my @results ;
  while (my $hashref = $friends_rs->next) {
    delete $hashref->{id} ;
    delete $hashref->{friend}->{password} ;
    delete $hashref->{friend}->{user_id} ;
    delete $hashref->{friend}->{token} ;

    push @results, $hashref ;
  }
  return $self->{json}->pretty->encode(\@results) ;
}

sub suggest {
  my $self = shift ;

  # draw from the top 10,000 rated films

  my $r = 1-rand ;
  my $rand = floor(500*sqrt(sqrt($r))) ;
  my @suggestions = $self->{database}->{schema}->resultset('Movie')->search
    (
     {
	 rating => { '>=', 7 },
	 year   => { '>=', 1980},

     },
     {
	 result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	 order_by     => { -desc => 'rating' },
	 page         => $rand,
	 rows         => $self->{params}->{number} || 1,
     }
)->all;
   return encode_entities($self->{json}->pretty->encode(\@suggestions),"\200-\x{ffffff}") ;
}

sub movie {
  my $self = shift ;

  # get stuff about a movie

  my @movies = $self->{database}->{schema}->resultset('Movie')->search
    (
     {
	 'me.id' =>  $self->{params}->{id}
     },
     {
	 result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	 #rows         => $self->{params}->{number} || 1,
	 prefetch => { 'products' => 'supplier' },

	 # join => { "product" => { "brand_products" => "brand" } },
	 order_by     => { -asc => 'products.price' },
	 #distinct =>1,
     }
)->all;


  my @genres = $self->{database}->{schema}->resultset('MovieGenre')->search
    (
     {
      'me.movie_id' =>  $self->{params}->{id},
     },
     {
      prefetch     => 'genre',
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     }
    );
  $movies[0]->{genres} = \@genres;


  my @actors = $self->{database}->{schema}->resultset('MovieActor')->search
    (
     {
      'me.movie_id' =>  $self->{params}->{id},
     },
     {
      prefetch     => 'actor',
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
     }
    );
  $movies[0]->{actors} = \@actors;



  #warn Dumper(\@genres) ;
  #warn Dumper(\@movies) ;

   return encode_entities($self->{json}->pretty->encode(\@movies),"\200-\x{ffffff}") ;

}



sub register {
  my $self = shift ;

  # select by email to see if we're registered
  my $m = $self->{database}->{schema}->resultset('User')->search
    (
     {
      email => $self->{params}->{email}
      },
    )->first;

  if (defined $m) {
    return $self->{json}->pretty->encode({status => 'already registered'}) ;
  }

  $self->{database}->{schema}->resultset('User')->create
      ({
	  email     => $self->{params}->{email},
	  password  => sha1_base64($self->{params}->{password}),
	  firstname => $self->{params}->{firstname},
	  lastname  => $self->{params}->{lastname},
       }) ;

  warn "registration OK" ;
  return $self->{json}->pretty->encode({status => 'ok'}) ;

}




sub search {
  my $self = shift ;

  warn  $self->{params}->{search} ;
  my @terms = split(' ', $self->{params}->{search}) ;

  foreach (@terms) {
      $_ = "%" . $_ . "%" ;
  }

  my @terms1 = map { { title => {'-like' => $_ }}} @terms  ;
  my @movies = $self->{database}->{schema}->resultset('Movie')->search
    (
     {
	 -and => [ map { { title => {'-like' => $_ }}} @terms ]
     },
     {
	 result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	 rows         => $self->{params}->{number} || 30,
	 order_by     => { -desc => 'rating' },
     }
)->all;
   return encode_entities($self->{json}->pretty->encode(\@movies),"\200-\x{ffffff}") ;

 status => { -like => ['pending%', 'dispatched'] },

}


sub all_genres {
  my $self = shift ;
  my @genres = $self->{database}->{schema}->resultset('Genre')->search
      ({},
       {
	   result_class => 'DBIx::Class::ResultClass::HashRefInflator',
       }
      )->all;


   return encode_entities($self->{json}->pretty->encode(\@genres),"\200-\x{ffffff}") ;
}



sub genres {
  my $self = shift ;

  # get stuff about a movie

  my $from = $self->{params}->{decade} || 1900 ;
  my $to = ($from == 1900 ? 2020 : $from + 9) ;

  warn $from;
  warn $to;

  my @movies = $self->{database}->{schema}->resultset('Movie')->search
    (
     {
      'movie_genres.genre_id' =>  $self->{params}->{genre_id},
      -and => [ 
	       year => { '>=' , $from },
	       year => { '<=' , $to },
	      ],
     },
     {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
      prefetch => { 'movie_genres' => 'genre'},
      order_by     => { -desc => 'me.rt_critic' },
      rows         => $self->{params}->{number} || 20,
      offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
     }
    )->all;
  #warn Dumper(\@genres) ;
  #warn Dumper(\@movies) ;

   return encode_entities($self->{json}->pretty->encode(\@movies),"\200-\x{ffffff}") ;

}


sub actors {
  my $self = shift ;

  # get stuff about a movie

  my @movies = $self->{database}->{schema}->resultset('Movie')->search
    (
     {
	 'movie_actors.actor_id' =>  $self->{params}->{actor_id}
     },
     {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
      prefetch     => { 'movie_actors' => 'actor'},
      order_by     => { -desc => 'me.year' },
      rows         => $self->{params}->{number} || 20,
      offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
     }
    )->all;

  return encode_entities($self->{json}->pretty->encode(\@movies),"\200-\x{ffffff}") ;

}


sub latest_reviews {
  my $self = shift ;

  # get stuff about a movie

  my @reviews = $self->{database}->{schema}->resultset('Review')->search
    (
     {
      wanttosee => 0,
     },
     {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
      prefetch     => [ 'user', 'movie' ],
      order_by     => [ { -desc => 'updated' }, { -desc => 'me.id' } ],
      rows         => $self->{params}->{number} || 20,
      offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
     }
    )->all;

  #warn Dumper(\@reviews) ;

  return encode_entities($self->{json}->pretty->encode(\@reviews),"\200-\x{ffffff}") ;

}


sub latest_releases {
  my $self = shift ;

  warn "************** latest releases" ;

  # get stuff about a movie

# select distinct(release_date) from product where release_date <= now() order by release_date desc limit 1 ;

  if (0) {
  my $release_date = $self->{database}->{schema}->resultset('Product')->search
      (
       {
	   'me.release_date' => { '<=' => \ 'NOW()' },
       },
       {
	   columns => [ { release_date => 'release_date' } ],
           distinct =>1,
	   order_by     => [  { -desc => 'me.release_date' }, ],
	   rows         => 1,
    })->first->release_date ;

  #warn $release_date ;
  }
  my @releases = $self->{database}->{schema}->resultset('Product')->search
    (
     {
      'me.release_date' => { '<=', \ 'NOW()' },
      'movie.year' => { '>=', 2011, },
      'movie.rt_img_det' => { '!=', undef },
      #'movie.rt_critic' => { '!=', undef },
     },
     {
      columns => [ 
          { title => 'movie.title'}, 
          { id => 'movie.id'}, 
          'release_date', 
          { year => 'movie.year'},
          { image => 'movie.rt_img_det'},
	  #{ supplier_image => 'me.image_url' },
          # { rating => 'movie.rt_critic' },
      ],
      distinct => 1,
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
	  #prefetch     => 'movie',
      join      => 'movie',
	  #order_by     => [  { -desc => 'movie.rt_critic' }, ],
	  order_by     => [  { -desc => 'me.release_date' }, { -desc => 'movie.year' },  { -desc => 'movie.rt_critic' },],
      rows         => $self->{params}->{number} || 10,
      offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
     }
    )->all;

  #warn Dumper(\@releases) ;
  return encode_entities($self->{json}->pretty->encode(\@releases),"\200-\x{ffffff}") ;

}




1;
