#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Data::Dumper;
use Crashplan::Client;

unless ( $ENV{TEST_SERVER} && $ENV{TEST_USER} && $ENV{TEST_PASSWORD} ) {
    warn("\n\nSet TEST_SERVER, TEST_USER, TEST_PASSWORD for live testing\n\n");
    plan skip_all => ' Set environment vars for server testing';
}

plan tests => 84;

my $pass = $ENV{TEST_PASSWORD};
$pass =~ s/^(.).*(.)$/$1..$2/;

diag(
"Testing with ($ENV{TEST_SERVER})($ENV{TEST_USER})($pass)"
);

my $client = Crashplan::Client->new(
    {
        server   => $ENV{TEST_SERVER},
        user     => $ENV{TEST_USER},
        password => $ENV{TEST_PASSWORD}
    }
);
isa_ok( $client, 'Crashplan::Client', 'Crashplan::Client->new()' );

#
# Test orgs API
#
$client->request( 'GET', '/rest/orgs',undef,undef );
is( $client->responseCode, 200,
    'request GET /rest/orgs' );
my @orgs = $client->parse_response;

$client->GET('/rest/orgs');
is( $client->responseCode, 200, 'GET /rest/orgs' );
my @orgs2 = $client->parse_response;

for my $org (@orgs) {
    isa_ok( $org, 'Crashplan::Client::Org',
        "Object returned is a Crashplan::Client::org" );
}

my @orgs3 = $client->orgs;
is_deeply( \@orgs, \@orgs2, 'Request and GET on /users/orgs' );
is_deeply( \@orgs, \@orgs3, 'Request and highlevel API on /users/orgs');

my $org = shift @orgs;
my $id  = $org->id;

$client->request( 'GET', "/rest/orgs/$id");
is( $client->responseCode, 200, 'Org retrieval by id' );
my $org2 = $client->parse_response;

$client->GET("/rest/orgs/$id");
is( $client->responseCode, 200, 'Response ok' );
my $org3 = $client->parse_response;

my $org4 = $client->org($id);

is($org->name,$org2->name,'Identical name');
is($org3->name,$org4->name,'Identical name');
is($org->status,$org2->status,'Identical status');
is($org3->status,$org4->status,'Identical status');
is($org->parentId,$org2->parentId,'Identical parentId');
is($org3->parentId,$org4->parentId,'Identical parentId');
is($org->masterGuid,$org2->masterGuid,'Identical masterGuit');
is($org3->masterGuid,$org4->masterGuid,'Identical masterGuit');
#is($org->registrationKey,$org2->registrationKey,'Identical registrationKey');
#is($org3->registrationKey,$org4->registrationKey,'Identical registrationKey');
is($org->creationDate,$org2->creationDate,'Identical creationDate');
is($org3->creationDate,$org4->creationDate,'Identical creationDate');
is($org->modificationDate,$org2->modificationDate,'Identical modificationDate');
is($org3->modificationDate,$org4->modificationDate,'Identical modificationDate');

#
# Test users API
#
$client->request( 'GET', '/rest/users' );
is( $client->responseCode, 200, 'Response ok' );
my @users = $client->parse_response;

$client->GET('/rest/users');
is( $client->responseCode, 200, 'Response ok' );
my @users2 = $client->parse_response;

for my $user (@users) {
    isa_ok( $user, 'Crashplan::Client::User' );
}

my @users3 = $client->users;
is_deeply( \@users, \@users2 );
is_deeply( \@users, \@users3 );

my $user = shift @users;
$id = $user->id;

$client->request( 'GET', "/rest/users/$id" );
is( $client->responseCode, 200, 'Response ok' );
my $user2 = $client->parse_response;

$client->GET("/rest/users/$id");
is( $client->responseCode, 200, 'Response ok' );
my $user3 = $client->parse_response;

my $user4 = $client->user($id);

is($user->status,$user2->status);
is($user3->status,$user4->status);
#is($user->username,$user2->username);
#is($user3->username,$user4->username);
is($user->email,$user2->email);
is($user3->email,$user4->email);
is($user->firstName,$user2->firstName);
is($user3->firstName,$user4->firstName);
is($user->lastName,$user2->lastName);
is($user3->lastName,$user4->lastName);
is($user->orgId,$user2->orgId);
is($user3->orgId,$user4->orgId);
is($user->creationDate,$user2->creationDate);
is($user3->creationDate,$user4->creationDate);
is($user->modificationDate,$user2->modificationDate);
is($user3->modificationDate,$user4->modificationDate);

#
# Test computers API
#
$client->request( 'GET', '/rest/computers' );
is( $client->responseCode, 200, 'Response ok' );
my @computers = $client->parse_response;

$client->GET('/rest/computers');
is( $client->responseCode, 200, 'Response ok' );
my @computers2 = $client->parse_response;

for my $computer (@computers) {
    isa_ok( $computer, 'Crashplan::Client::Computer' );
}

my @computers3 = $client->computers;
is_deeply( \@computers, \@computers2 );
is_deeply( \@computers, \@computers3 );

my $computer = shift @computers;
$id = $computer->id;

$client->request( 'GET', "/rest/computers/$id" );
is( $client->responseCode, 200, 'Response ok' );
my $computer2 = $client->parse_response;

$client->GET("/rest/computers/$id");
is( $client->responseCode, 200, 'Response ok' );
my $computer3 = $client->parse_response;

my $computer4 = $client->computer($id);

is($computer->name,$computer2->name);
is($computer3->name,$computer4->name);
is($computer->guid,$computer2->guid);
is($computer3->guid,$computer4->guid);
is($computer->status,$computer2->status);
is($computer3->status,$computer4->status);
is_deeply($computer->alertStates,$computer2->alertStates);
is_deeply($computer3->alertStates,$computer4->alertStates);
is($computer->userId,$computer2->userId);
is($computer3->userId,$computer4->userId);
is($computer->mountPointId,$computer2->mountPointId);
is($computer3->mountPointId,$computer4->mountPointId);
is($computer->creationDate,$computer2->creationDate);
is($computer3->creationDate,$computer4->creationDate);
is($computer->modificationDate,$computer2->modificationDate);
is($computer3->modificationDate,$computer4->modificationDate);

=for comment

#
# Test computerusages API
#
$client->request('GET','/rest/computerUsages?sourceGuid='.$computer1->guid);
is($client->responseCode, 200, 'Response ok');

$client->GET('/rest/computerUsages?sourceGuid='.$computer1->guid);
is($client->responseCode, 200, 'Response ok');


#
# Test archiverecords API
#
$client->request('GET','/rest/archiveRecords');
is($client->responseCode, 200, 'Response ok');

$client->GET('/rest/archiveRecords');  
is($client->responseCode, 200, 'Response ok');


#
# Test serverstats API
#
$client->request('GET','/rest/serverstats');
is($client->responseCode, 200, 'Response ok');

$client->GET('/rest/serverstats');  
is($client->responseCode, 200, 'Response ok');


#
# Test mountpoints API
#
$client->request('GET','/rest/mountpoints');
is($client->responseCode, 200, 'Response ok');

$client->GET('/rest/mountpoints');  
is($client->responseCode, 200, 'Response ok');

=cut

