package Catalyst::Authentication::Credential::MovieAPI;

use strict;
use warnings;

use Data::Dumper;
use Test::More;
use LWP::Simple;
use URI::Escape;
use URI;
use JSON;

our $VERSION = "0.01";

use Catalyst::Exception ();


sub new {
    my ($class, $config, $c, $realm) = @_;
    my $self = {};
    bless $self, $class;

    # Hack to make lookup of the configuration parameters less painful
    #my $params = { %{ $config }, %{ $realm->{config} } };

    # Check for required params (yes, nasty)
    #for my $param (qw/key secret perms/) {
    #    $self->$param($params->{$param}) or
    #        Catalyst::Exception->throw("$param not defined") 
    #}


    return $self;
}


use Data::Dumper;

sub authenticate {
    my ( $self, $c, $realm, $authinfo ) = @_;

    $c->log->debug("*** authenticate");
    $c->log->debug(Dumper($authinfo)) ;
    my $user = {};

    my $uri = URI->new(  $c->config->{backend} ) ;
    $uri->query_form(
		     rm        => 'fbauth',
		     email     => $authinfo->{email},
		     password  => $authinfo->{password},
		     firstname => $authinfo->{firstname},
		     lastname  => $authinfo->{lastname},
		    ) ;

    $c->log->debug($uri->as_string) ;
    my $s = get($uri->as_string) ;
    warn $c->log->debug($s) ;


    if (!defined $s) {
	$c->log->debug("login failed") ;
	return undef ;
    }


    $user = decode_json($s) ;
    warn $c->log->debug(Dumper($user)) ;
    delete $user->{password} ;
 
    if ($user->{status} eq "unknown user") {
	$c->log->debug("unknown user") ;
	return undef ;
    }

    my $user_obj = $realm->find_user( $user, $c );
    return ref $user_obj ? $user_obj : undef;

}
     

1;
