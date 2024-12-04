package AoC::Solution::Day4;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    my $input = $self->input;

    for (my $y = 0; $y < @$input; $y++) {
        my $row = $input->[$y];
        for (my $x = 0; $x < @$row; $x++) {
            $total += $self->_matches_xmas($x, $y);
        }
    }

    return $total;
}

sub _matches_xmas {
    my ($self, $x, $y) = @_;

    my $total = 0;
    for (my $dy = -1; $dy <= 1; $dy++) {
        for (my $dx = -1; $dx <= 1; $dx++) {
            next if $dx == 0 && $dy == 0;
            my @chars = map {
                $self->_get($x + $dx * $_, $y + $dy * $_)
            } 0..3;
            $total++ if join('', @chars) eq 'XMAS';
        }
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    my $input = $self->input;

    for (my $y = 0; $y < @$input; $y++) {
        my $row = $input->[$y];
        for (my $x = 0; $x < @$row; $x++) {
            $total += $self->_matches_x_mas($x, $y);
        }
    }

    return $total;
}

sub _matches_x_mas {
    my ($self, $x, $y) = @_;

    return 0 unless $self->_get($x, $y) eq 'A';

    my $matches = ($self->_get($x-1, $y-1) . $self->_get($x+1, $y+1)) =~ /MS|SM/
        && ($self->_get($x-1, $y+1) . $self->_get($x+1, $y-1)) =~ /MS|SM/;

    return $matches ? 1 : 0;
}

sub _get {
    my ($self, $x, $y) = @_;

    return '.' if $x < 0 || $y < 0;

    return $self->input->[$y]->[$x] || '.';
}

sub _parse_input {
    my $self = shift;

    return [
        map { [ split //, $_ ] } split /\n/, $self->input
    ];
}

1;
