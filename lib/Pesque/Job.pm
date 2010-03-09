package Pesque::Job;

use Moose;
use lib qw( lib );
use JSON;
use Data::Dumper;

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

sub reserve {
  my $class = shift;
  my $queue = shift;

  my $payload_json = Pesque::pop( $queue );
  if( $payload_json ) {
    my $payload = JSON::from_json( $payload_json );

    $class->new(
      payload_class => $payload->{ class },
      args          => $payload->{ args }
    );
  } else {
    undef;
  }

}


1;

