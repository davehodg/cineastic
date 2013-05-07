use utf8;
package Schema::Movies::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Review

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 rating

  data_type: 'smallint'
  is_nullable: 1

=head2 wanttosee

  data_type: 'smallint'
  is_nullable: 1

=head2 review

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 updated

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "rating",
  { data_type => "smallint", is_nullable => 1 },
  "wanttosee",
  { data_type => "smallint", is_nullable => 1 },
  "review",
  { data_type => "varchar", is_nullable => 1, size => 255 },
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

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<movie_user>

=over 4

=item * L</movie_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("movie_user", ["movie_id", "user_id"]);

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
    on_update     => "RESTRICT",
  },
);

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2012-10-17 14:22:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:BIAHeR80sEo9ejDiSt0a3Q
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Review

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 rating

  data_type: 'smallint'
  is_nullable: 1

=head2 review

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "rating",
  { data_type => "smallint", is_nullable => 1 },
  "review",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<movie_user>

=over 4

=item * L</movie_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("movie_user", ["movie_id", "user_id"]);

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

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3YjNUcakeSExlaLTy0ZcxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Review

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 rating

  data_type: 'smallint'
  is_nullable: 1

=head2 review

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "rating",
  { data_type => "smallint", is_nullable => 1 },
  "review",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<movie_user>

=over 4

=item * L</movie_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("movie_user", ["movie_id", "user_id"]);

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

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3YjNUcakeSExlaLTy0ZcxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Review

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 rating

  data_type: 'smallint'
  is_nullable: 1

=head2 review

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "rating",
  { data_type => "smallint", is_nullable => 1 },
  "review",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<movie_user>

=over 4

=item * L</movie_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("movie_user", ["movie_id", "user_id"]);

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

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3YjNUcakeSExlaLTy0ZcxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' 
# These lines were loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' found in @INC.
# They are now part of the custom portion of this file
# for you to hand-edit.  If you do not either delete
# this section or remove that file from @INC, this section
# will be repeated redundantly when you re-create this
# file again via Loader!  See skip_load_external to disable
# this feature.

use utf8;
package Schema::Movies::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::Review

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<review>

=cut

__PACKAGE__->table("review");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 movie_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 user_id

  data_type: 'integer'
  is_foreign_key: 1
  is_nullable: 1

=head2 rating

  data_type: 'smallint'
  is_nullable: 1

=head2 review

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "movie_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "user_id",
  { data_type => "integer", is_foreign_key => 1, is_nullable => 1 },
  "rating",
  { data_type => "smallint", is_nullable => 1 },
  "review",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<movie_user>

=over 4

=item * L</movie_id>

=item * L</user_id>

=back

=cut

__PACKAGE__->add_unique_constraint("movie_user", ["movie_id", "user_id"]);

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

=head2 user

Type: belongs_to

Related object: L<Schema::Movies::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Schema::Movies::Result::User",
  { user_id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "CASCADE",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07025 @ 2012-08-31 12:02:15
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:3YjNUcakeSExlaLTy0ZcxA


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
# End of lines loaded from '/usr/local/share/perl/5.14.2/Schema/Movies/Result/Review.pm' 


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
