use utf8;
package Schema::Movies::Result::Child;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Child

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<child>

=cut

__PACKAGE__->table("child");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 parent_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "parent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 RELATIONS

=head2 parent

Type: belongs_to

Related object: L<Schema::Movies::Result::Parent>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "Schema::Movies::Result::Parent",
  { id => "parent_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07028 @ 2012-09-04 14:03:17
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:6rJElIFY1VVcvCJGypX/2A
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Child.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Child;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Child

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<child>

=cut

__PACKAGE__->table("child");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 parent_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "parent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 RELATIONS

=head2 parent

Type: belongs_to

Related object: L<Schema::Movies::Result::Parent>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "Schema::Movies::Result::Parent",
  { id => "parent_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-09 22:26:03
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:68JKIf8guvRafFRFPuZJbg
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Child.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Child;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Child

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<child>

=cut

__PACKAGE__->table("child");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 parent_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "parent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 RELATIONS

=head2 parent

Type: belongs_to

Related object: L<Schema::Movies::Result::Parent>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "Schema::Movies::Result::Parent",
  { id => "parent_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-06 14:58:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xg0owKZ2c0WinDk9dpGURA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Child.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Child.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Child.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Child;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Child

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<child>

=cut

__PACKAGE__->table("child");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 1

=head2 parent_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_nullable => 1 },
  "parent_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
);

=head1 RELATIONS

=head2 parent

Type: belongs_to

Related object: L<Schema::Movies::Result::Parent>

=cut

__PACKAGE__->belongs_to(
  "parent",
  "Schema::Movies::Result::Parent",
  { id => "parent_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-06 14:58:45
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:xg0owKZ2c0WinDk9dpGURA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Child.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
