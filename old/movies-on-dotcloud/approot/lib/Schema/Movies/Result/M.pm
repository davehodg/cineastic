use utf8;
package Schema::Movies::Result::M;

# Created by DBIx::Class::Schema::Loader
# DO NOT MODIFY THE FIRST PART OF THIS FILE

=head1 NAME

Schema::Movies::Result::M

=cut

use strict;
use warnings;

use base 'DBIx::Class::Core';

=head1 TABLE: C<m>

=cut

__PACKAGE__->table("m");

=head1 ACCESSORS

=head2 id

  data_type: 'integer'
  is_nullable: 0

=cut

__PACKAGE__->add_columns("id", { data_type => "integer", is_nullable => 0 });


# Created by DBIx::Class::Schema::Loader v0.07033 @ 2013-04-04 23:04:35
# DO NOT MODIFY THIS OR ANYTHING ABOVE! md5sum:4NNo6jhyIeXzY+ddCmKg2Q


# You can replace this text with custom code or comments, and it will be preserved on regeneration
1;
