use strict;
use warnings;
use ExtUtils::MakeMaker;

WriteMakefile(
    NAME                => 'Crashplan::Client',
    AUTHOR              => q{Arnaud (Arhuman) ASSAD <arnaud.assad@jaguar-network.com>},
    VERSION_FROM        => 'lib/Crashplan/Client.pm',
    ABSTRACT_FROM       => 'lib/Crashplan/Client.pm',
    ($ExtUtils::MakeMaker::VERSION >= 6.3002
      ? ('LICENSE'=> 'perl')
      : ()),
    PL_FILES            => {},
    PREREQ_PM => {
        'Carp'          => 0,
        'JSON'          => 0,
        'MIME::Base64'  => 0,
        'REST::Client'  => 0,
        'Test::More'    => 0,
    },
    dist                => { COMPRESS => 'gzip -9f', SUFFIX => 'gz', },
    clean               => { FILES => 'Crashplan-Client-*' },
);
