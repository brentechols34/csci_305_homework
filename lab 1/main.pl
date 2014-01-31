######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  Brent Echols
#  brentechols34@yahoo.com		
#										
#########################################

# Replace the string value of the following variable with your names.
my $name = "Brent Echols";
my $partner = "Alex Huleatt";


print "CSCI 305 Lab 1 submitted by $name and $partner.\n\n";

# Checks for the argument, fail if none given
if($#ARGV != 0) {
    print STDERR "You must specify the file name as the argument.\n";
    exit 4;
}

# Opens the file and assign it to handle INFILE
open(INFILE, $ARGV[0]) or die "Cannot open $ARGV[0]: $!.\n";


# YOUR VARIABLE DEFINITIONS HERE...

# This loops through each line of the file
@songs = ();
while($line = <INFILE>) {
	$token = $line;

	#get rid of the first part
	$token =~ s/(.*<SEP>)//e;

	#get rid of extra annotations on the last part
	$token =~ s/\[.*\]|\(.*\)//e;
	$token =~ s/([\(\[{\\\/\_\-\:\"‘+=\*]|feat\.).*$//e;


	#eliminate punctuation
	$token =~ s/[^\w\s]//g;

	#eliminate non english songs
	if($token =~ m/^([A-Z]|[a-z]|[0-9]| )+$/) {
		

		#Make lower case
		$token =~ s/(.*)/lc($1)/e;

		#Strip out the dang new line
		$token =~ s/\n//e;

		#filter out stupid words
		$token =~ s/\b(a|an|and|by|for|from|in|of|on|or|out|the|to)\b\s*//g;

		#Add it to the list of songs
		push(@songs, $token);
	}
}

#print "\n\n";

# Close the file handle
close INFILE; 

# At this point (hopefully) you will have finished processing the song 
# title file and have populated your data structure of bigram counts.


%bigram;
foreach (@songs) {
	@name_split = split(/ /, $_);
	$first = "";
	$arr_length = scalar @name_split;
	for (my $i = 1; $i < $arr_length; $i++) {
		my $first = @name_split[$i-1];
		my $second = @name_split[$i];
		$bigram{$first}{$second} = $bigram{$first}{$second} + 1;
	}
}
print "File parsed. Bigram model built.\n\n";

# User control loop
print "Enter a word [Enter 'q' to quit]: ";
$input = <STDIN>;
chomp($input);
while ($input ne "q"){
	# Replace these lines with some useful code
	my @title = ();
	my $current = $input;
	for (my $i = 0; $i<20; $i++) {
		@title[$i] = $current;
		$current = mcw($current);
		if ($current eq '') {
			last;
		}
	}
	foreach $word (@title) {
		print $word." ";
	}
	print "\n";
	print "Enter a word [Enter 'q' to quit]: ";
	$input = <STDIN>;
	chomp($input);
}


##########################################################################
#
#  FUNCTIONS
#
##########################################################################

#
# function for detecting if a character matches the list of 'stop' words
#
sub matchesAny {
	my $str = $_[0];

	foreach $term ('a', 'an', 'and', 'by', 'for', 'from', 'in', 'of', 'on', 'or', 'out', 'the', 'to', 'with') {
		if(matches($str, $term)) {
			return true;
		}
	}

	return false;
}

#
# function for determining if the string matches the specified match
#
sub matches {
	my $str = $_[0];
	my $match = @_[1];

	return $str =~ m/^$match$/;
}

#
# function for finding the most common word for the specified word
#
sub mcw {
	my $word = @_[0];
	$best = '';
	$best_val = 0;
	keys %hash; # reset the internal iterator so a prior each() doesn't affect the loop
	foreach (keys %bigram) {
		$tie_breaker = rand();
		if (($bigram{$word}{$_} > $best_val) || ($bigram{$word}{$_} == $best_val && $tie_breaker > .5 && $best_val != 0)) {	
			$best = $_;
			$best_val = $bigram{$word}{$_};
		}
	}
	return $best;
}

