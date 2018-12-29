use feature qw(say);
use Future;
use Data::Dumper;

$future = Future->new->on_done(sub { say "Done @_"});
say 'created';
sleep(1);
$future->done("MESSAGE");
