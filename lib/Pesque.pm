
package Pesque;

use Pesque::Job;

sub enqueue {
  my $job_class = shift;
  my @args = @_;

  print Dumper \@args;

  my $job = Pesque::Job->new(
    payload_class => ref( $job_class ),
    args => \@args
  );

  print Dumper $job;

  $job->enqueue( $job_class->queue );
}

sub push {
  my $queue = shift;
  my $payload = shift;

  my $redis = Redis->new;

  # TODO: Can we abstract how we get the name of the queue here?
  #       The Ruby library provides a handy way invoke a namespace.
  $redis->rpush( "resque:queue:$queue", $payload );

}

1;

