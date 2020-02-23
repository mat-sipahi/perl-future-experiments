use feature qw(say);
use Future;
use Data::Dumper;
use IO::Async::Loop;
use Future::AsyncAwait;

my $loop = IO::Async::Loop->new;

async sub print_and_continue {
        my ($i, $title, $num) = @_;
        
        return "FINISHED: $title" if $i > $num;
        
        say "$title - $i";    
        await $loop->delay_future( after => 1 );
        await print_and_continue($i + 1, $title, $num);
};

async sub count{
    my ($title, $num) = @_;
    die "$num Too small" if $num < 1;

    await print_and_continue(1, $title, $num);
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
