#!/usr/bin/perl -s

%month =
(
  'January' => '01',
  'February' => '02',
  'March' => '03',
  'April' => '04',
  'May' => '05',
  'June' => '06',
  'July' => '07',
  'August' => '08',
  'September' => '09',
  'October' => '10',
  'November' => '11',
  'December' => '12',
);

open (INDEX, ">index.html");

print INDEX <<EOT
<HTML>
<HEAD>
  <TITLE>Internet Drafts that Adam Has Edited</TITLE>
</HEAD>
<BODY>
  <CENTER>
    <TABLE BORDER=1>
      <TR><TH>Date</TH><TH>File</TH><TH>Title</TH><TH>Download</TH></TR>
EOT
;

foreach $file (<*.xml>,<old/*.css>)
{
  $file =~ s/old\///;
  $txt = $file; $txt =~ s/...$/txt/;
  $html = $file; $html =~ s/...$/html/;
  $nits = $file; $nits =~ s/....$/-nits.txt/;

  if ($file =~ /css$/)
  {
    open (FILE, "old/$html");
  }
  else
  {
    open (FILE, $file);
  }

  $body = join('',<FILE>);
  close (FILE);
  ($title) = ($body =~ /<title[^>]*>([^<]*)</i);

  if ($file =~ /css$/)
  {
    ($date) = ($body =~ /<META [A-Z]*="Date" [A-Z]*="([^"]*)">/i);
    ($month, $year) = split(' ',$date);
  }
  else
  {
    ($month) = ($body =~ /month="([^"]*)"/);
    ($year) = ($body =~ /year="([^"]*)"/);
    $date = "$month $year";
  }

  $file =~ s/\....$//;
  $key = "$year.".$month{$month}.".$file";

  $row{$key} .= "      <TR>\n";
  $row{$key} .= "        <TD>$date</TD>\n";
  $row{$key} .= "        <TD>$file</TD>\n";
  $row{$key} .= "        <TD>$title</TD>\n";
  $row{$key} .= "        <TD>\n";
  $row{$key} .= "          <A href=\"$txt\">txt</A>\n";
  $row{$key} .= "          <A href=\"$html\">html</A>\n";
  if (-e $nits)
  {
    $row{$key} .= "          <A href=\"$nits\">nits</A>\n";
  }
  $row{$key} .= "        </TD>\n";
  $row{$key} .= "      </TR>\n";
}

foreach $key (sort {$b cmp $a} keys %row)
{
  unless ($q)
  {
    print "$key\n";
  }
  print INDEX "$row{$key}";
}

print INDEX "</TABLE></CENTER></BODY></HTML>\n";
