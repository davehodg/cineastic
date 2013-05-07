use utf8;
package Schema::Movies::Result::Parent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Parent

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<parent>

=cut

__PACKAGE__->table("parent");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("id", { data_type => "integer", is_nullable => 0 });

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 children

Type: has_many

Related object: L<Schema::Movies::Result::Child>

=cut

__PACKAGE__->has_many(
  "children",
  "Schema::Movies::Result::Child",
  { "foreign.parent_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-09 22:26:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:OhZrurO1RGIF3C3nPu+dwA
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Parent.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Parent;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Parent

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<parent>

=cut

__PACKAGE__->table("parent");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("id", { data_type => "integer", is_nullable => 0 });

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 RELATIONS

=head2 children

Type: has_many

Related object: L<Schema::Movies::Result::Child>

=cut

__PACKAGE__->has_many(
  "children",
  "Schema::Movies::Result::Child",
  { "foreign.parent_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-06 14:58:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:Hzn+NqD0qU1KhomyaoGLbA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Parent.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
