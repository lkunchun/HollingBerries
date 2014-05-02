:#!/usr/bin/perl 

$usage = << '*END*';

#===============================================================================
#
#         FILE:  $ARGV[0]
#
#        USAGE:  ./$ARGV[0] [options] < [input-file] > [output-file] 
#
#  DESCRIPTION:  
#
#      OPTIONS:  -h help
#                -s comment character [ default: $skip_char ]
#                -p printf formatting string [ default: $format_str ]
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  lkunchun, eletik97@gmail.com
#      COMPANY:  J & K, Roos' Cafe
#      VERSION:  1.0
#      CREATED:  05/01/2014 08:27:49 PM
#     REVISION:  ???
#===============================================================================

*END*

##import libraries
use strict;
use warnings;
use Getopt::Std;

getopts('hs:p:',\%opt);

##print help menu
die "$usage" if defined $opt{'h'};

$skip_char = '#';
$format_str = 'R%8.2f%s%s\\n';

$skip_char = $opt{'s'} if defined $opt{'s'};
$format_str = $opt{'p'} if defined $opt{'p'};

################################################################################
#define some default parameters:
################################################################################

die 'column not specifies\n' unless defined $opt{'c'};
die '-c flag acceps only numbers\n' unless ($opt{'c'} =~/[0-9]/);

$col = $opt{'c'};

@sorted = ();
@index = ();

$delim = '[ \t]+';
$delim = $opt{'d'} if defined $opt{'d'};


while(<STDIN>) {

   chomp;

   next if (/$skip/); 
   next if (/^$/);

   push @sorted, $_;
   push @index, &get_key($_);
   next;
   

}

$exchange = 1;
while($exchange > 0) {


   $exchange = 0;
   for($jj=0;$jj<$#index;$jj++) {

      if($index[$jj] > $index[$jj+1]) {

         $exchange ++;
         #print STDERR "switch";
         $temp = $index[$jj];
         $index[$jj] = $index[$jj+1];
         $index[$jj+1] = $temp;

         $temp = $sorted[$jj];
         $sorted[$jj] = $sorted[$jj+1];
         $sorted[$jj+1] = $temp;

      }

   }

}

if (defined $opt{'r'}) {

   for($ii=$#sorted;$ii >= 0; $ii--) {

      #print "$index[$ii] $sorted[$ii]\n";
      print "$sorted[$ii]\n";

   }
} 
else {

   foreach(@sorted) {
      print;
      print "\n";
   }

}

sub get_key() {

   my $str = shift;
   my @tokens;

   @tokens = split /$delim/, $str;
   die "column $col does not exist\n" unless defined $tokens[$col];
   #print STDERR "index = $tokens[$col]\n";
   return $tokens[$col];
 
}

