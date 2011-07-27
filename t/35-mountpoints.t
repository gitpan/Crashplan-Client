#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Crashplan::Client;

plan tests => 20;

my $client = Crashplan::Client->new();
isa_ok($client, 'Crashplan::Client');

open FIN, "t/responses/mountpoints.cp" or die "Missing response file for MountPoints";
my $response = do { local $/;  <FIN> };
close FIN;

# TODO : find another way to avoid this ugly thing
#        to test without server
my @mps =$client->parse_response($response);

# Check for lowlevel API methods availability
for my $mp (@mps) {
    isa_ok ($mp, "Crashplan::Client::MountPoint");
    can_ok ($mp, "id");
    can_ok ($mp, "creationDate");
    can_ok ($mp, "modificationDate");
    can_ok ($mp, "name");
    can_ok ($mp, "status");
    can_ok ($mp, "type");
    can_ok ($mp, "volumeLabel");
    can_ok ($mp, "note");
    can_ok ($mp, "bytesPerSecond");
}

# Check that attribute where properly parsed and 
#  are returned as expected
my $mp = shift @mps;

is($mp->id,'1');
is($mp->name,'Default');
is($mp->status,'ENABLED');
is($mp->type,'DIR');
is($mp->volumeLabel,'CrashPlanPROArchive_Default');
is($mp->note,undef);
is($mp->bytesPerSecond,undef);
is($mp->creationDate,'2011-05-27T18:04:35.958+02:00');
is($mp->modificationDate,'2011-05-27T18:04:35.958+02:00');
