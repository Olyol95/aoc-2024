#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day4');

my $solution = AoC::Solution::Day4->new(
    input => join("\n", qw(
        MMMSXXMASM
        MSAMXMSMSA
        AMXSXMAAMM
        MSAMASMSMX
        XMASAMXAMM
        XXAMMXXAMA
        SMSMSASXSS
        SAXAMASAAA
        MAMMMXMMMM
        MXMXAXMASX
    )),
);

is ($solution->part_1, 18, 'part_1');
is ($solution->part_2, 9, 'part_2');

done_testing;
