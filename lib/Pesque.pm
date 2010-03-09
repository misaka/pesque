
package Pesque;

use Pesque::Job;

use Data::Dumper;

sub enqueue {
  my $job_class = shift;
  my @args = @_;

  my $job = Pesque::Job->new(
    payload_class => $job_class,
    args          => \@args
  );

  $job->enqueue( $job_class->queue );
}

sub reserve {
  my $queue = shift;

  Pesque::Job->reserve( $queue );
}

sub push {
  my $queue = shift;
  my $payload = shift;

  # TODO: Abstract the queue out so that we don't create a new connection
  #       every time we run push or pop.
  my $redis = Redis->new;

  # TODO: Can we abstract how we get the name of the queue here?
  #       The Ruby library provides a handy way invoke a namespace.
  $redis->rpush( "resque:queue:$queue", $payload );
}

sub pop {
  my $queue = shift;

  my $redis = Redis->new;
  $redis->lpop( "resque:queue:$queue" );
}

1;

