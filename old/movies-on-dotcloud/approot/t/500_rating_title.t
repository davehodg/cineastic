

use Test::More;
#use Regexp::Debugger;


my $m = '      0..0012102      39   7.1  "$#*! My Dad Says" (2010) {Corn Star (#1.14)}' ;

my $rating = substr $m, 27, 5 ;
my $title  = substr $m, 32 ;
my $year;

      warn $title ;


($title,$year) = ($title =~ /^(.+?)     # the text
                                     \s       # up to a space
                                      \(      # before a paren
                                       (.+?)  # capture the year
                                      \)      # close paren
                                     .*$      # eat the rest of the string
                                  /x) ;
warn "$rating : $title : $year" ;
done_testing;