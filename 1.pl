use feature qw(say);
use Future;

my $future = Future->new;
$future->on_done(sub { say @_;});

say 'created';
sleep(1);

$future->done("DONE");



$future = Future->new;
$future->on_fail(sub { say @_;});

say 'created';
sleep(1);

$future->fail("FAILED");