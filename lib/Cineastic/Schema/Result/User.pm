use utf8;
package Cineastic::Schema::Result::User;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::User

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
  size: 255

=head2 firstname

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 lastname

  data_type: 'char'
  is_nullable: 1
  size: 16

=head2 picture

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
  "user_id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "email",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "password",
  { data_type => "char", is_nullable => 1, size => 40 },
  "token",
  { data_type => "char", is_nullable => 1, size => 255 },
  "firstname",
  { data_type => "char", is_nullable => 1, size => 16 },
  "lastname",
  { data_type => "char", is_nullable => 1, size => 16 },
  "picture",
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

Related object: L<Cineastic::Schema::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_friends",
  "Cineastic::Schema::Result::Friend",
  { "foreign.friend_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 friend_users

Type: has_many

Related object: L<Cineastic::Schema::Result::Friend>

=cut

__PACKAGE__->has_many(
  "friend_users",
  "Cineastic::Schema::Result::Friend",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<Cineastic::Schema::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "Cineastic::Schema::Result::Review",
  { "foreign.user_id" => "self.user_id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-11-04 15:33:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:vJRXZVv/nh+RpdhQ8+AD0Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
