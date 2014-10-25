use utf8;
package Cineastic::Schema::Result::Supplier;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::Supplier

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

=head1 TABLE: C<supplier>

=cut

__PACKAGE__->table("supplier");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 live

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "live",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<title>

=over 4

=item * L</title>

=back

=cut

__PACKAGE__->add_unique_constraint("title", ["title"]);

=head1 RELATIONS

=head2 products

Type: has_many

Related object: L<Cineastic::Schema::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "Cineastic::Schema::Result::Product",
  { "foreign.supplier_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-10-23 16:50:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:9/Ej3kL5SKlEwhGre5m1LQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
