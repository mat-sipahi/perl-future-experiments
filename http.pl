use feature say;
use Future;
use IO::Async::Loop;
use Net::Async::HTTP;
use URI;

my $loop = IO::Async::Loop->new();
   
  my $http = Net::Async::HTTP->new();
   
  $loop->add( $http );

sub http_request{ 
  $http->do_request(
     uri => URI->new( "http://www.metacpan.org/" ),
    )->then(sub { say 'CPAN received'; sleep 1; return Future->done; })->retain;
}

http_request();

say 'Requested';

say 'Bye';
