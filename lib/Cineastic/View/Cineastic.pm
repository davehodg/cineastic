package Cineastic::View::Cineastic;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

__PACKAGE__->config
  (
   TEMPLATE_EXTENSION => '.tt',
   render_die => 1,
   WRAPPER => 'wrapper.tt',
);

=head1 NAME

Cineastic::View::Cineastic - TT View for Cineastic

=head1 DESCRIPTION

TT View for Cineastic.

=head1 SEE ALSO

L<Cineastic>

=head1 AUTHOR

David Hodgkinson

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
