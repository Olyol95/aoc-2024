#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day10');

my $solution = AoC::Solution::Day10->new(
    input => join("\n", qw(
        89010123
        78121874
        87430965
        96549874
        45678903
        32019012
        01329801
        10456732
    )),
);

is ($solution->part_1, 36, 'part_1');
is ($solution->part_2, 81, 'part_2');

done_testing;
