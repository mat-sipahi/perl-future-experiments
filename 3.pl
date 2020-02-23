 use feature qw(say);
use Future;
use Data::Dumper;
use IO::Async::Loop;

my $loop = IO::Async::Loop->new;

sub print_and_continue {
        my ($i, $title, $num) = @_;
        
        return Future->done("FINISHED: $title") if $i > $num;
        
        say "$title - $i";    
        return $loop->delay_future( after => 1 )->then( sub { print_and_continue($i + 1, $title, $num)} );
};

sub count{
    my ($title, $num) = @_;
    return Future->fail("$num Too small") if $num < 1;

    return print_and_continue(1, $title, $num);
}

say count('COUNT ZERO', 0)
            #->on_fail(sub {say "Error Caught: ".shift; })->get;
            #->else(sub {say "Error Caught: ".shift; })->block_until_ready;
            ->else(sub {say "Error Caught: ".shift; return Future->done('DONE WITH ERROR') })->get;

#say count('COUNT FIVE', 5)
    #->on_done( sub {say 'DONE' })
#    ->get;

say ' ------ wait all --------';
#Future->wait_all(count('PARALLEL ZERO', 0), count('PARALLEL FIVE', 5), count('PARALLEL TEN', 1))
#    ->on_done(sub { say 'wait_all done with:'; say $_->is_done? "One done with:". $_->get: "One failed with:".$_->failure for @_ } )->get;

say ' ------ wait any --------';
#Future->wait_any(count('PARALLEL ZERO', 3), count('PARALLEL FIVE', 5), count('PARALLEL TEN', 1))
#    ->on_done(sub { say $_ for  } )->get;
    
say ' ------ needs all --------';
#Future->needs_all(count('PARALLEL ZERO', 1), count('PARALLEL FIVE', 5), count('PARALLEL TEN', 1))
#    ->on_done(sub { say 'needs_all done with:'; say $_ for @_ } )
#    ->on_fail(sub {say "needs_all failed with: ".shift } )
#    ->block_until_ready;

say ' ------ needs any --------';
#Future->needs_any(count('PARALLEL ZERO', 0), count('PARALLEL FIVE', 5), count('PARALLEL TEN', 1))
#    ->on_done(sub { say 'needs_any done with:'. shift } )
#    ->on_fail(sub {say "needs_any failed with: ".shift } )
#    ->block_until_ready;

say ' ---------- timeout ---------';
#my $future = Future->wait_all(count('PARALLEL ZERO', 0), count('PARALLEL FIVE', 5), count('PARALLEL TEN', 1))
#   ->on_done(sub { say 'wait_all done with:'; say $_->is_done? "One done with:". $_->get: "One failed with:".$_->failure for @_ } );

#say Future->wait_any($future, $loop->timeout_future(after => 3))
#    ->else(sub { return Future->done("FAILED WTIH: ".shift) })
#    ->get;
