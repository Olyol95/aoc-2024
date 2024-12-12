package AoC::Solution::Day12::Node;

use v5.36;
use strictures 2;

use Moo;

has x => (
    is       => 'ro',
    required => 1,
);

has y => (
    is       => 'ro',
    required => 1,
);

has neighbours => (
    is      => 'rw',
    default => 0,
);

sub perimeter {
    my $self = shift;

    return 4 - $self->neighbours;
}

1;
