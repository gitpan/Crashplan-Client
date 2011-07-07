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
use Crashplan::Client::ServerStatistics;

use Data::Dumper;

=head1 NAME

Crashplan::Client - Client to the Crashplan PROe server 

=head1 VERSION

Version 0.002.0

=cut

our $VERSION = '0.002_0';

=head1 SYNOPSIS

Crashplan::Client allow you to access an Crashplan PROe server (hopefully) in a easy way.

This version only provides a low level API matching part of the server REST API.

This version (0.2.0) provides the new highlevel API which will add syntaxic sugar
and more functional goodies in the near future.

What you can do now :

    use Crashplan::Client;

    my $client = Crashplan::Client->new();
    
    my @orgs = $client->orgs;

    my $org = shift @orgs;

    ...

It's planned to offer (NOT IMPLEMENTED YET) something more like :

    use Crashplan::Client;

    my $client = Crashplan::Client->new();
    
    my $org = $client->orgs->first;

    ...


The first lowlevel API is still present 

    use Crashplan::Client;

    my $client = Crashplan::Client->new();
    
    $client->GET('/rest/orgs');

    my @orgs = $client->parse_response;

    my $org = shift @orgs;

    ...


=head1 SUBROUTINES/METHODS - Highlevel API

=head2 new ()

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
        # Automatically follow redirect
        $self->{rest}->setFollow(1);
        $self->{rest}->setHost($self->{server});
    }

    return bless $self, $class;
}

=head2 users ()

    Return all the users entity from the server

    Input  : None

    Output : An array of Crashplan::Client::User

=cut

sub users {
    my $self = shift;
    
    $self->GET('/rest/users');

    return $self->parse_response;
}

=head2 orgs ()

    Return all the orgs entity from the server

    Input  : None

    Output : An array of Crashplan::Client::Org

=cut

sub orgs {
    my $self = shift;
    
    $self->GET('/rest/orgs');

    return $self->parse_response;
}

=head2 computers ()

    Return all the computers entity from the server

    Input  : None

    Output : An array of Crashplan::Client::Computer

=cut

sub computers {
    my $self = shift;
    
    $self->GET('/rest/computers');

    return $self->parse_response;
}

=head2 user ($id)

    Return the user entity whose id is passed as parameter 

    Input  : None

    Output : A Crashplan::Client::User object

=cut

sub user {
    my $self = shift;
    my $id   = shift;
    
    $self->GET("/rest/users/$id");

    return $self->parse_response;
}

=head2 computer ($id)

    Return the computer entity whose id is passed as parameter 

    Input  : None

    Output : A Crashplan::Client::Computer object

=cut

sub computer {
    my $self = shift;
    my $id   = shift;
    
    $self->GET("/rest/computers/$id");

    return $self->parse_response;
}

=head2 org ($id)

    Return the org entity whose id is passed as parameter 

    Input  : None

    Output : A Crashplan::Client::Org object

=cut

sub org {
    my $self = shift;
    my $id   = shift;
    
    $self->GET("/rest/orgs/$id");

    return $self->parse_response;
}

=head1 SUBROUTINES/METHODS - Lowlevel API

=head2 set_rest_header ($key, $value)

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

=head2 unset_rest_header ($key)

    Unset a rest header

    Input  : $key the name of the header to be unset

    Output : None

=cut

sub unset_rest_header {
    my $self  = shift;
    my $key   = shift;
    my $value = shift;

    delete $self->{rest_header}{$key};
}

=head2 request ($method, $url [,$content, $header_ref])

    Request against the rest API

    Input  :    $method the method to be used (GET, POST, PUT, DELETE)
                $url the url to be used with the server
                $content (OPTIONAL) content of the request
                $header  (OPTIONAL) hash reference of a header

    Output : None
             Will set internal attributes responseCode and responseContent

=cut

sub request {
    my $self    = shift;
    my $method  = shift;
    my $url     = shift;
    my $content = shift || '' ;
    my $header  = shift || $self->default_header;

    $self->{'rest'}->request( $method, $url, $content, $header );
}

=head2 responseContent ()

    Get the response content (for the previous request)

    Input  : None

    Output : A string with the response as a JSON structure

=cut

sub responseContent {
    my $self = shift;

    return $self->{'rest'}->responseContent;
}

=head2 responseCode ()

    Get the response code (for the previous request)

    Input  : None

    Output : An integer

=cut

sub responseCode {
    my $self = shift;

    return $self->{'rest'}->responseCode;
}

=head2 default_header ()

    Build a default header based on $self object attribute
    In particular user and password attributes are used to
    build the Basic Authentication credentials.

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

=head2 GET ($url [,$header])

    GET request against the REST server

    Input  : $url the url to be requested

    Output : None
             The state of the response is store in the internal 'rest' attribute which is 
             currently an REST::Client object

=cut

sub GET {
    my $self = shift;
    my $url  = shift;
    my $header = shift || $self->default_header;
    
    $self->{rest}->GET( $url, $header );
}


=head2 parse_response ()

    Parse a server response to populate Crashplan objects

    Input  : None (use $self->responseContent) 

    Output : Array or single Crashplan::Client::<entity> object based on the 
             previous request answer

=cut

sub parse_response {
    my $self = shift;
    my $response = shift || $self->responseContent;

    #$self->{responses} = decode_json($response);
    $self->{responses} = from_json($response);


    #
    # If a list is returned 2 keys at least are available metadata and the requested entity
    #
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
    #
    # If only a single entity try to guess type based on specific attribute
    #

    if (exists $self->{responses}{parentId}) {
            return _populate('Crashplan::Client::Org', $self->{responses});
    } elsif ($self->{responses}{mountPointId}) {
            return _populate('Crashplan::Client::Computer', $self->{responses});
    } elsif ($self->{responses}{email}) {
            return _populate('Crashplan::Client::User', $self->{responses});
    } elsif ($self->{responses}{cpuUtilization}) {
            return _populate('Crashplan::Client::ServerStatistics', $self->{responses});
    };

    
}

=head2 _populate ($entity_name, $hashref)

    Return an array of Crashplan::Client::$entity_name objects from the $hashref.

    Input  : Class name

    Output : Array of object

=cut

sub _populate {
    my $class = shift;
    my $ref   = shift;

    my @result;
    if (ref($ref) =~ /ARRAY/) {
        foreach my $entity (@$ref) {
            my $object = $class->new($entity);
            push @result, $object;
        }
        return @result;
    } elsif (ref($ref) =~ /HASH/) {
        my $object = $class->new($ref);
        return $object;
    }

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


=head1 SEE ALSO

See http://support.crashplanpro.com/doku.php/api

For a detailed API description.

=cut

1;    # End of Crashplan::Client
