package Catalyst::DotCloud::Controller::Site;
use Moose;
use namespace::autoclean;

use Data::Dumper;
#use WWW::Facebook::API;

use Facebook::Graph;
use REST ;
use Encode ;
use Digest::SHA1  qw(sha1 sha1_hex sha1_base64);

BEGIN { extends 'Catalyst::Controller'; }

=head1 NAME

Catalyst::DotCloud::Controller::Site - Catalyst Controller

=head1 DESCRIPTION

Catalyst Controller.

=head1 METHODS

=cut


=head2 index

=cut

sub base :Chained('/') :PathPart('site') :CaptureArgs(0)  {
    my ( $self, $c ) = @_;

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => {timeout => 5},
        );

    $c->stash(suggest => $rest->suggest($c)) ;
    $c->stash(all_genres => $rest->all_genres($c)) ;
    $c->stash(title => "Cineastic") ;
    $c->stash(star  => encode_utf8("\x{2605}")) ;

    # do some FB stuffs here
    if (defined $c->{user} && $c->user->{auth_realm} eq "facebook") {
      $c->log->debug("ook! facebook!") ;
      $c->log->debug($c->user->{token}) ;
     }

}

sub index :Path :Args(0) {
    my ( $self, $c ) = @_;

    $c->response->body('Matched Catalyst::DotCloud::Controller::Site in Site.');
}

# : Chained('base')
sub test :Chained('base') :PathPart('test')    {
    my ( $self, $c ) = @_;
    $c->log->debug("*** test ");
}



use Catalyst::Authentication::Credential::MovieAPI ;

sub login : Local {
  my ( $self, $c ) = @_;
  $c->log->debug("*** login template");
}

sub loginsubmit : Local {
    my ( $self, $c ) = @_;

    $c->log->debug("*** loginsubmit");
    #$c->log->debug(Dumper($c->user));

    if ($c->authenticate( {
                             email    => $c->request->params->{'email'},
                             password => $c->request->params->{'password'}
                          } )) {  
       # $c->authenticate returns a true value if authentication succeeds
       # so display the login successful page here.
	$c->log->debug("authenticated") ;
	$c->response->redirect($c->uri_for('/site/profile/'. $c->user->{user_id}));

  } else {
       # or undef is authentication failed. 
       # so display the 'try again' page here.
    $c->stash(error_msg => 'Login failed') ;
    $c->log->debug("Login failed") ;
    $c->stash(template => 'site/test.tt');
  }
}



sub logout : Local {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->response->redirect($c->uri_for('/site/home'));
}

sub register : Local {
    my ( $self, $c ) = @_;
}


sub registersubmit : Local {
    my ( $self, $c ) = @_;

    $c->log->debug("*** registersubmit");

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => 
	{
	    timeout => 5
	},
        );

    $rest->register($c);

    if ($c->authenticate( {
	email     => $c->request->params->{'email'},
	password  => $c->request->params->{'password'},
	firstname => $c->request->params->{'firstname'},
	lastname => $c->request->params->{'lastname'},
                          } )) {  
      # $c->authenticate returns a true value if authentication succeeds
      # so display the login successful page here.
      $c->response->redirect($c->uri_for('/site/home'));

    } else {
      # or undef is authentication failed. 
      # so display the 'try again' page here.
      $c->response->redirect($c->uri_for('/site/home'));
    }

    $c->response->redirect($c->uri_for('/site/home'));

}


sub movie :Chained('base') :PathPart('movie')    {
    my ( $self, $c, $movie_id ) = @_;
    $c->log->debug("*** movie $movie_id ");

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => {timeout => 5},
        );
    $c->stash(movie => $rest->movie($c, $movie_id)) ;

#    $rest = Reviews->new(
#	server =>      $c->config->{backend},
#	type   =>      'application/json',
#	clientattrs => {timeout => 5},
#       );

    $c->stash(reviews => $rest->reviews($c, $movie_id)) ;
    $c->stash(template => 'site/movie.tt');
}


sub search :Chained('base') :PathPart('search')    {
    my ( $self, $c ) = @_;
    #$c->log->debug("*** search " . Dumper($c->request->params));

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => {timeout => 5},
        );
    $c->stash(searchresults => $rest->search($c, $c->request->params->{'search'})) ;
    $c->stash(template => 'site/search.tt');
}



