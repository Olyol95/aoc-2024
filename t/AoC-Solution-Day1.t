#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use AoC::Solution::Day1;

subtest part_1 => sub {
    my $solution = AoC::Solution::Day1->new(
        input => join("\n",
            '3   4',
            '4   3',
            '2   5',
            '1   3',
            '3   9',
            '3   3',
        ),
    );

    is ($solution->part_1, 11, 'part_1');
};

subtest part_2 => sub {
    my $solution = AoC::Solution::Day1->new(
        input => join("\n",
            '3   4',
            '4   3',
            '2   5',
            '1   3',
            '3   9',
            '3   3',
        ),
    );

    is ($solution->part_2, 31, 'part_2');
};

done_testing;
