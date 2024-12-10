package AoC::Solution::Day10;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $input = $self->input;

    my $total = 0;
    for (my $y = 0; $y < $input->{height}; $y++) {
        for (my $x = 0; $x < $input->{width}; $x++) {
            next unless $self->_get($x, $y) == 0;
            $total += $self->_traverse($x, $y, {});
        }
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $input = $self->input;

    my $total = 0;
    for (my $y = 0; $y < $input->{height}; $y++) {
        for (my $x = 0; $x < $input->{width}; $x++) {
            next unless $self->_get($x, $y) == 0;
            $total += $self->_traverse($x, $y);
        }
    }

    return $total;
}

sub _traverse {
    my ($self, $x, $y, $seen) = @_;

    my $value = $self->_get($x, $y);
    if ($value == 9 && $seen) {
        return 0 if $seen->{"$x,$y"};
        $seen->{"$x,$y"} = 1;
        return 1;
    }
    elsif ($value == 9) {
        return 1;
    }

    my @dirs = (
        [$x, $y + 1],
        [$x + 1, $y],
        [$x, $y - 1],
        [$x - 1, $y],
    );

    my $total = 0;
    foreach my $dir (@dirs) {
        next unless $self->_on_map(@$dir);
        next unless $self->_get(@$dir) == $value + 1;
        $total += $self->_traverse(@$dir, $seen);
    }

    return $total;
}

sub _on_map {
    my ($self, $x, $y) = @_;

    return $x >= 0
        && $x < $self->input->{width}
        && $y >= 0
        && $y < $self->input->{height};
}

sub _get {
    my ($self, $x, $y) = @_;

    return $self->input->{map}->[$y]->[$x];
}

sub _parse_input {
    my $self = shift;

    my @map;
    my ($y, $x) = (0, 0);
    foreach my $row (split /\n/, $self->input) {
        $x = 0;
        my @row_items;
        foreach my $col (split //, $row) {
            push @row_items, $col;
            $x++;
        }
        push @map, \@row_items;
        $y++;
    }

    return {
        map    => \@map,
        width  => $x,
        height => $y,
    };
}

1;
