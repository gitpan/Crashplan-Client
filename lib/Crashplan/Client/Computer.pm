package Crashplan::Client::Computer;

use strict;
use warnings;

our $VERSION = '0.002_0';

=head1 NAME

Crashplan::Client::Computer - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::Computer objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::Computer

=head1 DESCRIPTION

A computer represents a unique resource which has connected to a CrashPlanPRO
server and (perhaps) backed up data. Every computer must belong to exactly one
user.


=head1 METHODS

=head2 new

The Crashplan::Client::Computer constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (
 		serverBackupStatsPercentComplete => 'serverBackupStats.percentComplete', 
 		serverBackupStatsCompressionRate => 'serverBackupStats.compressionRate', 
 		serverBackupStatsArchiveBytes => 'serverBackupStats.archiveBytes', 
 		serverBackupStatsSelectedBytes => 'serverBackupStats.selectedBytes', 
 		serverBackupStatsConnected => 'serverBackupStats.connected', 
 		serverBackupStatsNumberSelected => 'serverBackupStats.numberSelected', 

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::Computer';
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

=head2 mountPointId

The id number of the mount point where the computer's archive resides

=cut

sub mountPointId {
    my $self = shift;
    my $val  = shift;


    return $self->{mountPointId};
}

=head2 serverBackupStatsCompressionRate

The compression rate of backups from this computer to the PRO Server. This valueis equivalent to the “Comp %” field in this_view of the admin console.A boolean value indicating whether this computer is currently connected to the

=cut

sub serverBackupStatsCompressionRate {
    my $self = shift;
    my $val  = shift;


    return $self->{serverBackupStatsCompressionRate};
}

=head2 status

“Active” if the computer is currently active, “Deactivated” if the computer has beendeactivated

=cut

sub status {
    my $self = shift;
    my $val  = shift;


    return $self->{status};
}

=head2 serverBackupStatsPercentComplete

The completion percentage for backups of this computer to the PRO Server. Thisvalue is equivalent to the ”% Complete” field in this_view of the admin console.

=cut

sub serverBackupStatsPercentComplete {
    my $self = shift;
    my $val  = shift;


    return $self->{serverBackupStatsPercentComplete};
}

=head2 alertStates

“OK” if the computer has backed up within defined days, “WARN” if computer hasexceeded “warning” threshold, “ALERT” if computer has exceeded “alert” threshold

=cut

sub alertStates {
    my $self = shift;
    my $val  = shift;


    return $self->{alertStates};
}

=head2 remoteAddress

The IP address used by this computer to communicate with the PRO Server

=cut

sub remoteAddress {
    my $self = shift;
    my $val  = shift;


    return $self->{remoteAddress};
}

=head2 serverBackupStatsSelectedBytes

The total size of files selected for backup to the PRO Server. This value isequivalent to the “Bytes” field in this_view of the admin console.

=cut

sub serverBackupStatsSelectedBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{serverBackupStatsSelectedBytes};
}

=head2 guid

The GUID (globally unique identifier) for this computer

=cut

sub guid {
    my $self = shift;
    my $val  = shift;


    return $self->{guid};
}

=head2 timeZone

The time zone confgured on this computer

=cut

sub timeZone {
    my $self = shift;
    my $val  = shift;


    return $self->{timeZone};
}

=head2 javaVersion

The Java virtual machine version in use on this computer

=cut

sub javaVersion {
    my $self = shift;
    my $val  = shift;


    return $self->{javaVersion};
}

=head2 osVersion

Version of the operating system in use on this computer

=cut

sub osVersion {
    my $self = shift;
    my $val  = shift;


    return $self->{osVersion};
}

=head2 version

The version of CrashPlan software used on this computer

=cut

sub version {
    my $self = shift;
    my $val  = shift;


    return $self->{version};
}

=head2 name

The name of this computer

=cut

sub name {
    my $self = shift;
    my $val  = shift;


    return $self->{name};
}

=head2 userId

The id of the user to which this computer belongs

=cut

sub userId {
    my $self = shift;
    my $val  = shift;


    return $self->{userId};
}

=head2 osArch

The underlying architecture of this computer

=cut

sub osArch {
    my $self = shift;
    my $val  = shift;


    return $self->{osArch};
}

=head2 serverBackupStatsConnected

PRO Server. This value is equivalent to the “Connected” field in this_view of theadmin console.

=cut

sub serverBackupStatsConnected {
    my $self = shift;
    my $val  = shift;


    return $self->{serverBackupStatsConnected};
}

=head2 osName

Name of the operating system in use on this computer

=cut

sub osName {
    my $self = shift;
    my $val  = shift;


    return $self->{osName};
}

=head2 serverBackupStatsArchiveBytes

The total disk space used by the PRO Server to store backups from this computer.This value is equivalent to the “Stored” field in this_view of the admin console.

=cut

sub serverBackupStatsArchiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{serverBackupStatsArchiveBytes};
}

=head2 serverBackupStatsNumberSelected

The number of files selected for backup to the PRO Server. This value isequivalent to the “Selected” field in this_view of the admin console.

=cut

sub serverBackupStatsNumberSelected {
    my $self = shift;
    my $val  = shift;


    return $self->{serverBackupStatsNumberSelected};
}

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
