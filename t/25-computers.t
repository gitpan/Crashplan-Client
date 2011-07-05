#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Crashplan::Client;

plan tests => 219;

my $client = Crashplan::Client->new();
isa_ok($client, 'Crashplan::Client');

open FIN, "t/responses/computers.cp" or die "Missing response file for Computers";
my $response = do { local $/;  <FIN> };
close FIN;

# TODO : find another way to avoid this ugly thing
#        to test without server
my @computers =$client->parse_response($response);

# Check for lowlevel API methods availability
for my $computer (@computers) {
    isa_ok ($computer, "Crashplan::Client::Computer");
    can_ok ($computer, "id");
    can_ok ($computer, "name");
    can_ok ($computer, "guid");
    can_ok ($computer, "status");
    can_ok ($computer, "alertStates");
    can_ok ($computer, "userId");
    can_ok ($computer, "mountPointId");
    #
    can_ok ($computer, "osName");
    can_ok ($computer, "osVersion");
    can_ok ($computer, "osArch");
    can_ok ($computer, "remoteAddress");
    can_ok ($computer, "javaVersion");
    can_ok ($computer, "timeZone");
    can_ok ($computer, "version");
    can_ok ($computer, "serverBackupStatsNumberSelected");
    can_ok ($computer, "serverBackupStatsSelectedBytes");
    can_ok ($computer, "serverBackupStatsPercentComplete");
    can_ok ($computer, "serverBackupStatsArchiveBytes");
    can_ok ($computer, "serverBackupStatsCompressionRate");
    can_ok ($computer, "serverBackupStatsConnected");
}

# Check that attribute where properly parsed and 
#  are returned as expected
for my $computer (@computers) {
    next unless $computer->id == 12;

    is($computer->name,'hebergement.doe.fr');
    is($computer->guid,'480918579244378245');
    is($computer->status,'Active');
    is_deeply($computer->alertStates,['CriticalConnectionAlert']);
    is($computer->userId,'6');
    is($computer->mountPointId,'1');
    is($computer->creationDate,'2011-06-07T00:46:05.815+02:00');
    is($computer->modificationDate,'2011-06-22T01:00:05.129+02:00');
}
