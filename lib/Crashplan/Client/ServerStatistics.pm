package Crashplan::Client::ServerStatistics;

use strict;
use warnings;

our $VERSION = '0.002_0';

=head1 NAME

Crashplan::Client::ServerStatistics - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::ServerStatistics objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::ServerStatistics

=head1 DESCRIPTION

Real-time statistics about what is happening inside the server.
NOTE: Only administrators can access the serverStats resource


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

=head2 diskUtilization

The percentage of disk space used on the host OS bootdrive

=cut

sub diskUtilization {
    my $self = shift;
    my $val  = shift;


    return $self->{diskUtilization};
}

=head2 seatCount

The number of active (versus deactivated) computers

=cut

sub seatCount {
    my $self = shift;
    my $val  = shift;


    return $self->{seatCount};
}

=head2 uptimeMilliseconds

The milliseconds this PRO Server has been running

=cut

sub uptimeMilliseconds {
    my $self = shift;
    my $val  = shift;


    return $self->{uptimeMilliseconds};
}

=head2 hostMemoryTotal

The total amount of RAM available to the hostoperating system

=cut

sub hostMemoryTotal {
    my $self = shift;
    my $val  = shift;


    return $self->{hostMemoryTotal};
}

=head2 backupSessionCount

The number of computers currently sending backup datato this server

=cut

sub backupSessionCount {
    my $self = shift;
    my $val  = shift;


    return $self->{backupSessionCount};
}

=head2 hostPort

The port used by clients to connect to this server

=cut

sub hostPort {
    my $self = shift;
    my $val  = shift;


    return $self->{hostPort};
}

=head2 orgCount

The number of active (versus deactivated) orgs

=cut

sub orgCount {
    my $self = shift;
    my $val  = shift;


    return $self->{orgCount};
}

=head2 uptime

The human-readable amount of time this PRO Server hasbeen running

=cut

sub uptime {
    my $self = shift;
    my $val  = shift;


    return $self->{uptime};
}

=head2 load

The load average on the system in the last 1 minute,5 minutes, and 15 minutes

=cut

sub load {
    my $self = shift;
    my $val  = shift;


    return $self->{load};
}

=head2 engineMemoryFree

The unused RAM inside the Java virtual machine

=cut

sub engineMemoryFree {
    my $self = shift;
    my $val  = shift;


    return $self->{engineMemoryFree};
}

=head2 diskTotal

The amount of disk space on the host OS boot drive

=cut

sub diskTotal {
    my $self = shift;
    my $val  = shift;


    return $self->{diskTotal};
}

=head2 version

The software version date

=cut

sub version {
    my $self = shift;
    my $val  = shift;


    return $self->{version};
}

=head2 currentArchiveBytes

The total number of bytes used by archives on thissystem

=cut

sub currentArchiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{currentArchiveBytes};
}

=head2 hostAddresses

Each of the IP addresses that this server might beusing

=cut

sub hostAddresses {
    my $self = shift;
    my $val  = shift;


    return $self->{hostAddresses};
}

=head2 engineMemoryTotal

The total RAM available to the server (Java virtualmachine)

=cut

sub engineMemoryTotal {
    my $self = shift;
    my $val  = shift;


    return $self->{engineMemoryTotal};
}

=head2 hostName

The name of this host

=cut

sub hostName {
    my $self = shift;
    my $val  = shift;


    return $self->{hostName};
}

=head2 connectedClientCount

The number of computers currently connected to thisserver

=cut

sub connectedClientCount {
    my $self = shift;
    my $val  = shift;


    return $self->{connectedClientCount};
}

=head2 previousMonthArchiveBytes

The above total from 30 days ago

=cut

sub previousMonthArchiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{previousMonthArchiveBytes};
}

=head2 hostMemoryFree

The unused RAM available to the host operating system

=cut

sub hostMemoryFree {
    my $self = shift;
    my $val  = shift;


    return $self->{hostMemoryFree};
}

=head2 cpuUtilization

The percentage of CPU currently being used

=cut

sub cpuUtilization {
    my $self = shift;
    my $val  = shift;


    return $self->{cpuUtilization};
}

=head2 hostMemoryCached

The swap size for the host operating system

=cut

sub hostMemoryCached {
    my $self = shift;
    my $val  = shift;


    return $self->{hostMemoryCached};
}

=head2 diskFree

The disk space available on the host OS boot drive

=cut

sub diskFree {
    my $self = shift;
    my $val  = shift;


    return $self->{diskFree};
}

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
