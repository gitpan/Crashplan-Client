package Crashplan::Client::User;

use strict;
use warnings;
use JSON;

our $VERSION = '0.003_0';

=head1 NAME

Crashplan::Client::User - Object representation of Crashplan PROe server's entity

=head1 SYNOPSIS

Crashplan::Client::User objects are instancied by Crashplan::Client.

Specifically, calling Crashplan::Client->parse_response after querying 
the server could produce Crashplan::Client::User

=head1 DESCRIPTION

A user represents a distinct entity which uses the CrashPlan PRO Server for
backups. Every user is a member of exactly one org. Users may also contain one
or more computers.


=head1 METHODS

=head2 new

The Crashplan::Client::User constructor

=cut

sub new {
    my $class = shift;
    my $param = shift || {};
    
    my %converted_name = (
 		quotaBytes => 'quota.bytes', 

    );

    my $self  = $param;


    return bless $param,'Crashplan::Client::User';
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

=head2 firstName

First name of the user

=cut

sub firstName {
    my $self = shift;
    my $val  = shift;

    if ($val) {
        $self->{'firstName'} = $val;
    }


    return $self->{firstName};
}

=head2 archiveBytesDeltaMonth

Change in the number of bytes stored in the user'sarchive(s) over a month

=cut

sub archiveBytesDeltaMonth {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytesDeltaMonth};
}

=head2 archiveBytesDelta

Change in the number of bytes stored in the user'sarchive(s)

=cut

sub archiveBytesDelta {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytesDelta};
}

=head2 status

“Active” if the user is currently active, “Deactivated” if the user has beendeactivated

=cut

sub status {
    my $self = shift;
    my $val  = shift;
    
    if ($val) {
        $self->{'status'} = $val;
    }

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

=head2 selectedBytes

Byte count for all files selected for backup

=cut

sub selectedBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{selectedBytes};
}

=head2 username

Used for user creation

=cut

sub username {
    my $self = shift;
    my $val  = shift;

    if ($val) {
        $self->{'username'} = $val;
    }

    return $self->{username};
}

=head2 todoFiles

Count of all files waiting to be backed up

=cut

sub todoFiles {
    my $self = shift;
    my $val  = shift;


    return $self->{todoFiles};
}

=head2 email

Email address of the user

=cut

sub email {
    my $self = shift;
    my $val  = shift;
    
    if ($val) {
        $self->{'email'} = $val;
    }

    return $self->{email};
}

=head2 archiveBytes

Number of bytes stored in the user's archive(s)

=cut

sub archiveBytes {
    my $self = shift;
    my $val  = shift;


    return $self->{archiveBytes};
}

=head2 lastName

Last name of the user

=cut

sub lastName {
    my $self = shift;
    my $val  = shift;
    
    if ($val) {
        $self->{'lastName'} = $val;
    }

    return $self->{lastName};
}

=head2 orgId

The id of the org to which this user belongs

=cut

sub orgId {
    my $self = shift;
    my $val  = shift;
    
    if ($val) {
        $self->{'orgId'} = $val;
    }

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

=head2 update

Update an User entry in the database

=cut

sub update {
    my $self = shift;
    #my @attributes = qw/name status parentId masterGuid registrationKey/;

    # Filter out non REST attribute from the current object
    my @attributes = grep {!/^rest|rest_header$/} keys %$self;

    my $body = encode_json( { map {$_ => $self->{$_}} @attributes} );

    $self->{rest}->PUT($self->url."/".$self->id,$body);
}

=head2 url

Getter for the 'url" to access the REST server

=cut

sub url {
    my $self = shift;

    return '/rest/users';
}

=head1 SEE ALSO

http://support.crashplanpro.com/doku.php/api#user

=head1 AUTHOR

Arnaud (Arhuman) Assad, copyright 2011 Jaguar Network

=head1 LICENSE

This library is free software . You can redistribute it and/or modify
it under the same terms as perl itself.

=cut

1;
