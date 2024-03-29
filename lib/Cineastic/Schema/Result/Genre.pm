use utf8;
package Cineastic::Schema::Result::Genre;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::Genre

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

=head1 TABLE: C<genre>

=cut

__PACKAGE__->table("genre");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 0
  size: 32

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 0, size => 32 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 movie_genres

Type: has_many

Related object: L<Cineastic::Schema::Result::MovieGenre>

=cut

__PACKAGE__->has_many(
  "movie_genres",
  "Cineastic::Schema::Result::MovieGenre",
  { "foreign.genre_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-10-23 16:50:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:AJiy+lIenQLlBXFjbP+TuA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
