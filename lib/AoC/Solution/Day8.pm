package AoC::Solution::Day8;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return $self->_unique_antinodes;
}

sub part_2 {
    my $self = shift;

    return $self->_unique_antinodes(1);
}

sub _unique_antinodes {
    my ($self, $harmonics) = @_;

    my %antinodes;

    foreach my $freq (values %{ $self->input->{antennas} }) {
        %antinodes = (
            %antinodes,
            %{ $self->_find_antinodes($freq, $harmonics) },
        );
    }

    return scalar keys %antinodes;
}

sub _find_antinodes {
    my ($self, $antennas, $harmonics) = @_;

    my %antinodes;
    foreach my $pair (@{ $self->_pairs($antennas) }) {
        my ($a, $b) = @$pair;
        my $vec = {
            x => $b->{x} - $a->{x},
            y => $b->{y} - $a->{y},
        };
        my $antinode = {
            x => $a->{x} + $vec->{x} * ($harmonics ? 1 : 2),
            y => $a->{y} + $vec->{y} * ($harmonics ? 1 : 2),
        };
        while ($self->_is_on_grid($antinode)) {
            $antinodes{$self->_key($antinode)} = 1;
            $antinode = {
                x => $antinode->{x} + $vec->{x},
                y => $antinode->{y} + $vec->{y},
            };
            last unless $harmonics;
        }
    }

    return \%antinodes;
}

sub _pairs {
    my ($self, $arr) = @_;

    my @pairs;
    for (my $idx_a = 0; $idx_a < @$arr; $idx_a++) {
        for (my $idx_b = 0; $idx_b < @$arr; $idx_b++) {
            push @pairs, [$arr->[$idx_a], $arr->[$idx_b]] unless $idx_a == $idx_b;
        }
    }

    return \@pairs;
}

sub _is_on_grid {
    my ($self, $point) = @_;

    return $point->{x} >= 0
        && $point->{x} < $self->input->{width}
        && $point->{y} >= 0
        && $point->{y} < $self->input->{height};
}

sub _key {
    my ($self, $point) = @_;

    return join(',', $point->{x}, $point->{y});
}

sub _parse_input {
    my $self = shift;

    my %input;

    my ($x, $y) = (0, 0);
    foreach my $row (split /\n/, $self->input) {
        $x = 0;
        foreach my $col (split //, $row) {
            if ($col =~ /[a-z0-9]/i) {
                push @{ $input{antennas}->{$col} }, { x => $x,  y => $y };
            }
            $x++;
        }
        $y++;
    }

    $input{width}  = $x;
    $input{height} = $y;

    return \%input;
}

1;
