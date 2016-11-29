#!/usr/bin/perl

$rfc_dir = '/Users/adam/Documents/IETF/rfcs';
$info_draft = "/Users/adam/Documents/IETF/internet-drafts/draft-ietf-sipcore-info-events-07.txt";

$iana = 'http://www.iana.org/assignments/sip-parameters';

######################################################################
# Completely Missing Rows
######################################################################

############
# RFC 5373
$proxy{'Answer-Mode'}{'R'} =
$proxy{'Answer-Mode'}{'2xx'} =
$proxy{'Priv-Answer-Mode'}{'R'} =
$proxy{'Priv-Answer-Mode'}{'2xx'} = 'amdr';

$whosaysproxy{'Answer-Mode'}{'2xx'} = 'Manual Override';
$whosaysproxy{'Answer-Mode'}{'R'} = 'Manual Override';
$whosaysproxy{'Priv-Answer-Mode'}{'2xx'} = 'Manual Override';
$whosaysproxy{'Priv-Answer-Mode'}{'R'} = 'Manual Override';

%{$override{'Answer-Mode'}{'2xx'}} =
%{$override{'Answer-Mode'}{'R'}} =
%{$override{'Priv-Answer-Mode'}{'2xx'}} =
%{$override{'Priv-Answer-Mode'}{'R'}} =
(
  'ACK'        => '-',
  'BYE'        => '-',
  'CANCEL'     => '-',
  'INFO'       => '-',
  'INVITE'     => 'o',
  'MESSAGE'    => '-',
  'NOTIFY'     => '-',
  'OPTIONS'    => '-',
  'PRACK'      => '-',
  'PUBLISH'    => '-',
  'REFER'      => '-',
  'REGISTER'   => '-',
  'SUBSCRIBE'  => '-',
  'UPDATE'     => '-',
);

$proxy{'Flow-Timer'}{'2xx'} = 'a';
$whosaysproxy{'Flow-Timer'}{'2xx'} = 'Manual Override';
%{$override{'Flow-Timer'}{'2xx'}} =
(
  'ACK'        => '-',
  'BYE'        => '-',
  'CANCEL'     => '-',
  'INFO'       => '-',
  'INVITE'     => '-',
  'MESSAGE'    => '-',
  'NOTIFY'     => '-',
  'OPTIONS'    => '-',
  'PRACK'      => '-',
  'PUBLISH'    => '-',
  'REFER'      => '-',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => '-',
  'UPDATE'     => '-',
);

$proxy{'Max-Breadth'}{'R'} = 'amr';
$whosaysproxy{'Max-Breadth'}{'R'} = 'Manual Override';
%{$override{'Max-Breadth'}{'R'}} =
(
  'ACK'        => 'm*',
  'BYE'        => 'm*',
  'CANCEL'     => '-',
  'INFO'       => 'm*',
  'INVITE'     => 'm*',
  'MESSAGE'    => 'm*',
  'NOTIFY'     => 'm*',
  'OPTIONS'    => 'm*',
  'PRACK'      => 'm*',
  'PUBLISH'    => 'm*',
  'REFER'      => 'm*',
  'REGISTER'   => 'm*',
  'SUBSCRIBE'  => 'm*',
  'UPDATE'     => 'm*',
);

$proxy{'P-Profile-Key'}{'R'} = 'admr';
$whosaysproxy{'P-Profile-Key'}{'R'} = 'Manual Override';
%{$override{'P-Profile-Key'}{'R'}} =
(
  'ACK'        => 'o',
  'BYE'        => 'o',
  'CANCEL'     => '-',
  'INFO'       => 'o',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => 'o',
  'OPTIONS'    => 'o',
  'PRACK'      => 'o',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => 'o',
);

$proxy{'P-Refused-URI-List'}{'403'} = ' ';
$whosaysproxy{'P-Refused-URI-List'}{'403'} = 'Manual Override';
%{$override{'P-Refused-URI-List'}{'403'}} =
(
  'ACK'        => '-',
  'BYE'        => 'o',
  'CANCEL'     => '-',
  'INFO'       => 'o',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => 'o',
  'OPTIONS'    => 'o',
  'PRACK'      => 'o',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => 'o',
);

$proxy{'P-Served-User'}{'R'} = 'amdr';
$whosaysproxy{'P-Served-User'}{'R'} = 'Manual Override';
%{$override{'P-Served-User'}{'R'}} =
(
  'ACK'        => '-',
  'BYE'        => '-',
  'CANCEL'     => '-',
  'INFO'       => '-',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => '-',
  'OPTIONS'    => 'o',
  'PRACK'      => '-',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => '-',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => '-',
);

