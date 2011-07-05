package Crashplan::Client;

use warnings;
use strict;

use Carp;
use MIME::Base64;
use REST::Client;
use JSON;

use Crashplan::Client::Org;
use Crashplan::Client::User;
use Crashplan::Client::Computer;
use Crashplan::Client::ComputerUsage;
use Crashplan::Client::MountPoint;

=head1 NAME

Crashplan::Client - The great new Crashplan::Client!

=head1 VERSION

Version 0.01

=cut

our $VERSION = '0.001';

=head1 SYNOPSIS

Crashplan::Client allow you to access an Crashplan PROe server (hopefully) in a easy way.

This version only provides a low level API matching part of the server REST API.

The main objective in a near future is to provide an additional higher level API
(read 'syntaxic sugar') while enlarging the coverage of the lowlevel API.


Now you (still) must do 

    use Crashplan::Client;

    my $client = Crashplan::Client->new();
    
    $client->GET('/rest/orgs');

    my @orgs = $client->parse_response;

    my $org = shift @orgs;

    ...


It's planned to offer (NOT IMPLEMENTED YET) something more like :


    use Crashplan::Client;

    my $client = Crashplan::Client->new();
    
    my @orgs = $client->orgs;

    my $org = shift @orgs;

    ...

 or even

    use Crashplan::Client;

    my $client = Crashplan::Client->new();
    
    my $org = $client->orgs->first;

    ...


=head1 SUBROUTINES/METHODS

=head2 new

Constructor for the Crashplan::Client class

=cut

sub new {
    my $class  = shift;
    my $params = shift;

    my $self = {};

    for my $key ( keys %$params ) {
        if ( $key =~ /^server$/i ) { $self->{'server'} = $params->{$key}; next }
        if ( $key =~ /^user$/i )   { $self->{'user'}   = $params->{$key}; next }
        if ( $key =~ /^password$/i ) {
            $self->{'password'} = $params->{$key};
            next;
        }
        carp "Unknown paramseter $key";
        return undef;
    }

    if ( $self->{server} ) {
        $self->{rest} = REST::Client->new();
        $self->{rest}->setHost($self->{server});
    }

    return bless $self, $class;
}

=head2 set_rest_header

    Set a rest header

    Input  : header, value the name and the value of the header to be set

    Output : None

=cut

sub set_rest_header {
    my $self  = shift;
    my $key   = shift;
    my $value = shift;

    $self->{rest_header}{$key} = $value;
}

=head2 unset_rest_header

    Unset a rest header

    Input  : header the name and the value of the header to be unset

    Output : None

=cut

sub unset_rest_header {
    my $self  = shift;
    my $key   = shift;
    my $value = shift;

    delete $self->{rest_header}{$key};
}

=head2 request

    Request against the rest API

    Input  : method

    Output : None

=cut

sub request {
    my $self    = shift;
    my $method  = shift;
    my $url     = shift;
    my $content = shift || '' ;
    my $header  = shift || $self->default_header;

    croak "Server undefined" unless $self->{server};

    $self->{'rest'}->request( $method, $self->{server}.$url, $content, $header );
}

=head2 responseContent

    Get the response content (for the previous request)

    Input  : None

    Output : None

=cut

sub responseContent {
    my $self = shift;

    return $self->{'rest'}->responseContent;
}

=head2 responseCode

    Get the response code (for the previous request)

    Input  : None

    Output : None

=cut

sub responseCode {
    my $self = shift;

    return $self->{'rest'}->responseCode;
}

=head2 default_header

    Build a default header based on $self object attribute

    Input  : None

    Output : A hash ref

=cut

sub default_header {
    my $self = shift;

    my $user  = $self->{user}       || ''; 
    my $pass  = $self->{password}   || ''; 

    my $creds  = encode_base64($user.":".$pass); 

    return { Authorization => "Basic $creds", "Accept" => "application/json" };

}

=head2 GET

    GET request against the REST server

    Input  : $url the url to be requested

    Output : None

=cut

sub GET {
    my $self = shift;
    my $url  = shift;
    my $header = shift || $self->default_header;
    
    $self->{rest}->GET( $url, $header );
}


=head2 parse_response

    Parse a server response to populate Crashplan objects

    Input  : None (use $self->responseContent) 

    Output : None

=cut

sub parse_response {
    my $self = shift;
    my $response = shift || $self->responseContent;

    $self->{responses} = decode_json($response);


    for my $entity (keys %{$self->{responses}}) {
        if ($entity =~ /orgs/) {
            return _populate('Crashplan::Client::Org', $self->{responses}{$entity});
        } elsif ($entity =~ /users/) {
            return _populate('Crashplan::Client::User', $self->{responses}{$entity});
        } elsif ($entity =~ /computers/) {
            return _populate('Crashplan::Client::Computer', $self->{responses}{$entity});
        } elsif ($entity =~ /computerUsages/) {
            return _populate('Crashplan::Client::ComputerUsage', $self->{responses}{$entity});
        } elsif ($entity =~ /mountPoints/) {
            return _populate('Crashplan::Client::MountPoint', $self->{responses}{$entity});
        }
    }
    
}

=head2 _populate

    Return an array of Crashplan::Client object from a hash.

    Input  : Class name

    Output : Array of object

=cut

sub _populate {
    my $class = shift;
    my $aref  = shift;

    my @result;

    foreach my $entity (@$aref) {
        my $object = $class->new($entity);
        push @result, $object;
    }

    return @result;
}

=head1 TESTING

To enable testing against a Crashplan server,
set the following environment variables before running 'make test' .

TEST_SERVER, TEST_USER, TEST_PASSWORD


=head1 AUTHOR

Arnaud (Arhuman) ASSAD, C<< <arnaud.assad at jaguar-network.com> >>

=head1 BUGS

Please report any bugs or feature requests to C<bug-crashplan-client at rt.cpan.org>, or through
the web interface at L<http://rt.cpan.org/NoAuth/ReportBug.html?Queue=Crashplan-Client>.  I will be notified, and then you'll
automatically be notified of progress on your bug as I make changes.

=head1 SUPPORT

You can find documentation for this module with the perldoc command.

    perldoc Crashplan::Client


You can also look for information at:

=over 4

=item * RT: CPAN's request tracker

L<http://rt.cpan.org/NoAuth/Bugs.html?Dist=Crashplan-Client>

=item * AnnoCPAN: Annotated CPAN documentation

L<http://annocpan.org/dist/Crashplan-Client>

=item * CPAN Ratings

L<http://cpanratings.perl.org/d/Crashplan-Client>

=item * Search CPAN

L<http://search.cpan.org/dist/Crashplan-Client/>

=back


=head1 ACKNOWLEDGEMENTS


=head1 LICENSE AND COPYRIGHT

Copyright 2011 Arnaud (Arhuman) ASSAD.

This program is free software; you can redistribute it and/or modify it
under the terms of either: the GNU General Public License as published
by the Free Software Foundation; or the Artistic License.

See http://dev.perl.org/licenses/ for more information.


=cut

1;    # End of Crashplan::Client
