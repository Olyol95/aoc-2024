package AoC::Solution::Day6::Guard;

use v5.36;
use strictures 2;

use Moo;

extends 'Clone';

has x => (
    is       => 'rwp',
    required => 1,
);

has y => (
    is       => 'rwp',
    required => 1,
);

has _history => (
    is      => 'rw',
    default => sub { {} },
);

has _dx => (
    is      => 'rw',
    default => 0,
);

has _dy => (
    is      => 'rw',
    default => -1,
);

sub BUILD {
    my $self = shift;

    $self->_record_location;
}

sub next_location {
    my $self = shift;

    return {
        x  => $self->x + $self->_dx,
        y  => $self->y + $self->_dy,
        dx => $self->_dx,
        dy => $self->_dy,
    };
}

sub rotated_location {
    my $self = shift;

    my $dir = $self->_rotate;

    return {
        x  => $self->x + $dir->{x},
        y  => $self->y + $dir->{y},
        dx => $dir->{x},
        dy => $dir->{y},
    };
}

sub rotate {
    my $self = shift;

    my $dir = $self->_rotate;

    $self->_dx($dir->{x});
    $self->_dy($dir->{y});

    $self->_record_location;
}

sub _rotate {
    my $self = shift;

    my %dir;

    if ($self->_dy != 0) {
        $dir{x} = $self->_dy * -1;
        $dir{y} = 0;
    }
    else {
        $dir{y} = $self->_dx;
        $dir{x} = 0;
    }

    return \%dir;
}

sub move {
    my $self = shift;

    my $next = $self->next_location;

    $self->_set_x($next->{x});
    $self->_set_y($next->{y});

    $self->_record_location;
}

sub unique_locations {
    my $self = shift;

    return scalar keys %{ $self->_history };
}

sub already_visited {
    my ($self, $location) = @_;

    my $key = join(',', $location->{x}, $location->{y});
    my $dirs = $self->_history->{$key} || [];

    foreach my $dir (@$dirs) {
        return 1 if $location->{dx} == $dir->{dx}
            && $location->{dy} == $dir->{dy};
    }

    return 0;
}

sub location {
    my $self = shift;

    return {
        x  => $self->x,
        y  => $self->y,
        dx => $self->_dx,
        dy => $self->_dy,
    };
}

sub _record_location {
    my $self = shift;

    my $key = join(',', $self->x, $self->y);
    push @{ $self->_history->{$key} }, {
        dx => $self->_dx,
        dy => $self->_dy,
    };
}

1;