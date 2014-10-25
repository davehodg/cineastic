use strict;
use warnings;

use Cineastic;

my $app = Cineastic->apply_default_middlewares(Cineastic->psgi_app);
$app;

