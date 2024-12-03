#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::More;

use_ok('AoC::Solution::Day3');

subtest part_1 => sub {
    my $solution = AoC::Solution::Day3->new(
        input => 'xmul(2,4)%&mul[3,7]!@^do_not_mul(5,5)+mul(32,64]then(mul(11,8)mul(8,5))',
    );

    is ($solution->part_1, 161, 'part_1');
};

subtest part_2 => sub {
    my $solution = AoC::Solution::Day3->new(
        input => 'xmul(2,4)&mul[3,7]!^don\'t()_mul(5,5)+mul(32,64](mul(11,8)undo()?mul(8,5))',
    );

    is ($solution->part_2, 48, 'part_2');
};

done_testing;
