package Input::TheHut ;



use strict ;
use warnings ;

use Data::Dumper ;
use Carp ;

use URI::Escape;

use Encode ;
use Text::Unidecode;
use Parallel::ForkManager ;
use XML::Simple ;
use LWP::Simple;

sub new {
    my ($class) = @_ ;
    my $obj = bless {}, $class ;

    $obj->{sites} =
      {
       "The Hut" => "http://www.thehut.com/elysium.search?xml&searchResultsPerPage=1&searchField=barcode&searchQuery=",
       "Zavvi" => "http://www.zavvi.com/elysium.search?xml&searchResultsPerPage=1&searchField=barcode&searchQuery=",
     #  "Argos"=> "http://www.argosentertainment.co.uk/elysium.search?xml&searchResultsPerPage=1&searchField=barcode&searchQuery=",
       #"Woolworths"=> "http://woolworthsentertainment.co.uk/elysium.search?xml&searchResultsPerPage=1&searchField=barcode&searchQuery=",
      } ;

    $obj->{database} = Output::Database->new;

    return $obj ;
}



sub read_input {
  my $self = shift ;
  my @output_data ;
   my $pm = new Parallel::ForkManager(10);

  foreach my $site (keys %{ $self->{sites} } ) {
    my $pid = $pm->start and next;
    warn "Live supplier: $site: $$";
    push @output_data, $self->input_archive($site) ;
    return  \@output_data ;
    $pm->finish ;
  }
  $pm->wait_all_children;
}

sub input_archive {
  my ($self,$site) = @_ ;
  my $xs = XML::Simple->new(ForceArray => 0) ;

  my @output_data ;

  my $supplier_id =  $self->{database}->{schema}->resultset('Supplier')->search({title => $site})->first->id ;

  my $p_rs = $self->{database}->{schema}->resultset('Product')->search
    ({
	#'me.title' => 'Men In Black 3',
     },
     {
      #rows => 10,
      distinct => 1,
      columns => [ 'me.movie_id', 'me.ean', 'me.title' ],
     }
    ) ;

  my $pm = new Parallel::ForkManager(1);
  $pm -> run_on_finish
    (     # called BEFORE the first call to start()
     sub {
       my ($pid, $exit_code, $ident, $exit_signal, $core_dump, $item) = @_;

       # retrieve data structure from child
       if (defined($item)) { # children are not forced to send anything
	 push @output_data, ${$item} ;
	 #warn Dumper($item) ;
       } else { # problems occuring during storage or retrieval will throw a warning
	 #print qq|No message received from child process $pid!\n|;
       }
     }
    );

  my $i ;
  while ( my $p = $p_rs->next) {
      #warn Dumper($p->get_columns);
    #last if $i++ == 200 ;
    my $pid = $pm->start and next;

    my $url = $self->{sites}{$site} . $p->ean ;
    #warn $p->ean;
    #warn $url;
    my $item;

    #warn $url ;
    my $res = $self->cache_get($url) ;
    if (defined($res) and ($res !~ /Product Doesn/)) {
      $res =~ s/\r\n//mg ;
      $res =~ s/&/&amp;/mg;

      my $data ;
      eval {
	$data = $xs->XMLin($res) ;
      } ;

      #$pm->finish if $p->title !~ /Men In Black/ ;

      #and (defined $data->{url}) 
      if ( (!$@) and ($data->{'total-results'} > 0) ) {
	warn $p->title, " : ", $p->ean ;
	#warn Dumper($data) ;
	$data = $data->{'product-list'}->{'product'} ;
	#warn Dumper($data) ;
	#warn "$site : " .$p->title;
	$item = {
		 name  => $data->{'product-title'} . " (" . 
		 $data->{ 'product-type'}->{'product-type-name'} .")",
		 title  => $data->{'product-title'},
		 supplier_id => $supplier_id,
		 price    => $data->{'product-price'}->{'price'}->[0]->{value},
		 url      => $data->{'product-url'} || undef,
		 image_url => $data->{'product-image-url'} || undef,
		 ean      => $p->ean,
		 movie_id => $p->movie_id,
		 release_date => $data->{'release-date'},
		};
	#warn Dumper($item) ;
      }
    }

    defined $item ? $pm->finish(0,\$item) : $pm->finish ;
  }

  #warn Dumper(\@output_data) ;
  return @output_data ;
}




use Time::HiRes qw/ usleep /  ;
use Cache::File ;
sub cache_get {
  my ($self,$uri) = @_ ;

  my $cache;
  eval { $cache = Cache::File->new( cache_root => '/tmp/mv-cacheroot2' ) };
  if ($@) {
    warn "$@" ;
  }

  my $res ;
  for (1.1) {
    $res = $cache ? decode_utf8($cache->get( $uri )) : undef;
    #warn "hit!" if defined $res;
    return $res if defined $res ;
    eval {
      # set the timeout 
      local $SIG{ALRM} = sub { die "Timeout: $uri\n" }; # NB: \n required
      alarm 10;
      $res = decode_utf8(get($uri)) ;
      $cache->set($uri, encode_utf8($res), '48 hours') if $cache;
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
