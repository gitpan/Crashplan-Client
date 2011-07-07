package Crashplan::Client::MountPoint;

use strict;
use warnings;

our $VERSION = '0.002_0';

=head1 NAME

Crashplan::Client::MountPoint - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::MountPoint objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::MountPoint

=head1 DESCRIPTION

A mount point is a location where CrashPlan PRO can store backups or other
information.
NOTE: Only administrators can access mount point information.


=head1 METHODS

=head2 new

The Crashplan::Client::MountPoint constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::MountPoint';
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

=head2 volumeLabel

Name of the mount point's directory on the file system

=cut

sub volumeLabel {
    my $self = shift;
    my $val  = shift;


    return $self->{volumeLabel};
}

=head2 percentFree

Percentage of this mount point which is still available

=cut

sub percentFree {
    my $self = shift;
    my $val  = shift;


    return $self->{percentFree};
}

=head2 status

“ENABLED” if the mount point is enabled, “DISABLED” otherwise

=cut

sub status {
    my $self = shift;
    my $val  = shift;


    return $self->{status};
}

=head2 name

Current name for this mount point

=cut

sub name {
    my $self = shift;
    my $val  = shift;


    return $self->{name};
}

=head2 bytesFree

Count of available bytes on this mount point

=cut

sub bytesFree {
    my $self = shift;
    my $val  = shift;


    return $self->{bytesFree};
}

=head2 bytesPerSecond

Write speed of this mount point. Only available if a write speedtest has been executed on this mount point.

=cut

sub bytesPerSecond {
    my $self = shift;
    my $val  = shift;


    return $self->{bytesPerSecond};
}

=head2 note

Text entered in the note field

=cut

sub note {
    my $self = shift;
    my $val  = shift;


    return $self->{note};
}

=head2 bytesUsed

Count of in-use bytes on this mount point

=cut

sub bytesUsed {
    my $self = shift;
    my $val  = shift;


    return $self->{bytesUsed};
}

=head2 bytesTotal

Total bytes available on this mount point

=cut

sub bytesTotal {
    my $self = shift;
    my $val  = shift;


    return $self->{bytesTotal};
}

=head2 type

“DIR” (except for VMWare instances)

=cut

sub type {
    my $self = shift;
    my $val  = shift;


    return $self->{type};
}

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
