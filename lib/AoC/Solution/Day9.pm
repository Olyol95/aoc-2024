package AoC::Solution::Day9;

use v5.36;
use strictures 2;

use Moo;

with 'AoC::Solution';

sub part_1 {
    my $self = shift;

    my $idx = 0;
    my @disk = @{ $self->input };

    while ($idx < @disk) {
        if ($self->_space_at($idx, \@disk)) {
            my $char;
            do { $char = pop @disk } while ($char eq '.');
            $disk[$idx] = $char;
        }
        $idx++;
    }

    return $self->_checksum(\@disk);
}

sub part_2 {
    my $self = shift;

    my @disk = @{ $self->input };

    my $files = $self->_files;
    for (my $file_id = @$files - 1; $file_id >= 0; $file_id--) {
        my $idx = 0;
        my $file = $files->[$file_id];
        my $length = scalar @$file;
        while ($idx < $file->[0]) {
            my $space = $self->_space_at($idx, \@disk);
            if ($space >= $length) {
                $disk[$idx + $_] = $file_id for 0..$length - 1;
                $disk[$_] = '.' foreach @$file;
                last;
            }
            $idx++;
        }
    }

    return $self->_checksum(\@disk);
}

sub _files {
    my $self = shift;

    my $idx = 0;
    my $disk = $self->input;

    my @files;
    while ($idx < @$disk) {
        if ($disk->[$idx] ne '.') {
            push @{ $files[$disk->[$idx]] }, $idx;
        }
        $idx++;
    }

    return \@files;
}

sub _space_at {
    my ($self, $address, $disk) = @_;

    my $length = 0;
    while ($address < @$disk && $disk->[$address++] eq '.') {
        $length++;
    }

    return $length;
}

sub _checksum {
    my ($self, $disk) = @_;

    my $sum = 0;
    for (my $idx = 0; $idx < @$disk; $idx++) {
        next if $disk->[$idx] eq '.';
        $sum += $disk->[$idx] * $idx;
    }

    return $sum;
}

sub _parse_input {
    my $self = shift;

    my $input = $self->input;
    chomp $input;

    my @disk;
    my ($idx, $file_id) = (0, 0);
    foreach my $char (split //, $input) {
        if ($idx % 2) {
            push @disk, ('.') x $char;
        }
        else {
            push @disk, ($file_id) x $char;
            $file_id++;
        }
        $idx++;
    }

    return \@disk;
}

1;
