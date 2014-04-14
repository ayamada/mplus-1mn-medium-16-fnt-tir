#!/usr/bin/env perl

use strict;
use warnings;

our @CHAR_KEYS = qw[id x y width height xoffset yoffset xadvance page chnl];

sub mapper {
  my $data_orig = shift;
  my $data = { %$data_orig };

  # PUT YOUR CODE HERE

  #if ((1 <= $data->{height}) and ($data->{height} <= 16)) {
  #  $data->{y} = $data->{y} - 1;
  #  $data->{yoffset} = $data->{yoffset} - 1;
  #  $data->{height} = $data->{height} + 1;
  #}

  #if ((1 <= $data->{width}) and ($data->{width} <= 16)) {
  #  $data->{x} = $data->{x} - 1;
  #  $data->{xoffset} = $data->{xoffset} - 1;
  #  $data->{width} = $data->{width} + 1;
  #}

  $data;
}

while (1) {
  my $line = <STDIN>;
  last if not defined $line;
  $line =~ s/\x{000d}?\x{000a}?\z//;
  if ($line eq '') { print "\x{000d}\x{000a}"; next; }
  if ($line !~ /^char /) { print "$line\x{000d}\x{000a}"; next; }
  my $data = {};
  foreach my $key (@CHAR_KEYS) {
    my ($num) = ($line =~ /\b${key}\=(\-?\d+)/);
    $data->{$key} = $num + 0;
  }

  $data = mapper($data);

  foreach my $key (@CHAR_KEYS) {
    my $num = int($data->{$key});
    $line =~ s/\b${key}\=(\-?\d+)/${key}=${num}/;
  }

  print "$line\x{000d}\x{000a}";
}

