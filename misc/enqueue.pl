#!/usr/bin/env perl

use Redis;
use JSON;

use lib qw( lib );

use Pesque;

Pesque::enqueue( 'MOHandler', {
  msisdn => '447760208493',
  body => 'Heya'
} );

package MOHandler;

use Moose;

sub queue {
  'mos'
}




