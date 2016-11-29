#!/usr/bin/perl -w

use XML::LibXML;

my $dtd = XML::LibXML::Dtd->new("FOO // No / Idea / 1.0","rfc2629.dtd");

while ($file = shift)
{
  my $parser = XML::LibXML->new;
  open my $fh, "$file" || die $!;
  binmode $fh;
  print STDERR "Reading $file...\n";
  my $doc = $parser->parse_fh($fh);
  print STDERR "Done.\n";

  #$doc->validate($dtd);

  my $root = $doc->documentElement;

  process($root, 0);
}

sub process
{
  my ($element, $indent) = @_;
  my ($name) = $element->nodeName;
  my ($child);

  if ($name =~ /^#/ && length($element->nodeValue))
  {
    print (('  'x $indent).'['.length($element->nodeValue).']'.$element->nodeValue."\n");
  }

  else
  {
    if ($element->hasChildNodes)
    {
      print (('  'x $indent).'<'.$name.">\n");
      foreach $child ($element->childNodes)
      {
        process($child, $indent + 1);
      }
      print (('  'x $indent).'</'.$name.">\n");
    }
    else
    {
      print (('  'x $indent).'<'.$name."/>\n");
    }
  }
}
