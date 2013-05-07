use utf8;
package Schema::Movies::Result::Friend;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Friend

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<friend>

=cut

__PACKAGE__->table("friend");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 friend_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pending

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "friend_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pending",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_id>

=over 4

=item * L</user_id>

=item * L</friend_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_id", ["user_id", "friend_id"]);

=head1 RELATIONS

=head2 friend

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "friend",
  "Schema::Movies::Result::User",
  { user_id => "friend_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07028 @ 2012-09-04 14:03:18
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:8fTW70wKqCWmIZCIhRNHmQ
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Friend.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Friend;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Friend

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<friend>

=cut

__PACKAGE__->table("friend");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 friend_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 0

=head2 pending

  data_type: 'smallint'
  is_nullable: 1

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "friend_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 0 },
  "pending",
  { data_type => "smallint", is_nullable => 1 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<user_id>

=over 4

=item * L</user_id>

=item * L</friend_id>

=back

=cut

__PACKAGE__->add_unique_constraint("user_id", ["user_id", "friend_id"]);

=head1 RELATIONS

=head2 friend

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "friend",
  "Schema::Movies::Result::User",
  { user_id => "friend_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "CASCADE" },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-16 17:44:37
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kFbBC90gssn8q9Xoxf0Zdw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Friend.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
