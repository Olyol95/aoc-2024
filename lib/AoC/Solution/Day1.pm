package AoC::Solution::Day1;

use v5.36;
use strictures 2;

use List::Util qw(min);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my %pairs = (
        left  => [ sort { $a <=> $b } @{ $self->input->{left} } ],
        right => [ sort { $a <=> $b } @{ $self->input->{right} } ],
    );

    my $total = 0;
    my $len = min(
        scalar @{ $pairs{left} },
        scalar @{ $pairs{right} },
    );
    for (my $idx = 0; $idx < $len; $idx++) {
        $total += abs($pairs{left}->[$idx] - $pairs{right}->[$idx]);
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my %counts;
    foreach my $value (@{ $self->input->{right} }) {
        $counts{$value}++;
    }

    my $total = 0;
    foreach my $value (@{ $self->input->{left} }) {
        $total += $value * ($counts{$value} || 0);
    }

    return $total;
}

sub _parse_input {
    my $self = shift;

    my %lists;
    foreach my $line (split /\n/, $self->input) {
        my ($left, $right) = $line =~ /(\d+)\s+(\d+)/;
        push @{ $lists{left} }, $left;
        push @{ $lists{right} }, $right;
    }

    return \%lists;
}

1;
