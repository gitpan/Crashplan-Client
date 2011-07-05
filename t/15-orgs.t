#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Crashplan::Client;

plan tests => 122;

my $client = Crashplan::Client->new();
isa_ok($client, 'Crashplan::Client');

open FIN, "t/responses/orgs.cp" or die "Missing response file for Orgs";
my $response = do { local $/;  <FIN> };
close FIN;

# TODO : find another way to avoid this ugly thing
#        to test without server
my @orgs =$client->parse_response($response);

# Check for lowlevel API methods availability
for my $org (@orgs) {
    isa_ok ($org, "Crashplan::Client::Org");
    can_ok ($org, "status");
    can_ok ($org, "name");
    can_ok ($org, "parentId");
    can_ok ($org, "registrationKey");
    can_ok ($org, "masterGuid");
    can_ok ($org, "id");
    can_ok ($org, "creationDate");
    can_ok ($org, "modificationDate");
    #
    can_ok ($org, "archiveBytesDelta");
    can_ok ($org, "archiveBytesDeltaMonth");
    can_ok ($org, "quotaBytes");
    can_ok ($org, "dailyChange");
    can_ok ($org, "selectedBytes");
    can_ok ($org, "todoFiles");
    can_ok ($org, "quotaSeats");
    can_ok ($org, "archiveBytes");
    can_ok ($org, "selectedFiles");
    can_ok ($org, "todoBytes");
}

# Check that attribute where properly parsed and 
#  are returned as expected
for my $org (@orgs) {
    next unless $org->id == 3;

    is($org->name,'Jaguar Network');
    is($org->status,'Active');
    is($org->parentId,undef);
    is($org->masterGuid,undef);
    is($org->registrationKey,'2P4R-P99H-C729-SRHT');
    is($org->creationDate,'2011-05-27T18:11:16.932+02:00');
    is($org->modificationDate,'2011-07-02T18:56:41.567+02:00');
}
