#!perl -T

use Test::More tests => 1;

BEGIN {
use_ok( 'Crashplan::Client' ) || print "Bail out! ";
}

diag( "Testing Crashplan::Client $Crashplan::Client::VERSION, Perl $], $^X" );

