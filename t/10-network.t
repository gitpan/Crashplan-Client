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

plan tests => 135;

my $pass = $ENV{TEST_PASSWORD};
$pass =~ s/^(.).*(.)$/$1..$2/;



diag( "Testing with ($ENV{TEST_SERVER})($ENV{TEST_USER})($pass)" );

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
is($org->masterGuid,$org2->masterGuid,'Identical masterGuid');
is($org3->masterGuid,$org4->masterGuid,'Identical masterGuid');
#is($org->registrationKey,$org2->registrationKey,'Identical registrationKey');
#is($org3->registrationKey,$org4->registrationKey,'Identical registrationKey');
is($org->creationDate,$org2->creationDate,'Identical creationDate');
is($org3->creationDate,$org4->creationDate,'Identical creationDate');
is($org->modificationDate,$org2->modificationDate,'Identical modificationDate');
is($org3->modificationDate,$org4->modificationDate,'Identical modificationDate');


my $NAME = 'suborg test API';
my $ORGID;

@orgs = $client->orgs(name => $NAME);
my $org5 = shift @orgs;
if ( !$org5 ) {
    my $neworg =
      Crashplan::Client::Org->new( { name => $NAME, parentId => 3, } );
    $client->create($neworg);
    $ORGID = $neworg->id();
} else {
    $ORGID = $org5->id;
}

@orgs = $client->orgs(name => 'Default');
$org5 = shift @orgs;
my $ORGID2 = $org5->id;

$org5 = $client->org($ORGID);
$org5->name("$NAME (Changed)");
$org5->update;
$org5 = $client->org(99999999);
is($org5, undef, "Illegal id search return undef");
$org5 = $client->orgs(id => $ORGID);
isa_ok($org5, "Crashplan::Client::Org");

like($org5->name, qr/Changed/, 'Retrieved modified Org');

# Change status (also change the name !!)
$org5->status("Deactivated");
$org5->update;


# Change several properties at the same time
$org5->name($NAME);
$org5->parentId($ORGID2);
$org5->update;

@orgs = $client->orgs(name => $NAME);
$org5 = shift @orgs;
isa_ok($org5, "Crashplan::Client::Org");

is($org5->name, $NAME, 'The right Org has been selected by its name');
is($org5->status, 'Deactivated', 'Status has been deactivated');
$org5->status("Active");
$org5->update;
@orgs = $client->orgs(parentId => $ORGID2);
$org5 = shift @orgs;
isa_ok($org5, "Crashplan::Client::Org");
is($org5->name, $NAME, 'The right Org has been selected by its parentId');
is($org5->status, 'Active', 'Status has been activated');
#$org5->status("Deactivated");
$org5->parentId(3);
$org5->update();
$org5->name($NAME);
$org5->update();

eval {@orgs = $client->orgs(illegal => 3); };
ok($@, "Exception raised with illegal filter");


#TODO not working currently 
#$org5->masterGuid("globallyuniqueid");
#$org5->registrationKey("m87arhuman2wwpws");

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


my $EMAIL = 'testuser@testcrashplan.com';
my $USERID;
@users = $client->users(username => $EMAIL);
my $user5 = shift @users;
if ( !$user5 ) {
    my $newuser =
      Crashplan::Client::User->new( { username => $EMAIL, orgId => $ORGID, firstName=> 'T.', lastName=> 'Heste', password=>'none' } );
    $client->create($newuser);
    $USERID = $newuser->id();
    $user5 = $newuser;
} else {
    $USERID = $user5->id;
}

$user5 = $client->user($USERID);
$user5->email("$EMAIL (Changed)");
$user5->update;

$user5 = $client->user(99999999);
is($user5, undef, "Illegal id search return undef");

@users = $client->users(id => $USERID);
$user5 = shift @users;

isa_ok($user5, "Crashplan::Client::User");

like($user5->email, qr/Changed/i, 'Retrieved modified User');

# Change status (also change the name !!)
$user5->status("Deactivated");
$user5->update;


# Change several properties at the same time
$user5->email($EMAIL);
$user5->orgId($ORGID2);
my $firstname= $user5->firstName;
$user5->firstName("$firstname (Changed firstname)");
my $lastname= $user5->lastName;
$user5->lastName("$lastname (Changed lastname)");
$user5->update;

@users = $client->users(email => $EMAIL);
$user5 = shift @users;
isa_ok($user5, "Crashplan::Client::User");

