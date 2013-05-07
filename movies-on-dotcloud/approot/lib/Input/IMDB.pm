package Input::IMDB ;

use strict ;
use warnings ;


use Data::Dumper ;
use PerlIO::gzip;
use Encode;
#use Regexp::Debugger;

#use open ':encoding(utf8)';
use open ':encoding(iso-latin-1)';

#use BGUtil ;


sub new {
  my ($class) = @_ ;
  my $obj = bless {}, $class ;
  return $obj ;
}


sub read_input {
  my $self = shift ;
  my @output_data ;

  my $IN ;
  my $file = "/tmp/movies.list.gz";
  #my $file = "curl -s ftp://ftp.funet.fi/pub/mirrors/ftp.imdb.com/pub/movies.list.gz | gunzip -c |" ;

  open ($IN, $file) or die "Can't find file $file: $!\n";
  while (my $m = <$IN>) {
    next if $m !~ /^====/;
    last;
  }
  <$IN> ;			# skip a blank line


  # now do the data
  my $i ;
  while (my $m = <$IN>) {
    chomp $m;
    #warn $m;
    last if $m =~ /------------------------/;

   if ( ($m =~ /\(VG\)/) or ($m =~ /{/)) {
     #warn $m ;
     next ;
   }
    next if $m =~ /^\"/ ;

    my ($title, $year) = ($m =~ /^(.+)\t+(.*)$/) ;
    ($title) = ($title =~ /^(.+?)\s\(.*\).*$/) ;

    #warn $title, " : ", $year;

    # worry about these later
    if (!defined $title) {
      warn "<$m> failed to parse";
      next ;
    }
    $self->{title}->{encode_utf8($title)} = $year;
    #last if $i++ == 1000 ;
  }

  foreach my $k (keys %{   $self->{title} } ) {
    my %item = (
		title => $k,
		year  =>  $self->{title}->{$k},
	       );
    push @output_data, \%item ;
  }

  #warn Dumper(\@output_data) ;
  return \@output_data ;
}


sub read_ratings {
  my $self = shift;
  my @output_data ;
  my $IN ;
  my $file = "/tmp/ratings.list.gz";
  open ($IN, "<:gzip", $file) or die "Can't find file $file: $!\n";
  while (my $m = <$IN>) {
    next if $m !~ /^MOVIE RATINGS REPORT$/;
    last;
  }
  <$IN> ;			# skip a blank line
  <$IN> ;			# skip a blank line

  # now do the data
  my $i ;
  $self->{title} = undef;

  while (my $m = <$IN>) {
    chomp $m;
    last if $m =~ /------------------------/;

   if ( ($m =~ /\(VG\)/) or ($m =~ /{/)) {
      #warn $m ;
       next ;
    }



    my $votes  = substr $m, 17,7 ;
    my $rating = substr $m, 27, 5 ;
    my $title  = substr $m, 32 ;
    my $year;


    ($title,$year) = ($title =~ /^(.+?)     # the text
				 \s       # up to a space
				 \(      # before a paren
				 (.+?)  # capture the year
				 \)      # close paren
				 .*$      # eat the rest of the string
				/x) ;

    #$|=1;
    $rating = undef if $votes < 3000 ;
    next if !defined $rating;
#    print "$votes : $rating : $title : $year\r" ;

    # imdb vote threshold

    push @output_data, [ $title, $year, $rating ] ;
    #$self->{title}->{encode_utf8($title)}->{$year} = $rating ;
  }

  my @output_data1 ;
  foreach my $d (@output_data) {
    my %item = (
		title => encode_utf8($d->[0]),
		year  => $d->[1],
		rating => $d->[2]
	       );
    push @output_data1, \%item;
  }
  return \@output_data1 ;
}

1 ;
