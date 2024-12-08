package AoC::Solution::Day8;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my %antinodes;

    foreach my $freq (values %{ $self->input->{antennas} }) {
        %antinodes = (
            %antinodes,
            %{ $self->_find_antinodes($freq) },
        );
    }

    return scalar keys %antinodes;
}

sub part_2 {
    my $self = shift;

    my %antinodes;

    foreach my $freq (values %{ $self->input->{antennas} }) {
        %antinodes = (
            %antinodes,
            %{ $self->_find_antinodes($freq, 1) },
        );
    }

    return scalar keys %antinodes;
}

sub _find_antinodes {
    my ($self, $antennas, $harmonics) = @_;

    my %antinodes;
    for (my $idx_a = 0; $idx_a < @$antennas; $idx_a++) {
        my $a = $antennas->[$idx_a];
        for (my $idx_b = 0; $idx_b < @$antennas; $idx_b++) {
            next if $idx_a == $idx_b;
            my $b = $antennas->[$idx_b];
            my $vec = {
                x => $b->{x} - $a->{x},
                y => $b->{y} - $a->{y},
            };
            if ($harmonics) {
                my $antinode = {
                    x => $a->{x} + $vec->{x},
                    y => $a->{y} + $vec->{y},
                };
                $antinodes{join(",", $antinode->{x}, $antinode->{y})} = 1 if $self->_is_on_grid($antinode);
                while (1) {
                    $antinode = {
                        x => $antinode->{x} + $vec->{x},
                        y => $antinode->{y} + $vec->{y},
                    };
                    last unless $self->_is_on_grid($antinode);
                    $antinodes{join(',', $antinode->{x}, $antinode->{y})} = 1;
                }
            }
            else {
                my $antinode = {
                    x => $a->{x} + $vec->{x} * 2,
                    y => $a->{y} + $vec->{y} * 2,
                };
                $antinodes{join(",", $antinode->{x}, $antinode->{y})} = 1 if $self->_is_on_grid($antinode);
            }
        }
    }

    return \%antinodes;
}

sub _is_on_grid {
    my ($self, $point) = @_;

    return $point->{x} >= 0
        && $point->{x} < $self->input->{width}
        && $point->{y} >= 0
        && $point->{y} < $self->input->{height};
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