$proxy{'P-User-Database'}{'R'} = 'admr';
$whosaysproxy{'P-User-Database'}{'R'} = 'Manual Override';
%{$override{'P-User-Database'}{'R'}} =
(
  'ACK'        => '-',
  'BYE'        => '-',
  'CANCEL'     => '-',
  'INFO'       => '-',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => '-',
  'OPTIONS'    => 'o',
  'PRACK'      => '-',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => '-',
);

$proxy{'Permission-Missing'}{'470'} = ' ';
$whosaysproxy{'Permission-Missing'}{'470'} = 'Manual Override';
%{$override{'Permission-Missing'}{'470'}} =
(
  'ACK'        => '-',
  'BYE'        => 'o',
  'CANCEL'     => '-',
  'INFO'       => 'o',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => 'o',
  'OPTIONS'    => 'o',
  'PRACK'      => 'o',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => 'o',
);

$proxy{'Reason'}{'R'} = ' ';
$whosaysproxy{'Reason'}{'R'} = 'Manual Override';
%{$override{'Reason'}{'R'}} =
(
  'ACK'        => '-',
  'BYE'        => 'o',
  'CANCEL'     => 'o',
  'INFO'       => 'o',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => 'o',
  'OPTIONS'    => 'o',
  'PRACK'      => 'o',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => 'o',
);

$proxy{'Trigger-Consent'}{'R'} = ' ';
$whosaysproxy{'Trigger-Consent'}{'R'} = 'Manual Override';
%{$override{'Trigger-Consent'}{'R'}} =
(
  'ACK'        => '-',
  'BYE'        => 'o',
  'CANCEL'     => '-',
  'INFO'       => 'o',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => 'o',
  'OPTIONS'    => 'o',
  'PRACK'      => 'o',
  'PUBLISH'    => 'o',
  'REFER'      => 'o',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'o',
  'UPDATE'     => 'o',
);

$proxy{'Expires'}{'2xx'} = ' ';
$whosaysproxy{'Expires'}{'2xx'} = 'Manual Override';
%{$override{'Expires'}{'2xx'}} =
(
  'ACK'        => '-',
  'BYE'        => '-',
  'CANCEL'     => '-',
  'INFO'       => '-',
  'INVITE'     => 'o',
  'MESSAGE'    => 'o',
  'NOTIFY'     => '-',
  'OPTIONS'    => '-',
  'PRACK'      => '-',
  'PUBLISH'    => 'o',
  'REFER'      => '-',
  'REGISTER'   => 'o',
  'SUBSCRIBE'  => 'm',
  'UPDATE'     => '-',
);

