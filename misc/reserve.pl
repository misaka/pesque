#!/usr/bin/env perl

use Redis;
use JSON;
use Data::Dumper;

use lib qw( lib );

use Pesque::Job;


sub reserve {
  my $queue_name = shift;

  my $redis = Redis->new;

  my $payload_json = $redis->lpop(
    "resque:queue:$queue_name"
  );
  print Dumper( $payload_json );

  my $payload = jsonToObj( $payload_json );
  print Dumper( $payload );

  Pesque::Job->new(
    payload_class => $payload->{ class },
    args => $payload->{ args }
  );
}

$job = reserve( 'mos' );
print Dumper $job;
