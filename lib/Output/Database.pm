package Output::Database;

use strict;
use warnings;

use Cineastic::Schema;
use DBIx::Class;
use Config::Any;

use Data::Dumper;

sub new {
    my  $class  = shift;
    my $obj = bless {}, $class;


    my $cfg = Config::Any->load_files({files => ['config.yml'], use_ext=>1 });

    $obj->{cfg} = $cfg->[0]{'config.yml'}; 
    #warn "ook!" . Dumper( $obj->{cfg} ) ;

    # seed the DB parameters
    $obj->credentials;
    $obj->connect_schema ;
    $obj->connect_dbh ;
    return $obj;
}

sub credentials {
    my $self = shift;
    my $env = $ENV{SERVER_ENV} || 'sandbox';

    $self->{database} = $self->{cfg}->{database} ;
    $self->{host}     = $self->{cfg}->{host} ;
    $self->{port}     = $self->{cfg}->{port} ;
    $self->{user}     = $self->{cfg}->{username} ;
    $self->{password} = $self->{cfg}->{password} ;

    $self->{dsn} = "dbi:mysql:$self->{database}:$self->{host}:$self->{port}";
    return $self->{dsn} ; 
}


sub connect_dbh {
    my $self = shift;
    $self->{dbh} = $self->{schema}->storage->dbh ;
    $self->{dbh}->{mysql_auto_reconnect} = 1;
    $self->{dbh}->do("SET NAMES utf8") ;
    return $self->{dbh};
}

sub connect_schema {
    my $self = shift;
    $self->{schema} =
      Cineastic::Schema->connect( $self->{dsn}, $self->{user}, $self->{password}, { mysql_enable_utf8 => 1 } );

    my $dbh = $self->{schema}->storage->dbh ;
    $dbh->do("SET NAMES utf8") ;
    return $self->{schema};
}


# dump the stats
sub DESTROY {
    my $self = shift;
}

sub data_save {
    my ( $self, $data ) = @_;
    my $schema  = $self->connect_schema;

    my $movie_rs = $self->{schema}->resultset('Movie') ;

    

    foreach my $d ( @{ $data } ) {
	eval {
	    $movie_rs->update_or_create($d) ;
	} ;
	if ($@) {
	    warn $@ ;
	    warn Dumper($d);
	}
    }
    return;
}



sub product_save {
    my ( $self, $data ) = @_;
    my $schema  = $self->connect_schema;

#    $self->{schema}->txn_begin ;
    my $products = $self->{schema}->resultset('Product')->search
	({ supplier_id => $data->[0]->{supplier_id}})->delete ;

    foreach my $d ( @{ $data } ) {
	my $movie = $self->{schema}->resultset('Movie')->search(
	     { title => {like => $d->{title} } } )->first;

	next if !defined $movie ;
	$d->{movie_id} =  $movie->id ;
	eval {
	    $self->{schema}->resultset('Product')->update_or_create($d) ;
	} ;
	if ($@) {
	    warn $@ ;
	    warn Dumper($d);
	}
    }
#    $self->{schema}->txn_commit ;
    return;
}

sub product_save_ean {
    my ( $self, $data ) = @_;
    my $schema  = $self->connect_schema;

    warn "ook!" ;
    #warn Dumper($data) ;
    return if $data eq "0" ;

    foreach my $d ( @{ $data } ) {
	warn $d->{name};
	eval {
	    $self->{schema}->resultset('Product')->update_or_create($d, {key => 'ean'}) ;
	} ;
	if ($@) {
	    warn $@ ;
	    warn Dumper($d);
	}
    }
    return;
}

sub ratings_save {
    my ( $self, $data ) = @_;
    my $schema  = $self->connect_schema;

    foreach my $d ( @{ $data } ) {
	eval {
	    $self->{schema}->resultset('Movie')->update_or_create($d, 'title_2') ;
	} ;
	if ($@) {
	    warn $@ ;
	    warn Dumper($d);
	}
    }
    return;

}

1;
