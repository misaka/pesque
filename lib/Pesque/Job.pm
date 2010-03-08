package Pesque::Job;

use Moose;

has 'payload_class' => ( is => 'ro', isa => 'Str' );
has 'args' => ( is => 'ro', isa => 'ArrayRef' );

sub enqueue {
  my $self = shift;
  my $queue = shift;

  my $payload = JSON::to_json( {
    class => $self->payload_class,
    args  => $self->args
  } );
  Pesque::push( $queue, $payload );
}


1;

