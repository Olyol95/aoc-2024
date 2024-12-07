package AoC::Solution::Day7;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $equation (@{ $self->input }) {
        my @operands = @{ $equation->{operands} };
        if ($self->_can_satisfy_part_1(shift @operands, $equation->{target}, @operands)) {
            $total += $equation->{target};
        }
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $equation (@{ $self->input }) {
        my @operands = @{ $equation->{operands} };
        if ($self->_can_satisfy_part_2(shift @operands, $equation->{target}, @operands)) {
            $total += $equation->{target};
        }
    }

    return $total;
}

sub _can_satisfy_part_1 {
    my ($self, $acc, $target, @operands) = @_;

    unless (@operands) {
        return $acc == $target;
    }

    my $value = shift @operands;

    return $self->_can_satisfy_part_1($acc + $value, $target, @operands)
        || $self->_can_satisfy_part_1($acc * $value, $target, @operands);
}

sub _can_satisfy_part_2 {
    my ($self, $acc, $target, @operands) = @_;

    unless (@operands) {
        return $acc == $target;
    }

    my $value = shift @operands;

    return $self->_can_satisfy_part_2($acc + $value, $target, @operands)
        || $self->_can_satisfy_part_2($acc * $value, $target, @operands)
        || $self->_can_satisfy_part_2($acc . $value, $target, @operands);
}

sub _parse_input {
    my $self = shift;

    my @equations;
    foreach my $line (split /\n/, $self->input) {
        next unless $line =~ /(\d+): (.+)/;
        push @equations, {
            target   => $1,
            operands => [ split /\s+/, $2 ],
        };
    }

    return \@equations;
}

1;
