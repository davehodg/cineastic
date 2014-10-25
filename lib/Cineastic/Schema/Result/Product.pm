use utf8;
package Cineastic::Schema::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::Product

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

=head1 TABLE: C<product>

=cut

__PACKAGE__->table("product");

=head1 ACCESSORS

=head2 product_id

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

=head2 ean

  data_type: 'char'
  is_nullable: 1
  size: 13

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

=head2 salesrank

  data_type: 'integer'
  is_nullable: 1

=head2 name

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 description

  data_type: 'text'
  is_nullable: 1

=head2 url_small

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 supplier_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 url

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 release_date

  data_type: 'datetime'
  datetime_undef_if_invalid: 1
  is_nullable: 1

=head2 updated

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "product_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "sku",
  { data_type => "char", is_nullable => 1, size => 10 },
  "ean",
  { data_type => "char", is_nullable => 1, size => 13 },
  "image_url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "price",
  { data_type => "char", is_nullable => 1, size => 6 },
  "shipping",
  { data_type => "char", is_nullable => 1, size => 6 },
  "salesrank",
  { data_type => "integer", is_nullable => 1 },
  "name",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "description",
  { data_type => "text", is_nullable => 1 },
  "url_small",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "supplier_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "url",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "release_date",
  {
    data_type => "datetime",
    datetime_undef_if_invalid => 1,
    is_nullable => 1,
  },
  "updated",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
);

=head1 PRIMARY KEY

=over 4

=item * L</product_id>

=back

=cut

__PACKAGE__->set_primary_key("product_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<ean>

=over 4

=item * L</ean>

=item * L</supplier_id>

=back

=cut

__PACKAGE__->add_unique_constraint("ean", ["ean", "supplier_id"]);

=head1 RELATIONS

=head2 movie

Type: belongs_to

Related object: L<Cineastic::Schema::Result::Movie>

=cut

__PACKAGE__->belongs_to(
  "movie",
  "Cineastic::Schema::Result::Movie",
  { id => "movie_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "NO ACTION",
    on_update     => "NO ACTION",
  },
);

=head2 supplier

Type: belongs_to

Related object: L<Cineastic::Schema::Result::Supplier>

=cut

__PACKAGE__->belongs_to(
  "supplier",
  "Cineastic::Schema::Result::Supplier",
  { id => "supplier_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-10-23 16:50:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:uRO3v6Z06vrfeQCVKGYICQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
