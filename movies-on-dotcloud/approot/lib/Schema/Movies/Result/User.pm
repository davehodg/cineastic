use utf8;
package Schema::Movies::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 password

  data_type: 'char'
  is_nullable: 1
  size: 40

=head2 token

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 firstname

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 lastname

  data_type: 'char'
  is_nullable: 1
  size: 16

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "password",
  { data_type => "char", is_nullable => 1, size => 40 },
  "token",
  { data_type => "char", is_nullable => 1, size => 32 },
  "firstname",
  { data_type => "char", is_nullable => 1, size => 16 },
  "lastname",
  { data_type => "char", is_nullable => 1, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("email", ["email"]);

=head1 RELATIONS

=head2 friend_friends

Type: has_many

Related object: L<Schema::Movies::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_friends",
  "Schema::Movies::Result::Friend",
  { "foreign.friend_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 friend_users

Type: has_many

Related object: L<Schema::Movies::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_users",
  "Schema::Movies::Result::Friend",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<Schema::Movies::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "Schema::Movies::Result::Review",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-10-17 12:58:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:+SkNr66Zj9WEiXn7gQTRWg
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/User.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 password

  data_type: 'char'
  is_nullable: 1
  size: 48

=head2 token

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 firstname

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 lastname

  data_type: 'char'
  is_nullable: 1
  size: 16

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "password",
  { data_type => "char", is_nullable => 1, size => 48 },
  "token",
  { data_type => "char", is_nullable => 1, size => 32 },
  "firstname",
  { data_type => "char", is_nullable => 1, size => 16 },
  "lastname",
  { data_type => "char", is_nullable => 1, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("email", ["email"]);

=head1 RELATIONS

=head2 friend_friends

Type: has_many

Related object: L<Schema::Movies::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_friends",
  "Schema::Movies::Result::Friend",
  { "foreign.friend_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 friend_users

Type: has_many

Related object: L<Schema::Movies::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_users",
  "Schema::Movies::Result::Friend",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<Schema::Movies::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "Schema::Movies::Result::Review",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tH+79aws0n10GwQm5cvdJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/User.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/User.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::User

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<user>

=cut

__PACKAGE__->table("user");

=head1 ACCESSORS

=head2 user_id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 email

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 password

  data_type: 'char'
  is_nullable: 1
  size: 48

=head2 token

  data_type: 'char'
  is_nullable: 1
  size: 32

=head2 firstname

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 lastname

  data_type: 'char'
  is_nullable: 1
  size: 16

=cut

__PACKAGE__->add_columns(
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "password",
  { data_type => "char", is_nullable => 1, size => 48 },
  "token",
  { data_type => "char", is_nullable => 1, size => 32 },
  "firstname",
  { data_type => "char", is_nullable => 1, size => 16 },
  "lastname",
  { data_type => "char", is_nullable => 1, size => 16 },
);

=head1 PRIMARY KEY

=over 4

=item * L</user_id>

=back

=cut

__PACKAGE__->set_primary_key("user_id");

=head1 UNIQUE CONSTRAINTS

=head2 C<email>

=over 4

=item * L</email>

=back

=cut

__PACKAGE__->add_unique_constraint("email", ["email"]);

=head1 RELATIONS

=head2 friend_friends

Type: has_many

Related object: L<Schema::Movies::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_friends",
  "Schema::Movies::Result::Friend",
  { "foreign.friend_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 friend_users

Type: has_many

Related object: L<Schema::Movies::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_users",
  "Schema::Movies::Result::Friend",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<Schema::Movies::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "Schema::Movies::Result::Review",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:tH+79aws0n10GwQm5cvdJQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/User.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
