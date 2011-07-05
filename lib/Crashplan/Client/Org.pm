package Crashplan::Client::Org;

use strict;
use warnings;

our $VERSION = '0.001';

=head1 NAME

Crashplan::Client::Org - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::Org objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::Org

=head1 DESCRIPTION

An org represents a collection of users. Every user must belong to an org and
cannot belong to more than one org at the same time. Orgs may also contains
suborgs.


=head1 METHODS

=head2 new

The Crashplan::Client::Org constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (
 		quotaSeats => 'quota.seats', 
 		quotaBytes => 'quota.bytes', 

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::Org';
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

=head2 archiveBytesDeltaMonth

Change in the number of bytes stored in all archiveswithin the org over 30 days

=cut

sub archiveBytesDeltaMonth {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytesDeltaMonth};
}

=head2 archiveBytesDelta

Change in the number of bytes stored in all archiveswithin the org

=cut

sub archiveBytesDelta {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytesDelta};
}

=head2 status

“Active” if the org is currently active, “Deactivated” if the org has beendeactivated

=cut

sub status {
    my $self = shift;
    my $val  = shift;


    return $self->{status};
}

=head2 quotaBytes

Configured size quota for this org (in gigabytes)

=cut

sub quotaBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{quotaBytes};
}

=head2 dailyChange

?

=cut

sub dailyChange {
    my $self = shift;
    my $val  = shift;


    return $self->{dailyChange};
}

=head2 name

Current name of the org

=cut

sub name {
    my $self = shift;
    my $val  = shift;


    return $self->{name};
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

=head2 quotaSeats

Configured seat quota for this org

=cut

sub quotaSeats {
    my $self = shift;
    my $val  = shift;


    return $self->{quotaSeats};
}

=head2 archiveBytes

Number of bytes stored in all archives within the org

=cut

sub archiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytes};
}

=head2 parentId

The id value of the parent org or null if this org has no parent

=cut

sub parentId {
    my $self = shift;
    my $val  = shift;


    return $self->{parentId};
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

=head2 registrationKey

The registration key for this org

=cut

sub registrationKey {
    my $self = shift;
    my $val  = shift;


    return $self->{registrationKey};
}

=head2 masterGuid

If not null then this org is a slave org and the value of this field contains theGUID for the corresponding master

=cut

sub masterGuid {
    my $self = shift;
    my $val  = shift;


    return $self->{masterGuid};
}

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
