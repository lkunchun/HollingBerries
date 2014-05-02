#!/usr/bin/perl 
#
#import libraries
#
#
#
#package HollieBerries;
use strict;
use warnings;
use Getopt::Std;

## default parameters
#
#
use vars qw(*INPUT_HANDLE $test_input_file $usage %opt $skip_char $format_str $test_input_line @input_header);

*INPUT_HANDLE=\*STDIN;
$format_str = 'R%8.2f%s%s\n';
$skip_char = '#';

@input_header = ("Supplier ID","Product Code","Product Description","Delivery Date","Unit Price","Number of Units");


$test_input_line="15,1101,\"Apples 1kg Golden Delicious. The sweetest Apples! Always a favourite. Love, Mrs. Hollingberry\",\"2012/02/15\",1505,5";

$test_input_file="../../produce.csv";


$usage = << "*END*";

#===============================================================================
#
#         FILE:  $ARGV[0]
#
#        USAGE:  ./$ARGV[0] [options] < [input-file] > [output-file] 
#
#  DESCRIPTION:  
#
#      OPTIONS:  -h help
#                -s comment character [ default: \'$skip_char\' ]
#                -p printf formatting string [ default: \"$format_str\" ]
# REQUIREMENTS:  ---
#         BUGS:  ---
#        NOTES:  ---
#       AUTHOR:  lkunchun, eletik97\@gmail.com
#      COMPANY:  J & K, Roos' Cafe
#      VERSION:  1.0
#      CREATED:  05/01/2014 08:27:49 PM
#     REVISION:  ???
#===============================================================================

*END*

getopts('dhs:p:',\%opt);

##print help menu
die "$usage" if defined $opt{'h'};
$skip_char = $opt{'s'} if defined $opt{'s'};
$format_str = $opt{'p'} if defined $opt{'p'};

print "@input_header \n" if defined $opt{'d'};
print "$test_input_line  \n"if defined $opt{'d'};

sub open_input_file {
  my $infile_name = shift;
  open(INFILE, $infile_name) or die "ERROR:  Could not open $infile_name.\n";
}

sub close_input_file {
   close(INPUT_HANDLE);
}

sub cvs_line_to_list {
    #take input as a line of text deliminated by comma and white space and
    #return a list
    my $line_text=shift;
    my @rtn_list;
    @rtn_list = split /\s?,\s?/, $line_text;
    return \@rtn_list; #return array reference, reduce copying
}

sub print_list {
    #takes an array reference and print
    my $list_ref=shift;
    printf $format_str, @$list_ref[()];
}

sub translate_one_line() {
    my ($line_of_text,$cvs_to_list, $print_list) = @_;
    $print_list->($cvs_to_list->($line_of_text));
}

translate_one_line($test_input_line, \&cvs_to_list, \&print_list) if defined $opt{'d'}; 

open_input_file($test_input_file);
while(<INPUT_HANDLE>) {
    if(!($_ =~ /$input_header[0]/)) {
        #skip lines that look like header   
        translate_one_line($_, \&cvs_line_to_list, \&print_list); 
    } 
}
close_input_file();


#################################################################################
##define some default parameters:
#################################################################################

#die 'column not specifies\n' unless defined $opt{'c'};
#die '-c flag acceps only numbers\n' unless ($opt{'c'} =~/[0-9]/);

#$col = $opt{'c'};

#@sorted = ();
#@index = ();

#$delim = '[ \t]+';
#$delim = $opt{'d'} if defined $opt{'d'};


#while(<STDIN>) {

   #chomp;

   #next if (/$skip/); 
   #next if (/^$/);

   #push @sorted, $_;
   #push @index, &get_key($_);
   #next;
   

#}

#$exchange = 1;
#while($exchange > 0) {


   #$exchange = 0;
   #for($jj=0;$jj<$#index;$jj++) {

      #if($index[$jj] > $index[$jj+1]) {

         #$exchange ++;
         ##print STDERR "switch";
         #$temp = $index[$jj];
         #$index[$jj] = $index[$jj+1];
         #$index[$jj+1] = $temp;

         #$temp = $sorted[$jj];
         #$sorted[$jj] = $sorted[$jj+1];
         #$sorted[$jj+1] = $temp;

      #}

   #}

#}

#if (defined $opt{'r'}) {

   #for($ii=$#sorted;$ii >= 0; $ii--) {

      ##print "$index[$ii] $sorted[$ii]\n";
      #print "$sorted[$ii]\n";

   #}
#} 
#else {

   #foreach(@sorted) {
      #print;
      #print "\n";
   #}

#}

#sub get_key() {

   #my $str = shift;
   #my @tokens;

   #@tokens = split /$delim/, $str;
   #die "column $col does not exist\n" unless defined $tokens[$col];
   ##print STDERR "index = $tokens[$col]\n";
   #return $tokens[$col];
 
#}

