#!/usr/bin/perl

use MIME::Base64;

print "sip:tgruu.".gr(16).".".gr(10)."\@ssp.example.com;gr=".gr(16).gr(10)."\n";

sub gr
{
  my ($length) = shift;
  my ($i, @a);
  for ($i = 0; $i < $length; $i++)
  {
    $a[$i] = int(rand() * 256);
  }

  my ($r) = encode_base64(pack("C*",@a));
  chop $r;
  $r =~ s/=//g;
  $r;
}
