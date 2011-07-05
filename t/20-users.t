#!/usr/bin/perl

use strict;
use warnings;

use Test::More;
use Crashplan::Client;

plan tests => 134;

my $client = Crashplan::Client->new();
isa_ok($client, 'Crashplan::Client');

open FIN, "t/responses/users.cp" or die "Missing response file for Users";
my $response = do { local $/;  <FIN> };
close FIN;

# TODO : find another way to avoid this ugly thing
#        to test without server
my @users =$client->parse_response($response);

# Check for lowlevel API methods availability
for my $user (@users) {
    isa_ok ($user, "Crashplan::Client::User");
    can_ok ($user, "id");
    can_ok ($user, "status");
    can_ok ($user, "email");
    can_ok ($user, "firstName");
    can_ok ($user, "lastName");
    can_ok ($user, "orgId");
    can_ok ($user, "creationDate");
    can_ok ($user, "modificationDate");
    #
    can_ok ($user, "selectedFiles");
    can_ok ($user, "selectedBytes");
    can_ok ($user, "todoFiles");
    can_ok ($user, "todoBytes");
    can_ok ($user, "archiveBytes");
    can_ok ($user, "archiveBytesDelta");
    can_ok ($user, "archiveBytesDeltaMonth");
    can_ok ($user, "dailyChange");
    can_ok ($user, "quotaBytes");
}

# Check that attribute where properly parsed and 
#  are returned as expected
for my $user (@users) {
    next unless $user->id == 4;

    is($user->status,'Active');
#    is($user->username,'kevin@company.com');
    is($user->email,'kevin@company.com');
    is($user->firstName,'Paul');
    is($user->lastName,'Kevin');
    is($user->orgId,'3');
    is($user->creationDate,'2011-05-30T21:16:59.104+02:00');
    is($user->modificationDate,'2011-05-30T21:16:59.106+02:00');
}
