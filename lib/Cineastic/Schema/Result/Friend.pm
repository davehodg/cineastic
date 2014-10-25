use utf8;
package Cineastic::Schema::Result::Friend;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::Friend

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

Related object: L<Cineastic::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "friend",
  "Cineastic::Schema::Result::User",
  { user_id => "friend_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);

=head2 user

Type: belongs_to

Related object: L<Cineastic::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Cineastic::Schema::Result::User",
  { user_id => "user_id" },
  { is_deferrable => 1, on_delete => "CASCADE", on_update => "RESTRICT" },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-10-23 16:50:55
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:kLJVamId/pRLE2Pyi+NJqQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
