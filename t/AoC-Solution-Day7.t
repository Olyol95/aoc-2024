#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day7');

my $solution = AoC::Solution::Day7->new(
    input => join("\n",
        '190: 10 19',
        '3267: 81 40 27',
        '83: 17 5',
        '156: 15 6',
        '7290: 6 8 6 15',
        '161011: 16 10 13',
        '192: 17 8 14',
        '21037: 9 7 18 13',
        '292: 11 6 16 20',
    ),
);

is ($solution->part_1, 3749, 'part_1');
is ($solution->part_2, 11387, 'part_2');

done_testing;