######################################################################
# Individual Missing Cells
######################################################################
$override{'Accept'}{'2xx'}{'INFO'} = '-';
$override{'Accept-Contact'}{'R'}{'PUBLISH'} = 'o';
$override{'Alert-Info'}{'180'}{'INFO'} = '-';
$override{'Alert-Info'}{'180'}{'PUBLISH'} = '-';
$override{'Alert-Info'}{'180'}{'REFER'} = '-';
$override{'Alert-Info'}{'180'}{'UPDATE'} = '-';
$override{'Allow'}{' '}{'REFER'} = 'o';
$override{'Allow'}{'2xx'}{'INFO'} = 'o';
$override{'Allow'}{'2xx'}{'PUBLISH'} = 'o';
$override{'Allow'}{'2xx'}{'REFER'} = 'o';
$override{'Allow-Events'}{'2xx'}{'INFO'} = 'o';
$override{'Allow-Events'}{'2xx'}{'MESSAGE'} = 'o';
$override{'Allow-Events'}{'2xx'}{'PUBLISH'} = 'o';
$override{'Allow-Events'}{'2xx'}{'REFER'} = 'o';
$override{'Allow-Events'}{'2xx'}{'UPDATE'} = 'o';
$override{'Allow-Events'}{'489'}{'INFO'} = '-';
$override{'Allow-Events'}{'489'}{'MESSAGE'} = '-';
$override{'Allow-Events'}{'489'}{'REFER'} = '-';
$override{'Allow-Events'}{'489'}{'UPDATE'} = '-';
$override{'Allow-Events'}{'R'}{'INFO'} = 'o';
$override{'Allow-Events'}{'R'}{'MESSAGE'} = 'o';
$override{'Allow-Events'}{'R'}{'REFER'} = 'o';
$override{'Allow-Events'}{'R'}{'UPDATE'} = 'o';
$override{'Call-Info'}{' '}{'NOTIFY'} = 'o';
$override{'Call-Info'}{' '}{'NOTIFY'} = 'o';
$override{'Call-Info'}{' '}{'SUBSCRIBE'} = 'o';
$override{'Call-Info'}{' '}{'SUBSCRIBE'} = 'o';
$override{'Contact'}{'3xx'}{'REFER'} = 'o';
$override{'Contact'}{'485'}{'REFER'} = 'o';
$override{'Content-Length'}{' '}{'REFER'} = 't';
$override{'Error-Info'}{'300-699'}{'INFO'} = 'o';
$override{'Error-Info'}{'300-699'}{'REFER'} = 'o';
$override{'Event'}{'R'}{'INFO'} = '-';
$override{'Event'}{'R'}{'MESSAGE'} = '-';
$override{'Event'}{'R'}{'REFER'} = '-';
$override{'Expires'}{'r'}{'REFER'} = '-';
$override{'Identity'}{'R'}{'MESSAGE'} = 'o';
$override{'Identity'}{'R'}{'PUBLISH'} = 'o';
$override{'Identity-Info'}{'R'}{'MESSAGE'} = 'o';
$override{'Identity-Info'}{'R'}{'PUBLISH'} = 'o';
$override{'In-Reply-To'}{'R'}{'INFO'} = '-';
$override{'MIME-Version'}{' '}{'MESSAGE'} = 'o';
$override{'Min-Expires'}{'423'}{'INFO'} = '-';
$override{'Min-Expires'}{'423'}{'MESSAGE'} = '-';
$override{'Min-Expires'}{'423'}{'REFER'} = '-';
$override{'Min-Expires'}{'423'}{'UPDATE'} = '-';
$override{'Min-SE'}{'422'}{'INFO'} = '-';
$override{'Min-SE'}{'422'}{'MESSAGE'} = '-';
$override{'Min-SE'}{'422'}{'PUBLISH'} = '-';
$override{'Min-SE'}{'422'}{'REFER'} = '-';
$override{'Min-SE'}{'R'}{'INFO'} = '-';
$override{'Min-SE'}{'R'}{'MESSAGE'} = '-';
$override{'Min-SE'}{'R'}{'PUBLISH'} = '-';
$override{'Min-SE'}{'R'}{'REFER'} = '-';
$override{'P-Access-Network-Info'}{' '}{'PUBLISH'} = 'o';
$override{'P-Answer-State'}{'18x'}{'INFO'} = '-';
$override{'P-Answer-State'}{'18x'}{'MESSAGE'} = '-';
$override{'P-Answer-State'}{'18x'}{'NOTIFY'} = '-';
$override{'P-Answer-State'}{'18x'}{'PRACK'} = '-';
$override{'P-Answer-State'}{'18x'}{'PUBLISH'} = '-';
$override{'P-Answer-State'}{'18x'}{'REFER'} = '-';
$override{'P-Answer-State'}{'18x'}{'UPDATE'} = '-';
$override{'P-Answer-State'}{'2xx'}{'INFO'} = '-';
$override{'P-Answer-State'}{'2xx'}{'MESSAGE'} = '-';
$override{'P-Answer-State'}{'2xx'}{'NOTIFY'} = '-';
$override{'P-Answer-State'}{'2xx'}{'PRACK'} = '-';
$override{'P-Answer-State'}{'2xx'}{'PUBLISH'} = '-';
$override{'P-Answer-State'}{'2xx'}{'REFER'} = '-';
$override{'P-Answer-State'}{'2xx'}{'UPDATE'} = '-';
$override{'P-Asserted-Identity'}{' '}{'MESSAGE'} = 'o';
$override{'P-Asserted-Identity'}{' '}{'PUBLISH'} = 'o';
$override{'P-Associated-URI'}{'2xx'}{'INFO'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'MESSAGE'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'NOTIFY'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'PRACK'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'PUBLISH'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'REFER'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'SUBSCRIBE'} = '-';
$override{'P-Associated-URI'}{'2xx'}{'UPDATE'} = '-';
$override{'P-Called-Party-ID'}{'R'}{'PUBLISH'} = 'o';
$override{'P-Charging-Function-Addresses'}{' '}{'PUBLISH'} = 'o';
$override{'P-Charging-Vector'}{' '}{'PUBLISH'} = 'o';
$override{'P-DCS-LAES'}{' '}{'INFO'} = '-';
$override{'P-DCS-LAES'}{' '}{'MESSAGE'} = '-';
$override{'P-DCS-LAES'}{' '}{'NOTIFY'} = '-';
$override{'P-DCS-LAES'}{' '}{'PRACK'} = '-';
$override{'P-DCS-LAES'}{' '}{'REFER'} = '-';
$override{'P-DCS-LAES'}{' '}{'SUBSCRIBE'} = '-';
$override{'P-DCS-LAES'}{' '}{'UPDATE'} = '-';
$override{'P-Early-Media'}{'18x'}{'INFO'} = '-';
$override{'P-Early-Media'}{'18x'}{'MESSAGE'} = '-';
$override{'P-Early-Media'}{'18x'}{'NOTIFY'} = '-';
$override{'P-Early-Media'}{'18x'}{'PUBLISH'} = '-';
$override{'P-Early-Media'}{'18x'}{'REFER'} = '-';
$override{'P-Early-Media'}{'18x'}{'SUBSCRIBE'} = '-';
$override{'P-Early-Media'}{'2xx'}{'INFO'} = '-';
$override{'P-Early-Media'}{'2xx'}{'MESSAGE'} = '-';
$override{'P-Early-Media'}{'2xx'}{'NOTIFY'} = '-';
$override{'P-Early-Media'}{'2xx'}{'PUBLISH'} = '-';
$override{'P-Early-Media'}{'2xx'}{'REFER'} = '-';
$override{'P-Early-Media'}{'2xx'}{'SUBSCRIBE'} = '-';
$override{'P-Early-Media'}{'R'}{'INFO'} = '-';
$override{'P-Early-Media'}{'R'}{'MESSAGE'} = '-';
$override{'P-Early-Media'}{'R'}{'NOTIFY'} = '-';
$override{'P-Early-Media'}{'R'}{'PUBLISH'} = '-';
$override{'P-Early-Media'}{'R'}{'REFER'} = '-';
$override{'P-Early-Media'}{'R'}{'SUBSCRIBE'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'INFO'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'MESSAGE'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'NOTIFY'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'PRACK'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'PUBLISH'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'REFER'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'SUBSCRIBE'} = '-';
$override{'P-Media-Authorization'}{'101-199'}{'UPDATE'} = '-';
$override{'P-Media-Authorization'}{'2xx'}{'MESSAGE'} = '-';
$override{'P-Media-Authorization'}{'2xx'}{'PUBLISH'} = '-';
$override{'P-Media-Authorization'}{'2xx'}{'REFER'} = '-';
$override{'P-Media-Authorization'}{'R'}{'MESSAGE'} = '-';
$override{'P-Media-Authorization'}{'R'}{'PUBLISH'} = '-';
$override{'P-Media-Authorization'}{'R'}{'REFER'} = '-';
$override{'P-Preferred-Identity'}{' '}{'MESSAGE'} = 'o';
$override{'P-Preferred-Identity'}{' '}{'PUBLISH'} = 'o';
$override{'P-Visited-Network-ID'}{'R'}{'PUBLISH'} = 'o';
$override{'Path'}{'2xx'}{'INFO'} = '-';
$override{'Path'}{'2xx'}{'MESSAGE'} = '-';
$override{'Path'}{'2xx'}{'NOTIFY'} = '-';
$override{'Path'}{'2xx'}{'PRACK'} = '-';
$override{'Path'}{'2xx'}{'PUBLISH'} = '-';
$override{'Path'}{'2xx'}{'REFER'} = '-';
$override{'Path'}{'2xx'}{'SUBSCRIBE'} = '-';
$override{'Path'}{'2xx'}{'UPDATE'} = '-';
$override{'Path'}{'R'}{'INFO'} = '-';
$override{'Path'}{'R'}{'MESSAGE'} = '-';
$override{'Path'}{'R'}{'NOTIFY'} = '-';
$override{'Path'}{'R'}{'PRACK'} = '-';
$override{'Path'}{'R'}{'PUBLISH'} = '-';
$override{'Path'}{'R'}{'REFER'} = '-';
$override{'Path'}{'R'}{'SUBSCRIBE'} = '-';
$override{'Path'}{'R'}{'UPDATE'} = '-';
$override{'Privacy'}{' '}{'PRACK'} = 'o';
$override{'Privacy'}{' '}{'PUBLISH'} = 'o';
$override{'Privacy'}{' '}{'REFER'} = 'o';
$override{'Proxy-Authenticate'}{'401'}{'NOTIFY'} = 'o';
$override{'Proxy-Authenticate'}{'401'}{'SUBSCRIBE'} = 'o';
$override{'RAck'}{'R'}{'INFO'} = '-';
$override{'RAck'}{'R'}{'MESSAGE'} = '-';
$override{'RAck'}{'R'}{'PUBLISH'} = '-';
$override{'RAck'}{'R'}{'REFER'} = '-';
$override{'RSeq'}{'1xx'}{'INFO'} = '-';
$override{'RSeq'}{'1xx'}{'MESSAGE'} = '-';
$override{'RSeq'}{'1xx'}{'NOTIFY'} = '-';
$override{'RSeq'}{'1xx'}{'PUBLISH'} = '-';
$override{'RSeq'}{'1xx'}{'REFER'} = '-';
$override{'RSeq'}{'1xx'}{'SUBSCRIBE'} = '-';
$override{'RSeq'}{'1xx'}{'UPDATE'} = '-';
$override{'Record-Route'}{'18x'}{'BYE'} = '-';
$override{'Record-Route'}{'18x'}{'CANCEL'} = '-';
$override{'Record-Route'}{'18x'}{'INFO'} = '-';
$override{'Record-Route'}{'18x'}{'MESSAGE'} = '-';
$override{'Record-Route'}{'18x'}{'NOTIFY'} = '-';
$override{'Record-Route'}{'18x'}{'OPTIONS'} = '-';
$override{'Record-Route'}{'18x'}{'PRACK'} = '-';
$override{'Record-Route'}{'18x'}{'PUBLISH'} = '-';
$override{'Record-Route'}{'18x'}{'REFER'} = '-';
$override{'Record-Route'}{'18x'}{'SUBSCRIBE'} = '-';
$override{'Record-Route'}{'18x'}{'UPDATE'} = '-';
$override{'Record-Route'}{'2xx'}{'MESSAGE'} = 'o';
$override{'Record-Route'}{'2xx'}{'PUBLISH'} = '-';
$override{'Referred-By'}{'R'}{'MESSAGE'} = 'o';
$override{'Referred-By'}{'R'}{'NOTIFY'} = '-';
$override{'Referred-By'}{'R'}{'PRACK'} = '-';
$override{'Referred-By'}{'R'}{'PUBLISH'} = 'o';
$override{'Referred-By'}{'R'}{'REFER'} = 'o';
$override{'Referred-By'}{'R'}{'SUBSCRIBE'} = 'o';
$override{'Referred-By'}{'R'}{'UPDATE'} = 'o';
$override{'Reject-Contact'}{'R'}{'PUBLISH'} = 'o';
$override{'Reply-To'}{' '}{'INFO'} = '-';
$override{'Request-Disposition'}{'R'}{'PUBLISH'} = 'o';
$override{'Security-Client'}{'R'}{'PRACK'} = 'o';
$override{'Security-Client'}{'R'}{'PUBLISH'} = 'o';
$override{'Security-Client'}{'R'}{'REFER'} = 'o';
$override{'Security-Server'}{'421'}{'PRACK'} = 'o';
$override{'Security-Server'}{'421'}{'PUBLISH'} = 'o';
$override{'Security-Server'}{'421'}{'REFER'} = 'o';
$override{'Security-Server'}{'494'}{'PRACK'} = 'o';
$override{'Security-Server'}{'494'}{'PUBLISH'} = 'o';
$override{'Security-Server'}{'494'}{'REFER'} = 'o';
$override{'Security-Verify'}{'R'}{'PRACK'} = 'o';
$override{'Security-Verify'}{'R'}{'PUBLISH'} = 'o';
$override{'Security-Verify'}{'R'}{'REFER'} = 'o';
$override{'Service-Route'}{'2xx'}{'INFO'} = '-';
$override{'Service-Route'}{'2xx'}{'MESSAGE'} = '-';
$override{'Service-Route'}{'2xx'}{'NOTIFY'} = '-';
$override{'Service-Route'}{'2xx'}{'PUBLISH'} = '-';
$override{'Service-Route'}{'2xx'}{'REFER'} = '-';
$override{'Service-Route'}{'2xx'}{'SUBSCRIBE'} = '-';
$override{'Service-Route'}{'2xx'}{'UPDATE'} = '-';
$override{'Session-Expires'}{'2xx'}{'INFO'} = '-';
$override{'Session-Expires'}{'2xx'}{'MESSAGE'} = '-';
$override{'Session-Expires'}{'2xx'}{'PUBLISH'} = '-';
$override{'Session-Expires'}{'2xx'}{'REFER'} = '-';
$override{'Session-Expires'}{'R'}{'INFO'} = '-';
$override{'Session-Expires'}{'R'}{'MESSAGE'} = '-';
$override{'Session-Expires'}{'R'}{'PUBLISH'} = '-';
$override{'Session-Expires'}{'R'}{'REFER'} = '-';
$override{'Subscription-State'}{'R'}{'INFO'} = '-';
$override{'Subscription-State'}{'R'}{'MESSAGE'} = '-';
$override{'Subscription-State'}{'R'}{'PUBLISH'} = '-';
$override{'Subscription-State'}{'R'}{'REFER'} = '-';
$override{'Supported'}{'2xx'}{'MESSAGE'} = 'o';
$override{'Supported'}{'R'}{'MESSAGE'} = 'o';
$override{'Via'}{'R'}{'NOTIFY'} = 'm';
$override{'Via'}{'R'}{'PRACK'} = 'm';
$override{'Via'}{'R'}{'REFER'} = 'm';
$override{'Via'}{'R'}{'SUBSCRIBE'} = 'm';
$override{'Via'}{'rc'}{'INFO'} = 'm';
$override{'Via'}{'rc'}{'NOTIFY'} = 'm';
$override{'Via'}{'rc'}{'PRACK'} = 'm';
$override{'Via'}{'rc'}{'REFER'} = 'm';
$override{'Via'}{'rc'}{'SUBSCRIBE'} = 'm';
$override{'WWW-Authenticate'}{'407'}{'NOTIFY'} = 'o';
$override{'WWW-Authenticate'}{'407'}{'PRACK'} = 'o';
$override{'WWW-Authenticate'}{'407'}{'SUBSCRIBE'} = 'o';

