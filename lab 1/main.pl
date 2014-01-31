######################################### 	
#    CSCI 305 - Programming Lab #1		
#										
#  < Replace with your Name >			
#  < Replace with your Email >			
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

	#eliminate non english Text
	if($token =~ m/^([A-Z]|[a-z]|[0-9]| )+$/) {
		

		#Make lower case
		$token =~ s/(.*)/lc($1)/e;

		#print "$token";

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
	@name_split = split(" ", $_);
	$first = "";
	foreach $second (@name_split) {
		if ($first ne "") {
			$bigram{$first}{$second} = $bigram{$first}{$second} + 1;
		}
		$first = $second;
	}
}

sub mcw {
	my $word = @_[0];
	#my %bigram = %{@_[1]};
	$best = '';
	$best_val = 0;
	keys %hash; # reset the internal iterator so a prior each() doesn't affect the loop
	foreach (keys %bigram) {
		if ($bigram{$word}{$_} > $best_val) {	
			$best = $_;
			$best_val = $bigram{$word}{$_};
		}
	}
	return $best;
}

$mcw = mcw("love", \%bigram);
print "Most common word after love is $mcw \n";
print "File parsed. Bigram model built.\n\n";



#print matchesAny('anasdf')];

sub matchesAny {
	my $str = $_[0];

	foreach $term ('a', 'an', 'and', 'by', 'for', 'from', 'in', 'of', 'on', 'or', 'out', 'the', 'to', 'with') {
		if(matches($str, $term)) {
			return true;
		}
	}

	return false;
}

sub matches {
	my $str = $_[0];
	my $match = @_[1];

	return $str =~ m/^$match$/;
}



# User control loop
print "Enter a word [Enter 'q' to quit]: ";
$input = <STDIN>;
chomp($input);
print "\n";	
while ($input ne "q"){
	# Replace these lines with some useful code
	print "Not yet implemented.  Goodbye.\n";
	$input = 'q';
}

# MORE OF YOUR CODE HERE....