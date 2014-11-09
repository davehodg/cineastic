use utf8;
package Cineastic::Schema::Result::Movie;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Cineastic::Schema::Result::Movie

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

=head1 TABLE: C<movie>

=cut

__PACKAGE__->table("movie");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_auto_increment: 1
  is_nullable: 0

=head2 title

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 year

  data_type: 'char'
  is_nullable: 1
  size: 10

=head2 rating

  data_type: 'char'
  is_nullable: 1
  size: 4

=head2 rt_id

  data_type: 'integer'
  is_nullable: 1

=head2 rt_imdb

  data_type: 'char'
  is_nullable: 1
  size: 8

=head2 rt_img_det

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 rt_img_thu

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=head2 rt_critic

  data_type: 'smallint'
  is_nullable: 1

=head2 rt_synopsis

  data_type: 'text'
  is_nullable: 1

=head2 updated

  data_type: 'timestamp'
  datetime_undef_if_invalid: 1
  default_value: current_timestamp
  is_nullable: 0

=head2 trailer

  data_type: 'varchar'
  is_nullable: 1
  size: 255

=cut

__PACKAGE__->add_columns(
  "id",
  { data_type => "integer", is_auto_increment => 1, is_nullable => 0 },
  "title",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "year",
  { data_type => "char", is_nullable => 1, size => 10 },
  "rating",
  { data_type => "char", is_nullable => 1, size => 4 },
  "rt_id",
  { data_type => "integer", is_nullable => 1 },
  "rt_imdb",
  { data_type => "char", is_nullable => 1, size => 8 },
  "rt_img_det",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "rt_img_thu",
  { data_type => "varchar", is_nullable => 1, size => 255 },
  "rt_critic",
  { data_type => "smallint", is_nullable => 1 },
  "rt_synopsis",
  { data_type => "text", is_nullable => 1 },
  "updated",
  {
    data_type => "timestamp",
    datetime_undef_if_invalid => 1,
    default_value => \"current_timestamp",
    is_nullable => 0,
  },
  "trailer",
  { data_type => "varchar", is_nullable => 1, size => 255 },
);

=head1 PRIMARY KEY

=over 4

=item * L</id>

=back

=cut

__PACKAGE__->set_primary_key("id");

=head1 UNIQUE CONSTRAINTS

=head2 C<title_2>

=over 4

=item * L</title>

=item * L</year>

=back

=cut

__PACKAGE__->add_unique_constraint("title_2", ["title", "year"]);

=head1 RELATIONS

=head2 movie_actors

Type: has_many

Related object: L<Cineastic::Schema::Result::MovieActor>

=cut

__PACKAGE__->has_many(
  "movie_actors",
  "Cineastic::Schema::Result::MovieActor",
  { "foreign.movie_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 movie_genres

Type: has_many

Related object: L<Cineastic::Schema::Result::MovieGenre>

=cut

__PACKAGE__->has_many(
  "movie_genres",
  "Cineastic::Schema::Result::MovieGenre",
  { "foreign.movie_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 products

Type: has_many

Related object: L<Cineastic::Schema::Result::Product>

=cut

__PACKAGE__->has_many(
  "products",
  "Cineastic::Schema::Result::Product",
  { "foreign.movie_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);

=head2 reviews

Type: has_many

Related object: L<Cineastic::Schema::Result::Review>

=cut

__PACKAGE__->has_many(
  "reviews",
  "Cineastic::Schema::Result::Review",
  { "foreign.movie_id" => "self.id" },
  { cascade_copy => 0, cascade_delete => 0 },
);


# Created by DBIx::Class::Schema::Loader v0.07040 @ 2014-11-09 18:25:10
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:PX2f4a2gBwDPUHs68KyaNQ


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
