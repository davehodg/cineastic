package Cineastic::Controller::Root;
use Moose;
use namespace::autoclean;

BEGIN { extends 'Catalyst::Controller' }

use Encode;
use POSIX;
use Data::Dumper;

#
# Sets the actions in this controller to be registered with no prefix
# so they function identically to actions created in MyApp.pm
#
__PACKAGE__->config(namespace => '');

=encoding utf-8

=head1 NAME

Cineastic::Controller::Root - Root Controller for Cineastic

=head1 DESCRIPTION

[enter your description here]

=head1 METHODS

=head2 index

The root page (/)

=cut

sub collateral : Path('') {
  my ( $self, $c ) = @_;
  $self->_suggest($c);
  $self->_all_genres($c);
  $c->stash(title => "Cineastic") ;
  $c->stash(star  => encode_utf8("\x{2605}")) ;
  push( @{ $c->view('Cineastic')->include_path }, qw/root/ );

}


sub _suggest {
  my ( $self, $c ) = @_;


  my $r = 1-rand ;
  my $rand = floor(2*sqrt(sqrt($r))) ;
  my $suggestions =  $c->model('Cineastic')->schema->resultset('Movie')->search
    (
     {
      rating => { '>=', 8  },
      year   => { '>=', 2010},
      rt_critic => { '>', 0},
     },
     {
      result_class => 'DBIx::Class::ResultClass::HashRefInflator',
      order_by     => { -desc => 'rating' },
      page         => $rand,
      rows         => 10,
     }
    );
  $c->stash(suggest => [ $suggestions->all ]) ;
}

sub _all_genres {
  my ( $self, $c ) = @_;

  my $genres = $c->model('Cineastic')->schema->resultset('Genre')->search;
  $c->stash(genres =>  [ $genres->all ]) ;
}


sub index  :Path :Args(0) {
  my ( $self, $c ) = @_;
  $self->collateral($c);

  my $reviews = $c->model('Cineastic')->schema->resultset('Review')->search
    ({},
     {
      prefetch     => 'movie',
      order_by     => [ { -desc => 'me.updated' } ],
      rows         => $self->{params}->{number} || 10,
      #      offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
     }
    );
  $c->stash(reviews =>  [ $reviews->all ]) ;

  my $movies = $c->model('Cineastic')->schema->resultset('Movie')->search
    (
     {
      'products.release_date'  => { '<=', \ 'NOW()' },
      'me.year'       => { '>=', 2013, },
      'me.rt_img_det' => { '!=', undef },
      #'movie.rt_critic' => { '!=', undef },
     },
     {
      distinct  => 1,
      join      => 'products',
      order_by  => [  { -desc => 'products.release_date' }, { -desc => 'me.year' },  { -desc => 'me.rt_critic' },],
      rows      => $self->{params}->{number} || 10,
     }
    );
  $c->stash(movies => [ $movies->all ]) ;
}


sub about :Path('about') :Args(0) {
}



sub movie :Path('movie') :Args(1)   {
    my ( $self, $c, $movie_id ) = @_;
    $self->collateral($c);
    $c->log->debug("*** movie $movie_id ");

    $c->stash(movie =>
              [
               $c->model('Cineastic')->schema->resultset('Movie')->search
               (
                {
                 'me.id' =>  $movie_id
                },
                {
                 #result_class => 'DBIx::Class::ResultClass::HashRefInflator',
                 #rows         => $self->{params}->{number} || 1,
                 prefetch => 
                 [
                  { 'products'     => 'supplier' },
                  #{ 'movie_genres' => 'genre' },
                  #{ 'movie_actors' => 'actor' },
                 ],
                 order_by     => { -asc => 'products.price' },
                 distinct     => 1,
                }
               )->all ]->[0]
             );

    $c->stash(movie_genre =>
              [
               $c->model('Cineastic')->schema->resultset('MovieGenre')->search
               ({'me.movie_id' => $movie_id},
               { prefetch => 'genre' })->all
               ]
              );
    $c->stash(movie_actor =>
              [
               $c->model('Cineastic')->schema->resultset('MovieActor')->search
               ({'me.movie_id' => $movie_id},
               {prefetch => 'actor'})->all
               ]
              );
}


