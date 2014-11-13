package Input::Amazon_delta ;

use strict ;
use warnings ;


use Data::Dumper ;
use XML::Twig;
use Encode;
use Scalar::Util qw/looks_like_number/;

#use BGUtil ;


sub new {
    my ($class) = @_ ;
    my $obj = bless {}, $class ;
    $obj->{database} = Output::Database->new;
    return $obj ;
}


sub read_input {
    my $self = shift ;

    warn "Read input" ;

    #my $input_filename = "curl -skL --user bbccouk-21:fjko123d --digest 'https://assoc-datafeeds-eu.amazon.com/datafeed/getFeed?filename=uk_amazon_dvd.xml.gz' | gunzip -c |" ;

    my $input_filename = "/tmp/uk_amazon_dvd.xml" ;
    #my $input_filename = "../../data/uk_amazon_dvd_short.xml" ;
    warn $input_filename ;
    
    my $t= XML::Twig->new( twig_handlers =>
			   { 'item_data/item_basic_data' => \&section, },
	);

    $t->parsefile($input_filename);
    $t->purge;
    return $self->{data} ;

    sub section { 
	my( $t, $section)= @_;      # arguments for all twig_handlers
	my %data;

	# build the struct pretty much exactly as we'll poke
	eval {
	    %data = (
		title     => encode_utf8($section->first_child('item_name')->text),
		sku       => $section->first_child('item_sku')->text,
		ean       => $section->first_child('item_ean')->text,
		image_url => $section->first_child('item_image_url')->text,
		price     => $section->first_child('item_price')->text,
		shipping  => looks_like_number($section->first_child('item_shipping_charge')->text) ?  $section->first_child('item_shipping_charge')->text : 0,

		url       => $section->first_child('item_page_url')->text,
		salesrank => $section->first_child('item_salesrank')->text || 0,

		supplier_id => 1, #{ title => "Amazon" },
		name      => $section->first_child('item_name')->text,
		description => $section->first_child('item_short_desc')->text,
		);
	    $data{url} =~ s/AssocID/davehodg-21/;
            #warn $section->first_child('item_name')->text;
            # insert the description into the movie if we need to 
	};
	if ($@) {
	    # if we miss data, forget it. it's probably 
	    # secondhand or something
	    $section->purge;
	    return ;
	}

	# now is a good place to mangle the title
        #warn $data{title};
	$data{title} =~ s/\s\[+.*// ;
        $data{title} =~ s/\.$//;
        #warn $data{title} ;
	#return if $data{title} !~ /The Shawshank/;


        my $schema = $self->{database}->{schema} ;
        my $movie = $self->{database}->{schema}->resultset('Movie')->search
          ({
            title => $data{title},
           })->first ;
       

        if (defined $movie) {
          if (($data{description} !~ /^Release Date:/) ||
              (length($data{description}) > 100) ) {
              
              $movie->rt_synopsis($data{description});
              if (defined $section->first_child('item_image_url_large')) {
		  #warn "I: " . $data{title} . " " . $section->first_child('item_image_url_large')->text;
		  $movie->rt_img_det($section->first_child('item_image_url_large')->text);

              }
              $movie->update;
          }
          #  warn Dumper($movie->get_columns($movie));
        }

	#warn Dumper(\%data);
          #exit ;

	push @{ $self->{data} }, \%data ;
	$section->purge;            # outputs the section and frees memory
	return ;
    }


    warn "Finished read_input" ;
}


1 ;
