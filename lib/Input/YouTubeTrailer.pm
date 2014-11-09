package Input::YouTubeTrailer ;

use strict ;
use warnings ;


use Data::Dumper ;
use Encode;
use Scalar::Util qw/looks_like_number/;
use LWP::Simple;
use JSON;

#use BGUtil ;


sub new {
    my ($class) = @_ ;
    my $obj = bless {}, $class ;
    $obj->{database} = Output::Database->new;
    $obj->{json} = JSON->new; 
    return $obj ;
}


sub read_input {
    my $self = shift ;

    warn "Read input" ;

    my $schema = $self->{database}->{schema} ;

    my $movies = $self->{database}->{schema}->resultset('Movie')->search
        ({
            rating => { '>=', 8 },
            title  => { -not_like => '"%' },
            trailer => { '=', undef },
         },
         {
             order_by =>  [ { -desc => 'year' },
                            { -desc => 'rating'}
                            ],
             rows     => 500,
         });

    my $base = "https://gdata.youtube.com/feeds/api/videos?alt=json&max-results=1&start-index=1&q=trailer+";

    while (my $m = $movies->next) {
        my $url = $base . $m->title . "+" . $m->year;

        my $res = $self->{json}->decode(get($url)) ;
        my $video = $res->{feed}->{entry}->[0]->{'media$group'}->{'media$content'}->[0]->{url};
              
        my $m1 = $self->{database}->{schema}->resultset('Movie')->search({id=>$m->id})->first;
        warn $m1->title;
        $m1->trailer($video);
        $m1->update;
    }

    warn "Finished read_input" ;
}


1 ;