sub actors :Path('actors') :Args(1)   {
    my ( $self, $c, $actor_id ) = @_;
    $self->collateral($c);


    my $movies = [  $c->model('Cineastic')->schema->resultset('Movie')->search
    (
     {
	 'movie_actors.actor_id' =>  $actor_id
     },
     {
      prefetch     => { 'movie_actors' => 'actor'},
      order_by     => { -desc => 'me.year' },
      rows         => $self->{params}->{number} || 100,
      #offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
     }
    )->all ];

$c->stash(movies => $movies);

}


sub genres :Path('genres') :Args(1)   {
  my ( $self, $c, $genre_id ) = @_;
  $self->collateral($c);

  my $from = $self->{params}->{decade} || 2010 ;
  my $to = ($from == 1900 ? 2020 : $from + 9) ;

  $c->log->debug($from);
  $c->log->debug($to);

  my $movies = [ $c->model('Cineastic')->schema->resultset('Movie')->search
                 (
                  {
                   'movie_genres.genre_id' =>  $genre_id,
                   -and => [
                            year => { '>=' , $from },
                            year => { '<=' , $to },
                           ],
                  },
                  {
                   #result_class => 'DBIx::Class::ResultClass::HashRefInflator',
                   prefetch => { 'movie_genres' => 'genre'},
                   order_by     => { -desc => 'me.rt_critic' },
                   rows         => $self->{params}->{number} || 20,
                   offset       => ($self->{params}->{page} || 0) * ($self->{params}->{number} || 20),
                  }
                 )->all ];


  $c->stash(movies => $movies) ;
}




sub fbauth :Local  :PathPart('fbauth') {
  my ($self, $c) = @_;

  # do the FB auth here
  my $user = $c->authenticate({
      scope => ['email', 'offline_access', 'publish_stream'],
			      },);
  warn "Facebook auth" . Dumper($user) ;
  $c->detach unless $user;
  
  # this is on the callback, we got a $user
  my $fb = Facebook::Graph->new
      (
       app_id          => '488847887809771',
       secret          => 'e9b90d72b082809dfaa62b4ce81b21cc',
       postback        => 'http://home.hodgkinson.org:5000/fbauth',
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


  
  $c->log->debug("facebook authenticated") ;
  $c->log->debug($userinf->{email});
  $c->log->debug($userinf->{first_name});
  $c->log->debug($userinf->{last_name});
  $c->log->debug($me->{picture}->{data}->{url});
  $c->log->debug($c->user->{token});


  
  $c->log->debug("authenticated") ;
  $c->response->redirect($c->uri_for('/profile/'. $c->user->{user_id}));
}


sub profile  :PathPart('profile')    {
    my ( $self, $c, $user_id ) = @_;
    $self->collateral($c);
    $c->log->debug("*** profile " . $user_id) ;

    my $reviews = [ 
	$c->model('Cineastic')->schema->resultset('Review')->search
	(
	 {
	     user_id => $user_id
	 },
	 {
	     order_by     => { -desc => 'me.updated' },
	     prefetch     => 'movie',
	 }
	)->all ];
    
    $c->stash(reviews => $rest->user_reviews($c, $user_id, 999)) ;
}


sub logout : Local {
    my ( $self, $c ) = @_;
    $c->logout;
    $c->response->redirect($c->uri_for('/'));
}




=head2 default

Standard 404 error page

=cut

sub default :Path {
  my ( $self, $c ) = @_;
  $c->response->body( 'Page not found' );
  $c->response->status(404);
}

=head2 end

Attempt to render a view, if needed.

=cut

sub end : ActionClass('RenderView') {}

=head1 AUTHOR

David Hodgkinson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

__PACKAGE__->meta->make_immutable;

1;