is($user5->email, $EMAIL, 'The right User has been selected by its email');
is($user5->status, 'Deactivated', 'Status has been deactivated');
like($user5->firstName, qr/Changed firstname/i, 'firstname has been changed');
like($user5->lastName, qr/Changed lastname/i, 'lastname has been changed');
$user5->status("Active");
$user5->firstName($firstname);
$user5->lastName($lastname);
$user5->update;
@users = $client->users(orgId => $ORGID2);
$user5 = shift @users;
isa_ok($user5, "Crashplan::Client::User");
is($user5->username, $EMAIL, 'The right User has been selected by its parentId');
is($user5->status, 'Active', 'Status has been activated');
$user5->status("Deactivated");
$user5->orgId($ORGID);
$user5->update();
$user5->email($EMAIL);
$user5->update();

# Check filtered list
@users = $client->users(status => 'Activated');
$user5 = shift @users;
isa_ok($user5, "Crashplan::Client::User", 'users(status => ...)');
@users = $client->users(firstname => $firstname);
$user5 = shift @users;
isa_ok($user5, "Crashplan::Client::User", 'users(firstname => ...)');
@users = $client->users(lastname => $lastname);
$user5 = shift @users;
isa_ok($user5, "Crashplan::Client::User", 'users(lastname => ...)');
eval {@users = $client->users(illegal => 3); };
ok($@, "Exception raised with illegal filter");


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



my $computer5 = $client->computer($id);
$computer5->name("Changed");
$computer5->update;

$computer5 = $client->computer(99999999);
is($computer5, undef, "Illegal id search return undef");

@computers = $client->computers(id => $id);
$computer5 = shift @computers;

isa_ok($computer5, "Crashplan::Client::Computer");

like($computer5->name, qr/Changed/i, 'Retrieved modified Computer');
$computer5->name($computer->name);

# Change status (also change the name !!)
$computer5->status("Deactivated");
$computer5->update;
$computer5 = $client->computer($id);
is($computer5->status, 'Deactivated', 'Status has been deactivated');
$computer5->status("Active");
$computer5->update;

# Change alertState 
$computer5->alertState("ALERT");
$computer5->update;
$computer5 = $client->computer($id);
is($computer5->alertState, 'ALERT', 'alertState  has been modified');
$computer5->alertState($computer->alertState);
$computer5->update;

# Change userId 
$computer5->userId($USERID);
$computer5->update;
$computer5 = $client->computer($id);
is($computer5->userId, $USERID, 'userID  has been modified');
$computer5->userId($computer->userId);
$computer5->update;

=for comment
# Change mountPointId 
$computer5->mountPointId($anothermountpointid);
$computer5->update;
$computer5 = $client->computer($id);
is($computer5->mountPointId, $USERID, 'userID  has been modified');
$computer5->mountPointId($computer->mountPointId);
$computer5->update;
=cut

# Check filtered list
@computers = $client->computers(status => 'Activated');
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(status => ...)');
@computers = $client->computers(firstname => $firstname);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(firstname => ...)');
@computers = $client->computers(lastname => $lastname);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(lastname => ...)');
eval {@computers = $client->computers(illegal => 3); };
ok($@, "Exception raised with illegal filter");

# Check filtered list
@computers = $client->computers(status => 'Activated');
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(status => ...)');
@computers = $client->computers(id => $computer->id);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(id => ...)');
@computers = $client->computers(name => $computer->name);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(name => ...)');
@computers = $client->computers(guid => $computer->guid);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(guid => ...)');
@computers = $client->computers(userId => $computer->userId);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer", 'computers(userid => ...)');
eval {@computers = $client->computers(illegal => 3); };
ok($@, "Exception raised with illegal filter");

=for comment 
# Computer creation not supported yet by REST api

my $COMPUTERNAME = 'TestBox';
my $COMPUTERID;
my $USERID2 = 3;
@computers = $client->computers(name => $COMPUTERNAME);
my $computer5 = shift @computers;
if ( !$computer5 ) {
    my $newcomputer =
      Crashplan::Client::Computer->new( { name => $EMAIL, userId => $USERID } );
    $client->create($newcomputer);
    $COMPUTERID = $newcomputer->id();
    $computer5 = $newcomputer;
} else {
    $COMPUTERID = $computer5->id;
}

$computer5 = $client->computer($COMPUTERID);
$computer5->name("$COMPUTERNAME (Changed)");
$computer5->update;

$computer5 = $client->computer(99999999);
is($computer5, undef, "Illegal id search return undef");

@computers = $client->computers(id => $COMPUTERID);
$computer5 = shift @computers;

isa_ok($computer5, "Crashplan::Client::Computer");

like($computer5->email, qr/Changed/i, 'Retrieved modified Computer');

# Change status (also change the name !!)
$computer5->status("Deactivated");
$computer5->update;


# Change several properties at the same time
$computer5->name($COMPUTERNAME);
$computer5->userId($USERID2);
$computer5->update;

@computers = $client->computers(email => $EMAIL);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer");

