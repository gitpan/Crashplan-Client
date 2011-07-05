package Crashplan::Client::ComputerUsage;

use strict;
use warnings;

our $VERSION = '0.001';

=head1 NAME

Crashplan::Client::ComputerUsage - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::ComputerUsage objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::ComputerUsage

=head1 DESCRIPTION

A record of computer usage provides statistics about the interaction between a
pair of computers.


=head1 METHODS

=head2 new

The Crashplan::Client::ComputerUsage constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::ComputerUsage';
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

=head2 targetId

The id of the target computer

=cut

sub targetId {
    my $self = shift;
    my $val  = shift;


    return $self->{targetId};
}

=head2 lastConnected

Timestamp indicating the last time the source connected to thetarget or null if there has been no connection

=cut

sub lastConnected {
    my $self = shift;
    my $val  = shift;


    return $self->{lastConnected};
}

=head2 selectedBytes

Byte count for all files selected for backup

=cut

sub selectedBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{selectedBytes};
}

=head2 todoFiles

Count of all files waiting to be backed up

=cut

sub todoFiles {
    my $self = shift;
    my $val  = shift;


    return $self->{todoFiles};
}

=head2 sourceGuid

The GUID of the source computer

=cut

sub sourceGuid {
    my $self = shift;
    my $val  = shift;


    return $self->{sourceGuid};
}

=head2 targetGuid

The GUID of the target computer

=cut

sub targetGuid {
    my $self = shift;
    my $val  = shift;


    return $self->{targetGuid};
}

=head2 archiveBytes

Source computer's archive size at the destination in bytes

=cut

sub archiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytes};
}

=head2 lastActivity

Timestamp indicating the last backup activity between the sourceand target or null if there has been no activity

=cut

sub lastActivity {
    my $self = shift;
    my $val  = shift;


    return $self->{lastActivity};
}

=head2 sourceId

The id of the source computer

=cut

sub sourceId {
    my $self = shift;
    my $val  = shift;


    return $self->{sourceId};
}

=head2 isUsing

If checked, Computer B is a backup destination for Computer A

=cut

sub isUsing {
    my $self = shift;
    my $val  = shift;


    return $self->{isUsing};
}

=head2 selectedFiles

Count of all files selected for backup

=cut

sub selectedFiles {
    my $self = shift;
    my $val  = shift;


    return $self->{selectedFiles};
}

=head2 todoBytes

Byte count for all files waiting to be backed up

=cut

sub todoBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{todoBytes};
}

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
