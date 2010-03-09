
package Pesque;

use Pesque::Job;

use vars qw( $redis );

use Data::Dumper;

sub redis {
  return $redis if( $redis );

  connect_to_redis( "localhost:6379" );
}

sub connect_to_redis {
  my( $server ) = shift;

  if( ref( $server) && $server->isa( 'Redis' ) ) {
    $redis = $server;
  } elsif( $server =~ m/^([a-z0-9-]+):(\d+)$/ ) {
    my $host = $1;
    my $port = $2;

    $redis = Redis->new(
      host => $host,
      port => $port
    );
  } else {
    die( "Can't connect/use Redis connection: $redis" );
  }
  $redis;
}

sub enqueue {
  my $job_class = shift;
  my @args = @_;


  my $job = Pesque::Job->new(
    payload_class => $job_class,
    args          => \@args
  );

  $job->create( $job_class->queue );
}

sub reserve {
  my $queue = shift;

  Pesque::Job->reserve( $queue );
}

sub push {
  my $queue = shift;
  my $payload = shift;

  my $redis = redis();

  # TODO: Can we abstract how we get the name of the queue here?
  #       The Ruby library provides a handy way invoke a namespace.
  $redis->rpush( "resque:queue:$queue", $payload );
}

sub pop {
  my $queue = shift;

  my $redis = redis();
  $redis->lpop( "resque:queue:$queue" );
}

1;

