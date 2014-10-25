package Catalyst::DotCloud::View::HTML;
use Moose;
use namespace::autoclean;

extends 'Catalyst::View::TT';

use Catalyst::DotCloud;

__PACKAGE__->config(
    TEMPLATE_EXTENSION => '.tt',
    render_die => 1,
    TIMER              => 1,
    WRAPPER => 'wrapper.tt',

# Set the location for TT files
    INCLUDE_PATH => [    Catalyst::DotCloud->path_to( 'root' ),    ],
);



=head1 NAME

Catalyst::DotCloud::View::HTML - TT View for Catalyst::DotCloud

=head1 DESCRIPTION

TT View for Catalyst::DotCloud.

=head1 SEE ALSO

L<Catalyst::DotCloud>

=head1 AUTHOR

,,,

=head1 LICENSE

This library is free software. You can redistribute it and/or modify
it under the same terms as Perl itself.

=cut

1;
