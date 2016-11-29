#!/usr/bin/perl -w

$draft = '../../xml2rfc/draft-mrose-writing-rfcs.txt';

open (DRAFT, $draft) || die $!;
$contents = join '',<DRAFT>;
close (DRAFT);

$contents =~ /[\r\n]Appendix .\. *The DTD(.*?[\r\n])Appendix/s 
  || die "Could not find DTD in $draft\n";

$dtd = $1;
undef $contents;
$dtd =~ s/\n\n\n[^\n]*\[Page [0-9]+\]\n\n[^\n]*\n\n\n//g;
$dtd =~ s/^\n*//gs;
$dtd =~ s/\n*$/\n/gs;

open (DTD, '>rfc2629.dtd') || die $!;
print DTD $dtd;
close (DTD);
