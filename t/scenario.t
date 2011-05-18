#!/usr/bin/env perl -w
use strict;
use Test::More tests => 6;
use Test::Cukes::Scenario;

my $scenario = Test::Cukes::Scenario->new(<<SCENARIO_TEXT);
Scenario: Some random scenario text
  Given the pre-conditions is there
  When it branches into the second level
  Then the final shall be reached
SCENARIO_TEXT

is($scenario->name, "Some random scenario text");
is_deeply($scenario->steps, ["Given the pre-conditions is there",
                             "When it branches into the second level",
                             "Then the final shall be reached"]);

$scenario = Test::Cukes::Scenario->new(<<SCENARIO_TEXT);
Scenario: Right-indented scenario
  Given the pre-conditions is there
   When it branches into the second level
    And does something else
   Then the final shall be reached
SCENARIO_TEXT

is($scenario->name, "Right-indented scenario");
is_deeply($scenario->steps, ["Given the pre-conditions is there",
                             "When it branches into the second level",
                             "And does something else",
                             "Then the final shall be reached"]);

$scenario = Test::Cukes::Scenario->new(<<SCENARIO_TEXT);
Scenario: Left-indented scenario
  Given the pre-conditions is there
  When  it branches into the second level
  But   does nothing else
  Then  the final shall be reached
SCENARIO_TEXT

is($scenario->name, "Left-indented scenario");
is_deeply($scenario->steps, ["Given the pre-conditions is there",
                             "When it branches into the second level",
                             "But does nothing else",
                             "Then the final shall be reached"]);
