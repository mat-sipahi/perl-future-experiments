 use feature qw(say);
use Future;
use Data::Dumper;

sub count{
    my $num = shift;
    say "Counting to $num";
    die 'Too small' if ($num < 1);
    die 'Too large' if ($num > 10);
    for my $i (1..$num){
        sleep 1;
        say $i;
    }
}

my $future = Future->call( sub{ return Future->done(3)})
                ->then(sub {count(shift); return Future->done(2)})
                ->then(sub {count(shift); return Future->done});
say 'Created';
$future->get;


