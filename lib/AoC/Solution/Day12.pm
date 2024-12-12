package AoC::Solution::Day12;

use v5.36;
use strictures 2;

use List::Util qw(sum);
use Moo;

use AoC::Solution::Day12::Node;

with 'AoC::Solution';

no warnings 'recursion';

has height => (
    is      => 'lazy',
    default => sub {
        my $self = shift;
        return scalar @{ $self->input };
    },
);

has width => (
    is      => 'lazy',
    default => sub {
        my $self = shift;
        return scalar @{ $self->input->[0] };
    },
);

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $region (@{ $self->_get_regions }) {
        my $area = scalar @$region;
        my $perimeter = sum map { $_->perimeter } @$region;
        $total += $area * $perimeter;
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    foreach my $region (@{ $self->_get_regions }) {
        my $area = scalar @$region;
        my $perimeter = sum map { $self->_corners($_) } @$region;
        $total += $area * $perimeter;
    }

    return $total;
}

sub _corners {
    my ($self, $field) = @_;

    my ($x, $y) = ($field->x, $field->y);

    my $value = $self->_get($field->x, $field->y);

    my $n  = $self->_get($x, $y - 1);
    my $ne = $self->_get($x + 1, $y - 1);
    my $e  = $self->_get($x + 1, $y);
    my $se = $self->_get($x + 1, $y + 1);
    my $s  = $self->_get($x, $y + 1);
    my $sw = $self->_get($x - 1, $y + 1);
    my $w  = $self->_get($x - 1, $y);
    my $nw = $self->_get($x - 1, $y - 1);

    return ($n ne $value && $e ne $value ? 1 : 0)
        +  ($e ne $value && $s ne $value ? 1 : 0)
        +  ($s ne $value && $w ne $value ? 1 : 0)
        +  ($w ne $value && $n ne $value ? 1 : 0)
        +  ($n eq $value && $e eq $value && $ne ne $value ? 1 : 0)
        +  ($s eq $value && $e eq $value && $se ne $value ? 1 : 0)
        +  ($s eq $value && $w eq $value && $sw ne $value ? 1 : 0)
        +  ($n eq $value && $w eq $value && $nw ne $value ? 1 : 0);
}

sub _get_regions {
    my $self = shift;

    my %seen;
    my @regions;
    for (my $y = 0; $y < $self->height; $y++) {
        for (my $x = 0; $x < $self->width; $x++) {
            my $value = $self->_get($x, $y);
            next if $seen{"$x,$y"};
            my $region = $self->_region($x, $y, {});
            $seen{join(",", $_->x, $_->y)} = 1 foreach @$region;
            push @regions, $region;
        }
    }

    return \@regions;
}

sub _region {
    my ($self, $x, $y, $seen) = @_;

    return [] if $seen->{"$x,$y"};
    $seen->{"$x,$y"} = 1;

    my @dirs = (
        [0, -1],
        [1, 0],
        [0, 1],
        [-1, 0], 
    );
    my $value = $self->_get($x, $y);

    my @region;
    my $neighbours = 0;
    foreach my $dir (@dirs) {
        my $dx = $x + $dir->[0];
        my $dy = $y + $dir->[1];
        next unless $self->_is_on_map($dx, $dy);
        if ($self->_get($dx, $dy) eq $value) {
            $neighbours++;
            push @region, @{ $self->_region($dx, $dy, $seen) };
        }
    }

    push @region, AoC::Solution::Day12::Node->new(
        x          => $x,
        y          => $y,
        neighbours => $neighbours,
    );

    return \@region;
}

sub _is_on_map {
    my ($self, $x, $y) = @_;

    return $x >= 0
        && $y >= 0
        && $x < $self->width
        && $y < $self->height;
}

sub _get {
    my ($self, $x, $y) = @_;

    return '.' unless $self->_is_on_map($x, $y);

    return $self->input->[$y]->[$x];
}

sub _parse_input {
    my $self = shift;

    return [
        map { [ split //, $_ ] } split /\n/, $self->input
    ];
}

1;
