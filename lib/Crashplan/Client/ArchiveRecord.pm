package Crashplan::Client::ArchiveRecord;

use strict;
use warnings;

our $VERSION = '0.003_0';

=head1 NAME

Crashplan::Client::ArchiveRecord - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::ArchiveRecord objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::ArchiveRecord

=head1 DESCRIPTION

Daily historical record of archive statistics. Records for users and orgs are
summaries of all the computers in that user or organization.


=head1 METHODS

=head2 new

The Crashplan::Client::ArchiveRecord constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::ArchiveRecord';
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

The id of the target computer - will be null if userIdor orgId is not null

=cut

sub targetId {
    my $self = shift;
    my $val  = shift;


    return $self->{targetId};
}

=head2 dailyChange

A rolling 30-day average of bytes added or removed fromthe archive

=cut

sub dailyChange {
    my $self = shift;
    my $val  = shift;


    return $self->{dailyChange};
}

=head2 lastConnected

Timestamp indicating the last time a computer connectedto the target or null if there has been no connection

=cut

sub lastConnected {
    my $self = shift;
    my $val  = shift;


    return $self->{lastConnected};
}

=head2 userId

The id of the user this record represents - will be nullif sourceId, targetId, or orgId are not null

=cut

sub userId {
    my $self = shift;
    my $val  = shift;


    return $self->{userId};
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

=head2 archiveBytes

Bytes used by the archive

=cut

sub archiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytes};
}

=head2 lastActivity

Timestamp indicating the last backup activity or null ifthere has been no activity

=cut

sub lastActivity {
    my $self = shift;
    my $val  = shift;


    return $self->{lastActivity};
}

=head2 sourceId

The id of the source computer - will be null if userIdor orgId is not null

=cut

sub sourceId {
    my $self = shift;
    my $val  = shift;


    return $self->{sourceId};
}

=head2 orgId

The id of the org this record represents - will be nullif sourceId, targetId, or userId are not null

=cut

sub orgId {
    my $self = shift;
    my $val  = shift;


    return $self->{orgId};
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

=head1 SEE ALSO

http://support.crashplanpro.com/doku.php/api#archive_record

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
