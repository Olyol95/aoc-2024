#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day11');

my $solution = AoC::Solution::Day11->new(
    input => '125 17',
);

is ($solution->part_1, 55312, 'part_1');
is ($solution->part_2, 65601038650482, 'part_2');

done_testing;
