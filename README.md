##SQLi Scan
This is a very small perl script that requires the [Google::Search](http://search.cpan.org/~rokr/Google-Search-0.028/lib/Google/Search.pm) and [LWP::Simple](http://search.cpan.org/~gaas/libwww-perl-6.05/lib/LWP/Simple.pm) modules from CPAN. 

Usage should be pretty obvious, but here is an example or two:

* ./scan.pl inurl:article_id.php?id=
* perl scan.pl inurl:page_index.php?i= vulns.txt
