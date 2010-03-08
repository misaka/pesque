package Pesque::Job;

use Moose;

has 'payload_class' => ( is => 'ro', isa => 'Str' );
has 'args' => ( is => 'ro', isa => 'ArrayRef' );


1;