######################################################################


use LWP::UserAgent;
$ua = LWP::UserAgent->new;

$lwp_request = HTTP::Request->new(GET => $iana);
$lwp_result = $ua->request($lwp_request);
$registry = $lwp_result->content;

foreach $_ (split(/\n/,$registry))
{
  if (/Header Name        compact    Reference/) { $mode = 'header'; }
  if (/Methods                  Reference/) { $mode = 'method'; }
  if (/^[ \t]*$/) { undef $mode; }

  if ($mode eq 'header' && /^ *([^ ]*) .*\[RFC([0-9]{4,})\] *$/)
  {
    push (@{$rfc{$2}}, $1);
    $header_from{$1} = "rfc$2";
    push (@headers, $1);
    if (length ($1) > $hlen) { $hlen = length($1); }
    $header{$1}++;
  }

  if ($mode eq 'method' && /^ *([A-Z]*) *\[RFC([0-9]{4,})\] *$/)
  {
    push (@{$rfc{$2}}, $1);
    $method_from{$1} = "rfc$2";
    push (@methods, $1);
    $method = $1;
    $short{$method} = $1;
    $short{$method} =~ s/(...).*/$1/;
    push (@shorts, $short{$method});
  }
}

foreach $key (sort keys %rfc)
{
  push (@docs, "${rfc_dir}/rfc$key.txt");
  print "RFC $key - ".join(', ',@{$rfc{$key}})."\n";
}

