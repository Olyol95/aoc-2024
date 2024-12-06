#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day6');

my $solution = AoC::Solution::Day6->new(
    input => join("\n",
        '....#.....',
        '.........#',
        '..........',
        '..#.......',
        '.......#..',
        '..........',
        '.#..^.....',
        '........#.',
        '#.........',
        '......#...',
    ),
);

is ($solution->part_1, 41, 'part_1');
is ($solution->part_2, 6, 'part_2');

done_testing;
