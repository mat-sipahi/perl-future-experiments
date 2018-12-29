 use feature qw(say);
use Future;
use Data::Dumper;

$future = Future->call(sub {say 1; sleep 2; say 2; return Future->done;})->on_done(sub {say "Done"; return Future->done;})->retain;
say 'created';


