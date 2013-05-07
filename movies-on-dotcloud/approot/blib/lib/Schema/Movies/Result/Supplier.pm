use utf8;
package Schema::Movies::Result::Supplier;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Supplier

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

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

Related object: L<Schema::Movies::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "Schema::Movies::Result::Product",
  { "foreign.supplier_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-10-17 12:58:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8ZYwBMLRfeM87fegUmVGmg


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
