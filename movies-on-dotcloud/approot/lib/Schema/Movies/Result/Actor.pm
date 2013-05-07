use utf8;
package Schema::Movies::Result::Actor;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Actor

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<actor>

=cut

__PACKAGE__->table("actor");

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

=head2 movie_actors

Type: has_many

Related object: L<Schema::Movies::Result::MovieActor>

=cut

__PACKAGE__->has_many(
  "movie_actors",
  "Schema::Movies::Result::MovieActor",
  { "foreign.actor_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07028 @ 2012-09-12 23:09:12
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:fJ37qn2ve9LW3rFP3Q3mxg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
