package AoC::Solution::Day6;

use v5.36;
use strictures 2;

use Moo;

use AoC::Solution::Day6::Guard;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $guard = AoC::Solution::Day6::Guard->new(
        %{ $self->input->{guard} },
    );

    $self->_run($guard);

    return $guard->unique_locations - 1;
}

sub part_2 {
    my $self = shift;

    my $guard = AoC::Solution::Day6::Guard->new(
        %{ $self->input->{guard} },
    );

    my $positions = 0;
    while ($self->_on_map($guard->location)) {
        while ($self->_is_obstructed($guard->next_location)) {
            $guard->rotate;
        }
        $positions++ if $self->_run($guard->clone, $guard->next_location);
        $guard->move;
    }

    return $positions;
}

sub _run {
    my ($self, $guard, $obstruction) = @_;

    state %tried = (
        join(',', $self->input->{guard}->{'x'}, $self->input->{guard}->{'y'}) => 1,
    );

    if ($obstruction) {
        my $key = join(',', $obstruction->{x}, $obstruction->{y});
        return 0 if $tried{$key};
        $tried{$key} = 1;
        return 0 unless $self->_on_map($obstruction);
    }

    while ($self->_on_map($guard->location)) {
        while ($self->_is_obstructed($guard->next_location, $obstruction)) {
            $guard->rotate;
        }
        return 1 if $guard->already_visited($guard->next_location);
        $guard->move;
    }

    return 0;
}

sub _on_map {
    my ($self, $location) = @_;

    return $location->{x} >= 0
        && $location->{y} >= 0
        && $location->{x} < $self->input->{width}
        && $location->{y} < $self->input->{height};
}

sub _is_obstructed {
    my ($self, $location, $obstruction) = @_;

    if ($obstruction) {
        return 1 if $location->{x} == $obstruction->{x}
            && $location->{y} == $obstruction->{y};
    }

    my $key = join(',', $location->{x}, $location->{y});

    return $self->input->{obstructions}->{$key};
}

sub _parse_input {
    my $self = shift;

    my %input;

    my ($x, $y) = (0, 0);
    foreach my $row (split /\n/, $self->input) {
        $x = 0;
        foreach my $col (split //, $row) {
            $input{obstructions}->{join(',', $x, $y)} = 1 if $col eq '#';
            $input{guard} = { x => $x, y => $y } if $col eq '^';
            $x++;
        }
        $y++;
    }

    $input{width}  = $x;
    $input{height} = $y;

    return \%input;
}

1;
