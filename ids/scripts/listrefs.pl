#!/usr/bin/perl

foreach $xml_file (shift)
{
  open (FILE, $xml_file) || die $!;
  $file = join ('',<FILE>);
  close (FILE);

  print "<!-- $xml_file -->\n\n";

  while ($file =~ /rfc ?([0-9]{3,})/gios)
  {
    $rfc{$1}++;
  }

  while ($file =~ /\&rfc([0-9]{3,});/gios)
  {
    $ref{$1}++;
  }

  print "<!DOCTYPE rfc SYSTEM \"rfc2629.dtd\"[\n";
  foreach $key (sort keys %rfc)
  {
    next if ($key eq '2629');
    print "  <!ENTITY rfc$key PUBLIC '' 'http://xml.resource.org/public/rfc/bibxml/reference.RFC.$key.xml'>\n";
  }
  print "]>\n";

  print "\n";

  foreach $key (sort keys %rfc)
  {
    next if ($key eq '2629');
    print "      &rfc$key;\n" unless $ref{$key};
  }

}