sub review :Chained('base') :PathPart('review')    {
    my ( $self, $c ) = @_;
    #$c->log->debug("*** review " . Dumper($c->request->params));

    # really ought to be logged in at this point
    if (!defined $c->user) {
	$c->stash(error_msg => "Must be logged in to submit a review") ;
    } else {

	my $rest = REST->new(
	    server =>      $c->config->{backend},
	    type   =>      'application/json',
	    clientattrs => {timeout => 5},
	    );
	$c->stash(review => $rest->review($c)) ;
    }
    $c->response->redirect($c->uri_for("/site/movie/" . $c->request->params->{'movie_id'} ));
}


sub profile :Chained('base') :PathPart('profile')    {
    my ( $self, $c, $user_id ) = @_;
    $c->log->debug("*** profile " . $user_id) ;

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => {timeout => 5},
        );
    $c->stash(reviews => $rest->user_reviews($c, $user_id, 999)) ;
}


sub genres :Chained('base') :PathPart('genres') {
    my ( $self, $c, $genre_id ) = @_;
    $c->log->debug("*** genres " . $genre_id);

    $c->stash(page   => $c->request->params->{'page'}   || 0 ) ;
    $c->stash(decade => $c->request->params->{'decade'} || 0 ) ;

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => {timeout => 5},
        );
    $c->stash(genres => $rest->genres($c, $genre_id, $c->stash->{page}, $c->stash->{decade})) ;

    $c->log->debug(Dumper( $#{  $c->stash->{genres} })) ;

    if ($#{ $c->stash->{genres} } == -1 ) {
      $c->response->redirect($c->uri_for('/site/genres/'. $genre_id ) . '?page=' . ($c->request->params->{'page'} -1)) ;
    }

}

sub actors :Chained('base') :PathPart('actors') {
    my ( $self, $c, $actor_id ) = @_;
    $c->log->debug("*** actors " . $actor_id);

    $c->stash(page => $c->request->params->{'page'} || 0 ) ;

    my $rest = REST->new(
	server =>      $c->config->{backend},
	type   =>      'application/json',
	clientattrs => {timeout => 5},
        );
    $c->stash(actors => $rest->actors($c, $actor_id, $c->stash->{page})) ;

    #$c->log->debug(Dumper( $#{  $c->stash->{actors} })) ;
    if ($#{ $c->stash->{actors} } == -1 ) {
      $c->response->redirect($c->uri_for('/site/actors/'. $actor_id ) . '?page=' . ($c->request->params->{'page'} -1)) ;
    }
}


=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut



sub fbauth :Local :Chained('base') :PathPart('fbauth') {
  my ($self, $c) = @_;

  # do the FB auth here
  my $user = $c->authenticate({
      scope => ['email', 'offline_access', 'publish_stream'],
			      }, 'facebook');
  warn "Facebook auth" . Dumper($user) ;
  $c->detach unless $user;

  # this is on the callback, we got a $user
  my $fb = Facebook::Graph->new
      (
       app_id          => '488847887809771',
       secret          => 'e9b90d72b082809dfaa62b4ce81b21cc',
       postback        => 'http://www.cineastic.co.uk/facebook/fbauth',
      );
  $fb->access_token($c->user->{token});
  my $userinf = $fb->fetch('me') ;
  $c->log->debug("Userinf : " . Dumper($userinf)) ;

  my $me = $fb->query
      ->find('me')
      ->select_fields(qw( id name picture email ))
      ->request
      ->as_hashref;
  $c->log->debug("me : " . Dumper($me)) ;
  my $square_picture = $me->{picture}->{data}->{url} ;

  warn $square_picture;

  my $user = $c->authenticate({
			     email    => $me->{email},
			     firstname => $userinf->{first_name},
			     lastname  => $userinf->{last_name},
			     password  =>  sha1_base64($me->{email} . 
						       $userinf->{first_name}. 
						       $userinf->{last_name}),

			     picture   =>

			     });
  warn "From b/e auth" . Dumper($user) ;

  
  $c->log->debug("facebook authenticated") ;
  $c->log->debug($user->{first_name});
  $c->log->debug($user->{last_name});
  $c->log->debug($user->{email});
  
  $c->log->debug("authenticated") ;
  $c->response->redirect($c->uri_for('/site/profile/'. $c->user->{user_id}));
}

sub about :Chained('base') :PathPart('about') {
}


sub home :Chained('base') :PathPart('home') {
  my ($self, $c) = @_;

  $c->log->debug("*** home!") ;


  my $rest = REST->new(
		       server =>      $c->config->{backend},
		       type   =>      'application/json',
		       clientattrs => {timeout => 5},
		      );

  $c->stash(reviews  => $rest->latest_review($c,15));
  $c->stash(releases => $rest->latest_releases($c));


  #$c->log->debug($c->config->{backend}) ;
  #$c->log->debug(Dumper($rest->latest_releases($c))) ;
}

1;

