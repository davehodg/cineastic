package REST ;

use Data::Dumper ;
use Moose;

use Catalyst::Model::REST ;
with 'Role::REST::Client';


# if you do this, call SUPER!
#sub new {
#    my ( $class, $schema ) = @_;
#    my $obj = bless {}, $class;  
#    return $obj;
#}


sub register {  
    my ($self, $c) = @_;

    $c->log->debug(Dumper( $c->request->params )) ;
    my $res = $self->get
	('register', 
	 {
	     rm => 'register', 
	     email     => $c->request->params->{'email'},
	     password  => $c->request->params->{'password'},
	     firstname => $c->request->params->{'firstname'},
	     lastname  => $c->request->params->{'lastname'},
	 }
	);
}


sub fbauth {  
    my ($self, $c, $email, $firstname, $lastname) = @_;

    my $res = $self->get
	('fbauth', 
	 {
	     rm => 'fbauth', 
	     email     => $email,
	     password  => sha1_base64($email),
	     firstname => $firstname,
	     lastname  => $lastname,
	 }
	);
}



sub review {
    my ($self, $c) = @_;

    $c->log->debug("Review!") ;
    $c->log->debug(Dumper($c->request->params));
    my $res = $self->get('review', 
			 {
			     rm        => 'review', 
			     review    => $c->request->params->{'review'}->[0],
			     rating    => $c->request->params->{'rating'},
			     movie_id  => $c->request->params->{'movie_id'},
			     wanttosee => $c->request->params->{'wanttosee'} || 0,
			     token     => $c->user->{'token'},
			     user_id   => $c->user->{'user_id'},
			 });

    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}


sub search {
    my ($self, $c, $query) = @_;

    my $res = $self->get('search', {rm => 'search', search => $query, rows => 30});
    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}



##################################################
# from here on down cache

# CACHE
sub actors {
    my ($self, $c, $actor_id, $page) = @_;

    my $res = $self->get
	('actors', 
	 {
	  rm        => 'actors',
	  actor_id  => $actor_id,
	  rows      => 20,
	  page      => $page || 0,
	 }
	);
    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}


# CACHE
sub all_genres {
    my ($self, $c) = @_;

    my $res = $self->get
	('all_genres', 
	 {
	  rm        => 'all_genres',
	 }
	);
    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}


# CACHE
sub genres {
    my ($self, $c, $genre_id, $page, $decade) = @_;

    my $res = $self->get
	('genres', 
	 {
	  rm        => 'genres',
	  genre_id  => $genre_id,
	  rows      => 20,
	  page      => $page || 0,
	  decade    => $decade || 0,
	 }
	);
    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}


sub suggest {
    my ($self, $c) = @_;

    
    #$c->log->debug(time);
    my $res = $self->get('suggest', {rm => 'suggest', number => 5});
    #$c->log->debug(time);
    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}



sub movie {
    my ($self, $c, $movie_id) = @_;

    my $res = $self->get('movie', {rm => 'movie', id => $movie_id});
    my $code = $res->code;
    my $data = $res->data;
    #$c->log->debug(Dumper($data)) ;
    return $data if $code == 200;
}

sub reviews {
    my ($self, $c, $movie_id) = @_;

    my $res = $self->get('movie_reviews', {rm => 'movie_reviews', movie_id => $movie_id});
    my $code = $res->code;
    my $data = $res->data;
    #$c->log->debug(Dumper($data)) ;
    return $data if $code == 200;
}

sub latest_review {
    my ($self, $c, $number) = @_;

    my $res = $self->get('latest_reviews', { rm => 'latest_reviews', number => $number }) ;
    my $code = $res->code;
    my $data = $res->data;

    #$c->log->debug(Dumper($data)) ;

    return $data if $code == 200;
}

sub latest_releases {
    my ($self, $c) = @_;

    my $res = $self->get('latest_releases', { rm => 'latest_releases', number =>'15' }) ;

    #$c->log->debug(Dumper($res)) ;
    my $code = $res->code;
    my $data = $res->data;

    #$c->log->debug(Dumper($data)) ;

    return $data if $code == 200;
}
sub user_reviews {
    my ($self, $c, $user_id, $limit) = @_;

    my $res = $self->get('user_reviews', {rm => 'user_reviews',  limit => $limit || "5", user_id => $user_id},);
    my $code = $res->code;
    my $data = $res->data;
    return $data if $code == 200;
}





1;
