#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day2');

subtest part_1 => sub {
    my $solution = AoC::Solution::Day2->new(
        input => join("\n",
            '7 6 4 2 1',
            '1 2 7 8 9',
            '9 7 6 2 1',
            '1 3 2 4 5',
            '8 6 4 4 1',
            '1 3 6 7 9',
        ),
    );

    is ($solution->part_1, 2, 'part_1');
};

subtest part_2 => sub {
    my $solution = AoC::Solution::Day2->new(
        input => join("\n",
            '7 6 4 2 1',
            '1 2 7 8 9',
            '9 7 6 2 1',
            '1 3 2 4 5',
            '8 6 4 4 1',
            '1 3 6 7 9',
        ),
    );

    is ($solution->part_2, 4, 'part_2');
};

done_testing;
