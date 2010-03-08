#!/usr/bin/env perl

use Redis;
use JSON;

sub push {

}

sub enqueue {
  my $target_class = shift;
  my @args_payload = @_;

  my $redis = Redis->new;

  $redis->rpush(
    "resque:queue:mos",
    objToJson( {
      'class' => $target_class,
      'args'  => \@args_payload
    } )
  );
}

enqueue( 'MOHandler', { msisdn => '447760208493', body => 'Heya' } );



