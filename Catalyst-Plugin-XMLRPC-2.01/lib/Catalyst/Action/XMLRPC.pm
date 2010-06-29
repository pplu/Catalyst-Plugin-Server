package Catalyst::Action::XMLRPC;

use strict;
use Moose;
use namespace::autoclean;

extends 'Catalyst::Action';

after execute => sub {
    my ( $self, $controller, $c ) = @_;
    $c->xmlrpc;
};

__PACKAGE__->meta->make_immutable;

=head1 NAME

Catalyst::Action::XMLRPC - XMLRPC Action Class

=head1 SYNOPSIS

See L<Catalyst::Plugin::XMLRPC>

=head1 DESCRIPTION

XMLRPC Action Class.

=head1 AUTHOR

Sebastian Riedel, C<sri@oook.de>

=head1 LICENSE

This library is free software, you can redistribute it and/or modify 
it under the same terms as Perl itself.

=cut

1;
