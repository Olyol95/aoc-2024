package AoC::Solution::Day5;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $update (@{ $self->input->{updates} }) {
        my @sorted = sort { $self->_compare($a, $b) } @$update;
        if ($self->_is_equal($update, \@sorted)) {
            $total += $sorted[scalar @sorted / 2];
        }
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $update (@{ $self->input->{updates} }) {
        my @sorted = sort { $self->_compare($a, $b) } @$update;
        unless ($self->_is_equal($update, \@sorted)) {
            $total += $sorted[scalar @sorted / 2];
        }
    }

    return $total;
}

sub _is_equal {
    my ($self, $a, $b) = @_;

    return if scalar @$a != scalar @$b;

    for (my $idx = 0; $idx < @$a; $idx++) {
        return if $a->[$idx] != $b->[$idx];
    }

    return 1;
}

sub _compare {
    my ($self, $a, $b) = @_;

    my $rules = $self->input->{rules};

    foreach my $val (@{ $rules->{$a} }) {
        return -1 if $val == $b;
    }
    foreach my $val (@{ $rules->{$b} }) {
        return 1 if $val == $a;
    }
    return 0;
}

sub _parse_input {
    my $self = shift;

    my %input;
    my ($rules, $updates) = split /\n\n/, $self->input;

    foreach my $rule (split /\n/, $rules) {
        my ($left, $right) = split /[|]/, $rule;
        push @{ $input{rules}->{$left} }, $right;
    }

    $input{updates} = [ map { [ split /,/, $_ ] } split /\n/, $updates ];

    return \%input;
}

1;