if (-e $info_draft)
{
  push (@docs, $info_draft);
}

foreach $doc (@docs)
{
  #print (('-' x 70) . "\n");
  print "$doc\n";
  open (RFC, $doc) || die $!;
  undef ($first_col);
  %method_col = ();
  while (<RFC>)
  {
    $rfc = $doc;
    $rfc =~ s/.*(rfc[0-9]{4,5}|draft.*).*/$1/;
    s/[\r\n]//g;

    # Several adjustments to normalize various RFCs
    s/                                      SUB  NOT  REF  INF  UPD  PRA  PUB/      Header field    where   proxy   SUB  NOT  REF  INF  UPD  PRA  PUB/;
    s/Header field                        NOT PRA INF UPD MSG REF PUB/Header field          where  proxy  NOT PRA INF UPD MES REF PUB/;
    s/      Header                    Where   REFER/      Header                    Where   REF/;
    s/INFO */INF/g;
    s/ MSG/ MES/g;
    s/ RFR/ REF/g;
    s/UPDATE$/ UPD/g;
    s/MESSAGE$/   MES/g;
    s/Retry-After   404,413,480,486/Retry-After   xxx            /;
    s/\|/ /g;
    s/PUBLISH *$/   PUB/g;
    s/PRACK *$/ PRA/g;

    # Whenever we find a table heading, set up the columns properly
    $all = join ('|',@shorts);
    if (/(where|header field).* ($all) *$/i 
     || /($all) +($all)/
     || /Where.*INF/)
    {
      undef ($first_col);
      if (/^(.*)(proxy *)/)
      {
        $first_col = $proxy_col = length($1);
        $proxy_len = length($2);
      }
      else
      {
        undef ($proxy_col);
      }

      %method_col = ();
      foreach $method (@methods)
      {
        if (/^(.*)($short{$method} *)/)
        {
          if (!defined($first_col) || $first_col > length($1)) 
            { $first_col = length($1); }
          $method_col{$method} = length($1);
          $method_len{$method} = length($2);
        }
      }
    }

    # Fixes for odd double-line format in RFCs 3325, 4474, 5503
    s/^( *)(( +[-cmot]){2,})$/$x=length($1);sprintf("%-$x.${x}s%s",$header,$2)/e;

    # If this line looks like a table entry, add it to the data structures
    if (defined($first_col) && /^( *)([^ ]*).* [-cmot\*]\*? *\r?\n?$/ && 
         ($header{$2} || $2 eq 'P-Charging-Function-'))
    {
      $header = $2;
      $where_start = length($1)+length($header);
      $header =~ s/^P-Charging-Function-$/P-Charging-Function-Addresses/;
      $where = substr($_,$where_start,$first_col - $where_start);
      $where =~ s/ //g;
      $where =~ s/X/x/g;
      $where =~ s/[ge]//g;
      $where =~ s/\([^\)]*\)//g;
      $where =~ s/^-$//;
      $where =~ s/404,413,480,486/404,413,480,486,500,503,600,603/;
      $where =~ s/xxx/404,413,480,486,500,503,600,603/;
      if ($where =~ /[^-0-9x,Rrc]/) { die "where = $where"; }
      @wheres = split (',',$where);
      if (@wheres == 0) { @wheres = ('r','R'); }

      $proxy = '';
      if ($proxy_col)
      {
        $proxy = substr($_,$proxy_col,$proxy_len);
        $proxy =~ s/ //g;

        foreach $w (@wheres)
        {
          if (defined $proxy{$header}{$w} && $proxy{$header}{$w} ne $proxy)
          {
            warn "Conflict in proxy definition for $header: ".
             "'$proxy{$header}{$w}' != '$proxy' in $rfc (previously defined in ".
             join(', ',sort keys %{$whosaysproxy{$header}{$w}}).")";
             if (length($proxy) == 0) { $proxy = $proxy{$header}{$w}; }
             elsif (length($proxy{$header}{$w}) != 0) { die "Cannot resolve conflict"; }
             $whosaysproxy{$header}{$w}{$rfc." (conflicting)"}++;
          }
          else
          {
            $whosaysproxy{$header}{$w}{$rfc}++;
          }
          $proxy{$header}{$w} = $proxy;
        }
      }
      #print "[$header][$where][$proxy]\n";
      if ($proxy =~ /[^-amdr]/) { die "[$proxy]"; }

      foreach $method (@methods)
      {
        if ($method_col{$method})
        {
          $usage = substr($_, $method_col{$method}, $method_len{$method});
          $usage =~ s/[\r\n ]//gs;
          #print "  $short{$method} - [$usage]\n";
          $usage =~ s/o\*+/o/;
          if ($usage ne 'c' &&
              $usage ne 'm' &&
              $usage ne 'm*' &&
              $usage ne 'o' &&
              $usage ne 't' &&
              $usage ne '*' &&
              $usage ne '-') { die "$method: [$usage]"; }

          foreach $w (@wheres)
          {
            $whosays{$header}{$w}{$method} .= $rfc." ";
            $exist = $usage{$header}{$w}{$method};
            if ($exist && ($exist ne $usage))
            {
              $usage{$header}{$w}{$method} .= "/".$usage;
              print "Conflict for $header between $whosays{$header}{$w}{$method}\n";
            }
            else
            {
              $usage{$header}{$w}{$method} = $usage;
            }
          }
        }
      }
    }


  }
  close (RFC);
}

