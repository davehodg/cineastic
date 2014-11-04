use utf8;
package Cineastic::Schema::Result::Review;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::Review

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

Related object: L<Cineastic::Schema::Result::Movie>

=cut

__PACKAGE__->belongs_to(
  "movie",
  "Cineastic::Schema::Result::Movie",
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

Related object: L<Cineastic::Schema::Result::User>

=cut

__PACKAGE__->belongs_to(
  "user",
  "Cineastic::Schema::Result::User",
  { user_id => "user_id" },
  {
    is_deferrable => 1,
    join_type     => "LEFT",
    on_delete     => "CASCADE",
    on_update     => "RESTRICT",
  },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-11-04 15:33:47
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:0b6n9icGYhzG7peA1eyaBw


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
