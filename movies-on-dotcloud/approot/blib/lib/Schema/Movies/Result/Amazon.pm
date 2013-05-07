use utf8;
package Schema::Movies::Result::Amazon;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Amazon

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<amazon>

=cut

__PACKAGE__->table("amazon");

=head1 ACCESSORS

=head2 amazon_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 sku

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 image_url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 price

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 shipping

  data_type: 'char'
  is_nullable: 1
  size: 6

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "amazon_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sku",
  { data_type => "char", is_nullable => 1, size => 10 },
  "image_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "price",
  { data_type => "char", is_nullable => 1, size => 6 },
  "shipping",
  { data_type => "char", is_nullable => 1, size => 6 },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</amazon_id>

=back

=cut

__PACKAGE__->set_primary_key("amazon_id");

=head1 RELATIONS

=head2 movie

Type: belongs_to

Related object: L<Schema::Movies::Result::Movie>

=cut

__PACKAGE__->belongs_to(
  "movie",
  "Schema::Movies::Result::Movie",
  { id => "movie_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-06 15:30:49
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:hP8t6CYI15XOQIR5j8avvQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
