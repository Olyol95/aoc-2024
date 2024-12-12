#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day12');

subtest part_1 => sub {
    my @tests = (
        {
            input => join("\n", qw(
                AAAA
                BBCD
                BBCC
                EEEC
            )),
            expect => 140,
        },
        {
            input => join("\n", qw(
                OOOOO
                OXOXO
                OOOOO
                OXOXO
                OOOOO
            )),
            expect => 772,
        },
        {
            input => join("\n", qw(
                RRRRIICCFF
                RRRRIICCCF
                VVRRRCCFFF
                VVRCCCJFFF
                VVVVCJJCFE
                VVIVCCJJEE
                VVIIICJJEE
                MIIIIIJJEE
                MIIISIJEEE
                MMMISSJEEE
            )),
            expect => 1930,
        },
    );
    foreach my $test (@tests) {
        my $solution = AoC::Solution::Day12->new(input => $test->{input});
        is ($solution->part_1, $test->{expect});
    }
};

subtest part_2 => sub {
    my @tests = (
        {
            input => join("\n", qw(
                AAAA
                BBCD
                BBCC
                EEEC
            )),
            expect => 80,
        },
        {
            input => join("\n", qw(
                OOOOO
                OXOXO
                OOOOO
                OXOXO
                OOOOO
            )),
            expect => 436,
        },
        {
            input => join("\n", qw(
                EEEEE
                EXXXX
                EEEEE
                EXXXX
                EEEEE
            )),
            expect => 236,
        },
        {
            input => join("\n", qw(
                AAAAAA
                AAABBA
                AAABBA
                ABBAAA
                ABBAAA
                AAAAAA
            )),
            expect => 368,
        },
        {
            input => join("\n", qw(
                RRRRIICCFF
                RRRRIICCCF
                VVRRRCCFFF
                VVRCCCJFFF
                VVVVCJJCFE
                VVIVCCJJEE
                VVIIICJJEE
                MIIIIIJJEE
                MIIISIJEEE
                MMMISSJEEE
            )),
            expect => 1206,
        },
    );
    foreach my $test (@tests) {
        my $solution = AoC::Solution::Day12->new(input => $test->{input});
        is ($solution->part_2, $test->{expect});
    }
};

done_testing;
