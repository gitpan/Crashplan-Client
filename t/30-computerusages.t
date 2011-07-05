#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Crashplan::Client;

plan tests => 29;

my $client = Crashplan::Client->new();
isa_ok($client, 'Crashplan::Client');

open FIN, "t/responses/computerusage.cp" or die "Missing response file for ComputerUsage";
my $response = do { local $/;  <FIN> };
close FIN;

# TODO : find another way to avoid this ugly thing
#        to test without server
my @cus =$client->parse_response($response);

# Check for lowlevel API methods availability
for my $cu (@cus) {
    isa_ok ($cu, "Crashplan::Client::ComputerUsage");
    can_ok ($cu, "id");
    can_ok ($cu, "sourceId");
    can_ok ($cu, "sourceGuid");
    can_ok ($cu, "targetId");
    can_ok ($cu, "targetGuid");
    can_ok ($cu, "selectedFiles");
    can_ok ($cu, "selectedBytes");
    can_ok ($cu, "todoFiles");
    can_ok ($cu, "todoBytes");
    can_ok ($cu, "lastActivity");
    can_ok ($cu, "lastConnected");
    can_ok ($cu, "archiveBytes");
    can_ok ($cu, "isUsing");
}

# Check that attribute where properly parsed and 
#  are returned as expected
my $cu = shift @cus;

is($cu->sourceId,'3');
is($cu->sourceGuid,'475378712348066405');
is($cu->targetId,'1');
is($cu->targetGuid,'479433568773194848');
is($cu->selectedFiles,'0');
is($cu->selectedBytes,'0');
is($cu->todoFiles,'0');
is($cu->todoBytes,'0');
is($cu->archiveBytes,'5438726');
is($cu->lastActivity,'2011-07-05T03:00:54.237+02:00');
is($cu->lastConnected,'2011-07-05T02:50:38.464+02:00');
is($cu->isUsing,'1');
is($cu->creationDate,'2011-05-27T18:13:42.562+02:00');
is($cu->modificationDate,'2011-07-05T02:50:38.464+02:00');
