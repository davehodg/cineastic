use strict;
use warnings;
use Test::More;


use Catalyst::Test 'Catalyst::DotCloud';
use Catalyst::DotCloud::Controller::Site;

ok( request('/site')->is_success, 'Request should succeed' );
done_testing();
