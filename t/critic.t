#!/usr/bin/env perl

use v5.36;
use strictures 2;

use Test::Perl::Critic (-profile => 't/criticrc');

all_critic_ok(qw( bin lib ));
