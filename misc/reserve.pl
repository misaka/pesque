#!/usr/bin/env perl

use Redis;
use JSON;
use Data::Dumper;

use lib qw( lib );

use Pesque;
use Pesque::Job;


$job = Pesque::reserve( 'mos' );
print Dumper $job;
