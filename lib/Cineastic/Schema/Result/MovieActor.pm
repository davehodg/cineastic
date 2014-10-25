use utf8;
package Cineastic::Schema::Result::MovieActor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::MovieActor

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 COMPONENTS LOADED

=over 4

=item * L<DBIx::Class::InflateColumn::DateTime>

=back

=cut

__PACKAGE__->load_components("InflateColumn::DateTime");

=head1 TABLE: C<movie_actor>

=cut

__PACKAGE__->table("movie_actor");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 actor_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "actor_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 actor

Type: belongs_to

Related object: L<Cineastic::Schema::Result::Actor>

=cut

__PACKAGE__->belongs_to(
  "actor",
  "Cineastic::Schema::Result::Actor",
  { id => "actor_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 movie

Type: belongs_to

Related object: L<Cineastic::Schema::Result::Movie>

=cut

__PACKAGE__->belongs_to(
  "movie",
  "Cineastic::Schema::Result::Movie",
  { id => "movie_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-10-23 16:50:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:e51Df+NWluaGay5+KN0AFw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
