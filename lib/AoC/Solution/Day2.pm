package AoC::Solution::Day2;

use v5.36;
use warnings;

use List::Util qw(max sum);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    return sum map {
        $self->_is_safe($_)
    } @{ $self->input };
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $report (@{ $self->input }) {
        if ($self->_is_safe($report, 1)) {
            $total++;
        }
        else {
            $total++ if sum map {
                $self->_is_safe($_)
            } @{ $self->_perms($report) };
        }
    }

    return $total;
}

sub _is_safe {
    my ($self, $report) = @_;

    my $prev_diff;
    for (my $idx = 1; $idx < @$report; $idx++) {
        my $diff = $report->[$idx - 1] - $report->[$idx];
        return unless $self->_within_range($diff, 1, 3)
            && $self->_same_sign($diff, $prev_diff);
        $prev_diff = $diff;
    }

    return 1;
}

sub _perms {
    my ($self, $report) = @_;

    my @perms;
    for (my $idx = 0; $idx < @$report; $idx++) {
        my @perm = @$report;
        splice(@perm, $idx, 1);
        push @perms, \@perm;
    }

    return \@perms;
}

sub _within_range {
    my ($self, $diff, $min, $max) = @_;

    return abs($diff) >= $min
        && abs($diff) <= $max;
}

sub _same_sign {
    my ($self, $diff, $prev_diff) = @_;

    return 1 unless defined $prev_diff;

    return $self->_is_positive($diff) == $self->_is_positive($prev_diff);
}

sub _is_positive {
    my ($self, $value) = @_;

    return $value >= 0;
}

sub _parse_input {
    my $self = shift;

    return [
        map { [ split /\s+/, $_ ] } split /\n/, $self->input
    ];
}

1;
