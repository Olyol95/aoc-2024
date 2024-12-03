package AoC::Solution::Day3;

use v5.36;
use strictures 2;

use List::Util qw(product);
use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $total = 0;
    foreach my $match ($self->input =~ /mul\((\d+,\d+)\)/g) {
        $total += product split /,/, $match;
    }

    return $total;
}

sub part_2 {
    my $self = shift;

    my $total = 0;
    my $enabled = 1;
    foreach my $match ($self->input =~ /(?:(do\(\))|mul\((\d+,\d+)\)|(don't\(\)))/g) {
        next unless $match;
        if ($match =~ /^do/) {
            $enabled = $match eq 'do()';
        }
        elsif ($enabled) {
            $total += product split /,/, $match;
        }
    }

    return $total;
}

sub _parse_input {
    my $self = shift;

    return $self->input =~ s/\n//gr;
}

1;