# Combine rows where R == r
foreach $header (@headers)
{
  if (defined $proxy{$header}{'R'} && defined $proxy{$header}{'r'})
  {
    if ($proxy{$header}{'R'} eq $proxy{$header}{'r'})
    {
      $combine = 1;
      check: foreach $key (keys %{$usage{$header}{'R'}})
      {
        if ($usage{$header}{'R'}{$key} ne $usage{$header}{'r'}{$key})
        {
          print "Not combining $header because $key does not match\n";
          $combine = 0;
          last check;
        }
      }

      if ($combine == 1)
      {
        print "Combining identical request/response for $header\n";
        $proxy{$header}{' '} = $proxy{$header}{'R'};
        $whosaysproxy{$header}{' '} = $whosaysproxy{$header}{'R'};
        delete $proxy{$header}{'R'};
        delete $proxy{$header}{'r'};
        foreach $key (keys %{$usage{$header}{'R'}})
        {
          $usage{$header}{' '}{$key} = $usage{$header}{'R'}{$key}; 
          $whosays{$header}{' '}{$key} = $whosays{$header}{'R'}{$key}; 
        }
        delete $usage{$header}{'R'};
        delete $usage{$header}{'r'};
      }
    }
    else
    {
      print "Not combining $header because proxy for R '$proxy{$header}{R}' does not match proxy for r '$proxy{$header}{r}'\n";
    }
  }
}

