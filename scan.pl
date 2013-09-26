#!/usr/bin/perl
use warnings;
use strict;

use Google::Search;
use LWP::Simple;
use URI;

if( @ARGV < 1 ) {
 print "./scan.pl dork <outfile>\n";
 exit;
}

my ($dork, $out) = @ARGV;
if($out) {
  open(FILE, '>>' . $out);
}

my @list; 
my $found = 0;
my $insert = 0;
my $content = 0;
my $search = Google::Search->Web( query => $dork );

while ( my $result = $search->next ) {
  my $page = $result->uri . "'";
  my $content = get($page) or next;
  foreach my $line (split("\n", $content)) {
    if ($line =~ m/SQL/) {
      $found = 1;
    } 
  }
  if($found == 1) {
    print "  [+] $page\n";
    my $url = URI->new($page);
    my $domain = $url->host;
    foreach(@list) {
      my $testurl = URI->new($_);
      my $testdomain = $testurl->host;
      if($domain eq $testdomain) {
        $insert = 1;
      }
    }
    if ($insert == 0) {
      push(@list, $page);
    }
    $insert = 0;
  } else {
    print "[-] $page\n";
  }  
  $found = 0;
}

print "\n[*] Unique results found\n";
foreach (@list) {
  print "$_\n";
  if($out) {  
    print FILE "$_\n";
  }
}
close(FILE);
