#!/usr/bin/env perl -w
use strict;
use Test::More;
use Test::Cukes tests => 5;

feature(<<FEATURE_TEXT);
Feature: foo
  In order to bleh
  I want to bleh

  Scenario: blehbleh
    Given I am a missing person
    When I am a missing animal
    Then blah3
FEATURE_TEXT

# This regex shouldn't match.
my $hit_given = 0;
When qr/I am a missing (animal|alien)/i => sub {
  $hit_given = 1;
};

# 3 tests (skipped)
runtests;

is($hit_given, 0, "Correctly never ran the 'when' test"); 
is(@Test::Cukes::missing_steps, 2, '2 steps were missing');
