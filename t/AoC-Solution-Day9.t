#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day9');

my $solution = AoC::Solution::Day9->new(
    input => '2333133121414131402',
);

is ($solution->part_1, 1928, 'part_1');
is ($solution->part_2, 2858, 'part_2');

done_testing;
