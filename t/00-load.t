#!perl 

use Test::More;

BEGIN { use_ok('MongoDB' ); }
BEGIN { use_ok( 'Dancer::Plugin::Mongo' ); }

diag( "Testing Dancer::Plugin::Mongo $Dancer::Plugin::Mongo::VERSION, Perl $], $^X" );

done_testing;