######################################################################
# Output starts here

#@methods = ('SUBSCRIBE','NOTIFY');
#@methods = ( 'ACK', 'BYE', 'CANCEL', 'INFO', 'INVITE', 'MESSAGE', 'NOTIFY');
#@methods = ( 'OPTIONS', 'PRACK', 'PUBLISH', 'REFER', 'REGISTER', 'SUBSCRIBE', 'UPDATE');

@shorts = ();
foreach $method (@methods) { push (@shorts, $short{$method})}

$template = "%-$hlen.${hlen}s %-7.7s %-5.5s".(' %-3s' x @shorts)."\n";

$txt .= sprintf ($template, "Header Field", "Where", "Proxy", @shorts);

foreach $x (@shorts) { push @u, '---'; }

$txt .= sprintf ($template, "-"x 200, "-"x 200, "-" x 200, @u);

$html .= "<html><head><title>SIP Table 2</title></head><body>\n".
         "<table border='1'>\n<tr><th>Header Field</th><th>Where</th><th>Proxy</th><th>".
         join("</th><th>",@shorts)."</td></tr>\n";

foreach $header (@headers)
{
  @where = sort keys %{$proxy{$header}};
  if (@where == 0)
  {
    @where = '?';
  }
  row: foreach $where (@where)
  {
    $include = 0;
    foreach $method (@methods)
    {
      if ($usage{$header}{$where}{$method} && 
          $usage{$header}{$where}{$method} ne '-')
      {
        $include ++;
      }
      if ($override{$header}{$where}{$method} && 
          $override{$header}{$where}{$method} ne '-')
      {
        $include ++;
      }
    }
    if (!$include && $where !~ /\?/) 
    {
      print "Discarding empty row for $header/$where\n";
      next row; 
    }

    if ($header eq 'Encryption'
       || $header eq 'Response-Key')
    {
      print "Discarding row for deprecated header $header/$where\n";
      next row; 
    }

    @htmlusage = ();
    @usage = ();
    if ($where eq '?') 
    { 
#      $overrides .= $whosaysproxy{'Answer-Mode'}{'x'} = 'Manual Override';

      $overrides .= "\n#\$proxy{'$header'}{'$where'} = ' ';\n".
                    "#\$whosaysproxy{'$header'}{'$where'} = 'Manual Override';\n".
                      "#\%{\$override{'$header'}{'$where'}} =\n#(\n";
      foreach $method (@methods)
      {
        $overrides .= sprintf("#  %-12.12s => '-',\n","'$method'");
      }
      $overrides .= "#);\n";
    }
    foreach $method (@methods)
    {
      if ($override{$header}{$where}{$method})
      {
        $u = $override{$header}{$where}{$method};
        push (@htmlusage, "<span title='$header in $method: Manual Override' style='color:white;background-color:green;'>&nbsp;$u&nbsp;</span>");
        if (length($u) < 3) { $u = " $u" }
        push (@usage, $u);
      }
      elsif ($usage{$header}{$where}{$method})
      {
        $u = $usage{$header}{$where}{$method};
        if (length($u) < 3) { $u = " $u" }
        push (@usage, $u);
        push (@htmlusage, "<span title='$header in $method: $whosays{$header}{$where}{$method}'>$u</span>");
      }
      else
      {
        push (@usage, ' ?');
        push (@htmlusage, "<font style='color:white;background-color:red;' title='$header in $method'>&nbsp;?&nbsp;</font>");
        $unknown++;
#        if ($where ne '?') 
#        {
#          $overrides .= "#\$override{'$header'}{'$where'}{'$method'} = '-';\n";
#        }
      }
      $total++;
    }
    if (!defined ($proxy{$header}{$where})) { $proxy{$header}{$where} = '?';}

    $txt .= sprintf ($template, $header, $where, $proxy{$header}{$where}, @usage);

    if ($whosaysproxy{$header}{$where} =~ /manual/i)
    {
      $html .= "<tr style='background-color:green; color:white;'>";
    }
    elsif ($where =~ /\?/)
    {
      $html .= "<tr style='background-color:red; color:white;'>";
    }
    else
    {
      $html .= "<tr>";
    }
    $html .= "<td><span title='$header_from{$header}'>$header</span></td>".
             "<td align='center'><span title='".join(', ',sort keys %{$whosaysproxy{$header}{$where}})."'>$where</span></td>".
             "<td align='center'><span title='".join(', ',sort keys %{$whosaysproxy{$header}{$where}})."'>$proxy{$header}{$where}</span></td>".
             "<td align='center'>".join("</td><td align='center'>",@htmlusage)."</td></tr>\n";
  }
}

$html .= "</table></body></html>";

open (HTML, ">table2.html") || die $!;
print HTML $html;
close (HTML);

open (TXT, ">table2.txt") || die $!;
print TXT $txt;
close (TXT);

print "\n$unknown total unknown cells ($total total) -- table ".
      int(100*(($total-$unknown) / $total))."% complete\n";

#print $overrides;
