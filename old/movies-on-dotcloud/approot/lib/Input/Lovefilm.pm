package Input::Lovefilm ;

use strict ;
use warnings ;

use Data::Dumper ;
use Carp ;

use WWW::Lovefilm::API;
use Memoize;
use Config::Any;
use XML::Simple;

sub new {
    my ($class) = @_ ;


    # we memoize so we don't use up the API
    memoize('_search');

    my $obj = bless {}, $class ;
    $obj->{database} = Output::Database->new;

    my $cfg = Config::Any->load_files({files => ['config.yml'], use_ext=>1 });
    $obj->{cfg} = $cfg->[0]{'config.yml'}; 
    #warn "ook!" . Dumper( $obj->{cfg} ) ;
    #warn $obj->{cfg}->{lovefilm_consumer_key} ;

    return $obj ;
}



sub read_input {
  my $self = shift ;
  my @output_data ;


  my $supplier_id =  $self->{database}->{schema}->resultset('Supplier')->search({title => 'Lovefilm'})->first->id ;
  warn "Supplier id: ", $supplier_id;

  my $products =  $self->{database}->{schema}->resultset('Product')->search
      (
       {
	   'ean' => { '!=', undef },
	   'title' => 'Inception',
       },
       {
	   order_by => { -desc => 'salesrank' },
	   prefetch     => 'movie',
	   rows     => 10,
       }
      );

  while( my $p = $products->next ) {
      warn $p->title . " : " .  $p->movie->title . " : " . $p->ean ;
      
  }

  #$self->_search('Inception');
}

sub _search {
    my ($self,$title) = @_ ;
    warn $title;
    my $lovefilm = WWW::Lovefilm::API->new
	({
	    consumer_key    => 'fhxxge2rgys5ugfw254zwh3s',
	    consumer_secret => 'J6x59UxaCu',

	    #consumer_key    => $self->{cfg}->{'lovefilm_consumer_key'},
	    #consumer_secret => $self->{cfg}->{'lovefilm_consumer_secret'},

	    content_filter  => sub { XMLin(@_) },
	 });

    $lovefilm->REST->catalog->title;
    $lovefilm->Get(
	term           => $title,
	start_index    => 1, # Mmm, zero does not work, must be 1 based index
	items_per_page => 20,
	);
    
    my $data = $lovefilm->content;

    #printf "%d results:\n", $data->{total_results};

    while( my ($url, $row) = each %{$data->{catalog_title}} ){
	next if $title ne $row->{title}->{clean};
	printf "%s (%s)\n",
	$row->{title}->{clean},
	$row->{release_date},
	;
    }

}



1 ;
