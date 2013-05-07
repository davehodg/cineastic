package Input::Rotten ;

use strict ;
use warnings ;

use JSON;
use LWP::Simple;
use Data::Dumper ;
use Encode;
#use Regexp::Debugger;
use URI::Escape;
use  Parallel::ForkManager;


my $BASE = "http://api.rottentomatoes.com/api/public/v1.0/" ;
my $API_KEY = "gcbmr856pzcwy7cqyabxemqj" ;

sub new {
    my ($class) = @_ ;
    my $obj = bless {}, $class ;

    $obj->{api_key} = "gcbmr856pzcwy7cqyabxemqj" ;
    $obj->{database} = Output::Database->new;
    $obj->{json} = JSON->new;

    return $obj ;
}


sub read_input {
    my $self = shift ;
    my @output_data ;

    my $schema = $self->{database}->{schema} ;

    #warn $schema ;
    warn "ook!";


    my $m_rs = $self->{database}->{schema}->resultset('Movie')->search
      ({
	  year => { '>=' => 2009 },
	#title => 'Haywire',
       },
       {
	order_by => { -desc => 'me.rating' },
	#rows => 5000,
	distinct => 1,
	join => 'products',
       }
      ) ;


    my $pm = new Parallel::ForkManager(1);
    my $i = 0 ;
    while ( my $m = $m_rs->next) {
      next if $m->title =~ /^\"/ ;

      #next if $m->title !~ /Haywire/ ;
      if ($m->year >= 1900) {

      #last if $i++ == 5000 ;

      my $pid = $pm->start and next;
      warn $m->title, " : ", $m->year;

      # first get the movie ID
      my $movie_uri =  $BASE . "movies.json?apikey=$API_KEY&page_limit=2&q=" 
	. uri_escape($m->title) ;


      #warn $movie_uri;

      my $movie_data ;
      my $get = cache_get($movie_uri) ;
      if ( defined $get ) {
	$movie_data = $self->{json}->decode($get) ;


	for my $i (0..1) {
	    my $rt_id = $movie_data->{movies}->[$i]->{id} ;
	    my $title =  $movie_data->{movies}->[$i]->{title} ;
	    #warn $title ;

	    my $movie_rs = $self->{database}->{schema}->resultset('Movie')->search
		(
		 {
		     title => $title,
		     year  => $m->year,

		 },{})->first ;


	    next if !defined $movie_rs		;
	    my $movie_id = $movie_rs->id;
	    #warn $movie_id;
	    #warn $rt_id;
	    #warn $movie_data->{movies}->[$i]->{title} ;
	    #warn Dumper($movie_data->{movies}->[$i]) ;


	    if ( (defined  $movie_data->{movies}->[$i]->{title}) and
		 # ( $m->title eq $movie_data->{movies}->[$i]->{title}) and
		 (defined $rt_id)) {
		my $movie_detail =  $BASE . "movies/" . $rt_id. ".json?apikey=$API_KEY" ;
		#warn $movie_detail;

		eval {
		    my $movie_detail_data = $self->{json}->decode(cache_get($movie_detail)) ;
		    my $movie_genre_rs = $self->{database}->{schema}->resultset('MovieGenre')->search
			({
			    movie_id => $movie_id,
			 },{}) ;
		    $movie_genre_rs->delete;

		    foreach my $genre ( @{ $movie_detail_data->{genres} } ) {
			$movie_genre_rs->create
			    (
		 {
		  movie_id => $movie_id,
		  genre  => {
			     title => $genre,
			    }
		 }
		);
	    }

	    my $movie_actor_rs = $self->{database}->{schema}->resultset('MovieActor')->search
	      ({
		movie_id => $movie_id,
	       },{}) ;
	    $movie_actor_rs->delete;
	    foreach my $actor ( @{ $movie_detail_data->{'abridged_cast'} } ) {
	      $movie_actor_rs->create
		(
		 {
		  movie_id => $movie_id,
		  actor  => {
			     title => $actor->{name},
			    }
		 }
		);
	    }



    my $m = $self->{database}->{schema}->resultset('Movie')->search
	({id => $movie_id },
       {}
      )->first ;


	    $m->rt_id($rt_id) ;
	    $m->rt_imdb($movie_detail_data->{alternate_ids}->{imdb}) ;

	    #warn $movie_detail_data->{posters}->{detailed};

	    $m->rt_img_det ($movie_detail_data->{posters}->{detailed}) ;
	    $m->rt_img_thu ($movie_detail_data->{posters}->{thumbnail}) ;
	    $m->rt_critic  ($movie_detail_data->{'ratings'}->{'critics_score'}) ;
	    $m->rt_synopsis($movie_detail_data->{synopsis} || $movie_detail_data->{'critics_consensus'}) ;
	    $m->update ;
	  } ;
	  if ($@) {
	    warn $@;
	  }
	}
	}
      }
      }
	
      $pm->finish; 
      #sleep 1 ;
  }





}



use Time::HiRes qw/ usleep /  ;
use Cache::File ;
sub cache_get {
    my ($uri) = @_ ;

    my $cache;
    eval { $cache = Cache::File->new( cache_root => '/tmp/mv-cacheroot2' ) };
    if ($@) {
      warn "$@" ;
    }

    my $res ;
    for (1.5) {
    $res = $cache ? $cache->get( $uri ) : undef;
    #warn "hit!" if defined $res;
    return $res if defined $res ;
    eval {
      # set the timeout 
      local $SIG{ALRM} = sub { die "Timeout: $uri\n" }; # NB: \n required
      alarm 60;
      $res = get($uri) ;
      $cache->set($uri, $res, '48 hours') if $cache;
      alarm 0 ;
    } ;
    if ($@) {
        warn "$@" ;
	#$res = $@;
    }
    #usleep (400000) ;
  }
    return $res;
}





1 ;
