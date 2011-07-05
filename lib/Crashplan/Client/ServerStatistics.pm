package Crashplan::Client::ServerStatistics;

use strict;
use warnings;

our $VERSION = '0.001';

=head1 NAME

Crashplan::Client::ServerStatistics - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::ServerStatistics objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::ServerStatistics

=head1 DESCRIPTION



=head1 METHODS

=head2 new

The Crashplan::Client::ServerStatistics constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::ServerStatistics';
}

=head2 id

Getter for the 'id" attribute.

=cut

sub id {
    my $self = shift;

    return $self->{id};
}

=head2 creationDate

Getter for the 'creationDate" attribute.

=cut

sub creationDate {
    my $self = shift;

    return $self->{creationDate};
}

=head2 modificationDate

Getter for the 'modificationDate" attribute.

=cut

sub modificationDate {
    my $self = shift;

    return $self->{modificationDate};
}

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
