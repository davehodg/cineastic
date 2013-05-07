use utf8;
package Schema::Movies::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Product

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

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

=cut

__PACKAGE__->add_columns(
  "product_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_nullable => 1 },
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

=head2 supplier

Type: belongs_to

Related object: L<Schema::Movies::Result::Supplier>

=cut

__PACKAGE__->belongs_to(
  "supplier",
  "Schema::Movies::Result::Supplier",
  { id => "supplier_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-10-18 11:00:21
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:oxJS8w4Hdeiwb9FWBm5rMg
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Product.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Product

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

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
);

=head1 PRIMARY KEY

=over 4

=item * L</product_id>

=back

=cut

__PACKAGE__->set_primary_key("product_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<sku>

=over 4

=item * L</sku>

=back

=cut

__PACKAGE__->add_unique_constraint("sku", ["sku"]);

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

=head2 supplier

Type: belongs_to

Related object: L<Schema::Movies::Result::Supplier>

=cut

__PACKAGE__->belongs_to(
  "supplier",
  "Schema::Movies::Result::Supplier",
  { id => "supplier_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k+kPTuY/68ucZ/i3siwqkA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Product.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Product.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Product

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

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
);

=head1 PRIMARY KEY

=over 4

=item * L</product_id>

=back

=cut

__PACKAGE__->set_primary_key("product_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<sku>

=over 4

=item * L</sku>

=back

=cut

__PACKAGE__->add_unique_constraint("sku", ["sku"]);

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

=head2 supplier

Type: belongs_to

Related object: L<Schema::Movies::Result::Supplier>

=cut

__PACKAGE__->belongs_to(
  "supplier",
  "Schema::Movies::Result::Supplier",
  { id => "supplier_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k+kPTuY/68ucZ/i3siwqkA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Product.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Product.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Product;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Product

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

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
);

=head1 PRIMARY KEY

=over 4

=item * L</product_id>

=back

=cut

__PACKAGE__->set_primary_key("product_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<sku>

=over 4

=item * L</sku>

=back

=cut

__PACKAGE__->add_unique_constraint("sku", ["sku"]);

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

=head2 supplier

Type: belongs_to

Related object: L<Schema::Movies::Result::Supplier>

=cut

__PACKAGE__->belongs_to(
  "supplier",
  "Schema::Movies::Result::Supplier",
  { id => "supplier_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:k+kPTuY/68ucZ/i3siwqkA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Product.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
