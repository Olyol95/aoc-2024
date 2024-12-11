package AoC::Solution::Day11;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

has _cache => (
    is      => 'ro',
    default => sub { {} },
);

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $stone (@{ $self->input }) {
        $total += $self->_blink($stone, 25);
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $stone (@{ $self->input }) {
        $total += $self->_blink($stone, 75);
    }

    return $total;
}

sub _blink {
    my ($self, $stone, $iters) = @_;

    my $value = $self->_get($stone, $iters);

    unless (defined $value) {
        $value = $self->_set(
            $stone,
            $iters,
            $self->_calculate($stone, $iters)
        );
    }

    return $value;
}

sub _calculate {
    my ($self, $stone, $iters) = @_;

    return 1 if $iters-- == 0;

    if ($stone == 0) {
        return $self->_blink(1, $iters);
    }
    elsif (length($stone) % 2 == 0) {
        my $mid = length($stone) / 2;
        return $self->_blink(int substr($stone, 0, $mid), $iters)
            + $self->_blink(int substr($stone, $mid), $iters);
    }
    else {
        return $self->_blink($stone * 2024, $iters);
    }
}

sub _get {
    my ($self, $stone, $iters) = @_;

    return $self->_cache->{"$stone:$iters"};
}

sub _set {
    my ($self, $stone, $iters, $value) = @_;

    $self->_cache->{"$stone:$iters"} = $value;

    return $value;
}

sub _parse_input {
    my $self = shift;

    return [ split /\s+/, $self->input ];
}

1;
