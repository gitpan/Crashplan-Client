#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Crashplan::Client;

plan tests => 21;

my $client = Crashplan::Client->new();
isa_ok($client, 'Crashplan::Client');

open FIN, "t/responses/serverstats.cp" or die "Missing response file for ServerStatistics";
my $response = do { local $/;  <FIN> };
close FIN;

# TODO : find another way to avoid this ugly thing
#        to test without server
my $sstat =$client->parse_response($response);

# Check that attribute where properly parsed and 
#  are returned as expected
#is($sstat->currentArchiveBytes,'22850920612');
is($sstat->previousMonthArchiveBytes,'12956463128');
is($sstat->orgCount,'6');
is($sstat->seatCount,'10');
is($sstat->version,'3.8.2010');
is($sstat->backupSessionCount,'0');
is($sstat->connectedClientCount,'3');
is($sstat->hostName,'backup01.mynetwork.net');
is($sstat->hostPort,'4282');
#is($sstat->hostAddresses,["85.31.196.96"]);
is($sstat->hostMemoryTotal,'3.9 GB');
is($sstat->hostMemoryFree,'204.2 MB');
is($sstat->hostMemoryCached,'3.0 GB');
is($sstat->engineMemoryTotal,'250.6 MB');
is($sstat->engineMemoryFree,'18.0 MB');
is($sstat->cpuUtilization,'0%');
is($sstat->uptime,'32.8 days');
is($sstat->uptimeMilliseconds,'1307011529412');
is($sstat->load,'0.00, 0.00, 0.00');
is($sstat->diskTotal,'9.9 GB');
is($sstat->diskFree,'9.2 GB');
is($sstat->diskUtilization,'8%');
