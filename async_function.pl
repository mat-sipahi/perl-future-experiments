use feature say;

use IO::Async::Function; 
use IO::Async::Loop;
use Future;
use Data::Dumper;

my $loop = IO::Async::Loop->new;
 
my $function = IO::Async::Function->new(
   code => sub {
      my ( $name, $number ) = @_;
      foreach my $n (1..$number){
         say "$name $n";
         sleep 1;
      }
      return "$name Finished";
   },
);
 
$loop->add( $function );
 
my $future1 = $function->call(
   args => ['FIRST', 3 ],
);

my $future2 = $function->call(
   args => ['SECOND', 5 ],
);

say 'Futures Created';

my $combined_future = Future->wait_all($future1, $future2)->then(sub { 
                                          for (@_) { say $_->{result}->[0]; }; 
                                          return Future->done('Both Finished.');
                                       });

say 'Fututes Combined';

say $combined_future->get;
