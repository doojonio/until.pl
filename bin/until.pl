#!/usr/bin/env perl

use strict;
use warnings;
use v5.38;

use Until::Model;
use Until::View;

my @dates = Until::Model::Date->load_from_file($ARGV[0]);

exit(-1) unless @dates;

my $now = Until::Model::Date->now();
my @deltas = map { $_->get_delta($now) } @dates;

my $view = Until::View->new(@deltas);

$view->run();
