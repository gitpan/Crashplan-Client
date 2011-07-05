#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Data::Dumper;
use Crashplan::Client;

unless ( $ENV{TEST_SERVER} && $ENV{TEST_USER} && $ENV{TEST_PASSWORD} ) {
    warn("\n\nSet TEST_SERVER, TEST_USER, TEST_PASSWORD for live testing\n\n");
    diag( $ENV{TEST_SERVER});
    diag( $ENV{TEST_USER});
    diag( $ENV{TEST_PASSWORD} );
    plan skip_all => ' Set environment vars for server testing';
}

plan tests => 30;

diag("Testing with ($ENV{TEST_SERVER})($ENV{TEST_USER})($ENV{TEST_PASSWORD})");

my $client = Crashplan::Client->new({server => $ENV{TEST_SERVER}, user => $ENV{TEST_USER}, password => $ENV{TEST_PASSWORD}});
isa_ok($client, 'Crashplan::Client');

#
# Test orgs API
#
$client->request('GET','/rest/orgs');
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/orgs');  
like($client->responseCode, qr/200|302/, 'Response ok');
my @orgs = $client->parse_response;

for my $org (@orgs) {
    isa_ok($org, 'Crashplan::Client::Org');
}

#
# Test users API
#
$client->request('GET','/rest/users');
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/users');  
like($client->responseCode, qr/200|302/, 'Response ok');

my @users = $client->parse_response;
for my $user (@users) {
    isa_ok($user, 'Crashplan::Client::User');
}

my $user1 = shift @users;

#
# Test computers API
#
$client->request('GET','/rest/computers');
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/computers');  
like($client->responseCode, qr/200|302/, 'Response ok');

my @computers = $client->parse_response;
for my $computer (@computers) {
    isa_ok($computer, 'Crashplan::Client::Computer');
}

my $computer1 = shift @computers;


=for comment

#
# Test computerusages API
#
$client->request('GET','/rest/computerUsages?sourceGuid='.$computer1->guid);
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/computerUsages?sourceGuid='.$computer1->guid);
like($client->responseCode, qr/200|302/, 'Response ok');


#
# Test archiverecords API
#
$client->request('GET','/rest/archiveRecords');
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/archiveRecords');  
like($client->responseCode, qr/200|302/, 'Response ok');


#
# Test serverstats API
#
$client->request('GET','/rest/serverstats');
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/serverstats');  
like($client->responseCode, qr/200|302/, 'Response ok');


#
# Test mountpoints API
#
$client->request('GET','/rest/mountpoints');
like($client->responseCode, qr/200|302/, 'Response ok');

$client->GET('/rest/mountpoints');  
like($client->responseCode, qr/200|302/, 'Response ok');

=cut