is($computer5->email, $EMAIL, 'The right Computer has been selected by its email');
is($computer5->status, 'Deactivated', 'Status has been deactivated');
$computer5->status("Active");
$computer5->firstName($firstname);
$computer5->lastName($lastname);
$computer5->update;

@computers = $client->computers(orgId => $ORGID2);
$computer5 = shift @computers;
isa_ok($computer5, "Crashplan::Client::Computer");
is($computer5->computername, $EMAIL, 'The right Computer has been selected by its parentId');
is($computer5->status, 'Active', 'Status has been activated');
$computer5->status("Deactivated");
$computer5->orgId($ORGID);
$computer5->update();
$computer5->email($EMAIL);
$computer5->update();

eval {@computers = $client->computers(illegal => 3); };
ok($@, "Exception raised with illegal filter");

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

=cut

#
# Test serverstats API
#
$client->request('GET','/rest/serverStats');
is($client->responseCode, 200, 'Response ok');
my @sstats = $client->parse_response;

$client->GET('/rest/serverStats');  
is($client->responseCode, 200, 'Response ok');
my @sstats2 = $client->parse_response;

for my $sstat (@sstats) {
    isa_ok( $sstat, 'Crashplan::Client::ServerStatistics',
        "Object returned is a Crashplan::Client::ServerStatistics" );
}

my $sstats = shift @sstats;
my $sstats2 = shift @sstats2;

is($sstats->orgCount,$sstats2->orgCount,'Identical orgCount');
is($sstats->seatCount,$sstats2->seatCount,'Identical seatCount');
is($sstats->version,$sstats2->version,'Identical version');
is($sstats->hostName,$sstats2->hostName,'Identical hostName');
is($sstats->hostPort,$sstats2->hostPort,'Identical hostPort');
is($sstats->hostMemoryTotal,$sstats2->hostMemoryTotal,'Identical hostMemoryTotal');
is($sstats->diskTotal,$sstats2->diskTotal,'Identical diskTotal');
is_deeply($sstats->hostAddresses,$sstats2->hostAddresses,'Identical hostAddresses');


eval {@sstats = $client->sstats(illegal => 3); };
ok($@, "Exception raised with illegal filter");

#
# Test mountpoints API
#
$client->request('GET','/rest/mountPoints');
is($client->responseCode, 200, 'Response ok');
my @mpts = $client->parse_response;


$client->GET('/rest/mountPoints');  
is($client->responseCode, 200, 'Response ok');
my @mpts2 = $client->parse_response;

for my $mpt (@mpts) {
    isa_ok( $mpt, 'Crashplan::Client::MountPoint',
        "Object returned is a Crashplan::Client::MountPoint" );
}

my $mpts = shift @mpts;
my $mpts2 = shift @mpts2;

is($mpts->name,$mpts2->name,'Identical name');
is($mpts->status,$mpts2->status,'Identical status');
is($mpts->type,$mpts2->type,'Identical type');
is($mpts->volumeLabel,$mpts2->volumeLabel,'Identical volumeLabel');
is($mpts->note,$mpts2->note,'Identical note');
is($mpts->bytesPerSecond,$mpts2->bytesPerSecond,'Identical bytesPerSecond');
is($mpts->bytesTotal,$mpts2->bytesTotal,'Identical bytesTotal');
is($mpts->bytesFree,$mpts2->bytesFree,'Identical bytesFree');
is($mpts->bytesUsed,$mpts2->bytesUsed,'Identical bytesUsed');
is($mpts->percentFree,$mpts2->percentFree,'Identical percentFree');

# Check filtered list
@mpts = $client->mpts(status => 'Activated');
my $mpt5 = shift @mpts;
isa_ok($mpt5, "Crashplan::Client::Computer", 'mpts(status => ...)');
@mpts = $client->mpts(id => $mpts->id);
$mpt5 = shift @mpts;
isa_ok($mpt5, "Crashplan::Client::Computer", 'mpts(id => ...)');
@mpts = $client->mpts(name => $mpts->name);
$mpt5 = shift @mpts;
isa_ok($mpt5, "Crashplan::Client::Computer", 'mpts(name => ...)');
@mpts = $client->mpts(type => $mpts->type);
$mpt5 = shift @mpts;
isa_ok($mpt5, "Crashplan::Client::Computer", 'mpts(type => ...)');
@mpts = $client->mpts(volumeLabel => $mpts->volumeLabel);
$mpt5 = shift @mpts;
isa_ok($mpt5, "Crashplan::Client::Computer", 'mpts(volumeLabel => ...)');
@mpts = $client->mpts(note => $mpts->note);
$mpt5 = shift @mpts;
isa_ok($mpt5, "Crashplan::Client::Computer", 'mpts(note => ...)');
eval {@mpts = $client->mpts(illegal => 3); };
ok($@, "Exception raised with illegal filter");

