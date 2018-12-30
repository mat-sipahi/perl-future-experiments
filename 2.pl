use feature qw(say);
use Future;

my $future = Future->new;
$future->on_done(sub { say @_;});

say $future->state;

$future->done("--DONE--");

say $future->state;
