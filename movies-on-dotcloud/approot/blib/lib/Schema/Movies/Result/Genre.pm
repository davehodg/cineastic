use utf8;
package Schema::Movies::Result::Genre;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Genre

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

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

Related object: L<Schema::Movies::Result::MovieGenre>

=cut

__PACKAGE__->has_many(
  "movie_genres",
  "Schema::Movies::Result::MovieGenre",
  { "foreign.genre_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07028 @ 2012-09-10 16:29:50
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:o54IYLgdUhN4mG91jAqh+A


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
