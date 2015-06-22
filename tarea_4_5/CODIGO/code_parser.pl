#!/usr/bin/perl

# ---- File: code_parser.pl 
# ------- 
# ------- This script parses code files and outputs a ROM module definition
# ------- when an output file is specified. Else, it outputs through STDOUT
# ------- The instructions and macro definitions separately.

########################################################################
########## Libraries needed
use Getopt::Long; # For reading command line arguments
use strict; 
use warnings;

########################################################################
########## Variables needed

my $line_counter = 0; # Counter for number of lines
my $code_dh; # File handle for code file
my $code_file; # Code file name
my $output_file; # Output file name
my $inst_counter = 0; # Counter for number of instructions
my $instructions; # String with instructions in correct format
my $definitions; # Definitions included in file
my $verbose; # Verbose flag
my $tmp_comment; # String containing comments
my $inline; # String containing parsed line
my @tmp_arguments; # Storing splited line of code

########################################################################
########## Read command line arguments

GetOptions (
	"code=s"	=> \$code_file, # File with the code
	"output=s"	=> \$output_file,
	"verbose"	=> \$verbose,
) or die "\t-E-\t No arguments given. \n"; 

# Check for correct inputs
unless ($code_file) {
	print "\t-E-\t No CODE FILE defined. Nothing more to do.\n";
	exit;
}

########################################################################
########### -- START --

# Open code file 
myprint(">> Opening code file: $code_file \t ");
open (IN_DH, "<", "$code_file") or die "\t-E-\tCould not open file for input: \t $code_file \n";

# Parse file, line per line. Searching for Specific commands
while ($inline = <IN_DH>) {
	# Increase line counter
	$line_counter++;
	# Chomp spaces at the begining and end of line
	$inline =~ s/^\s*//;
	$inline =~ s/\s*$//;

	$inline or next; # In case of empty lines, check next line

	# First, ignore comments. Acepted formats: '# Comment', '// Comment' (This is for lines starting with a comment)
	# Other comments accepted will be after commands and starting with '//'
	if ($inline =~ /^\\\\/) {
		# We substitude '#' with \\ (For verilog compatibility)
		$inline =~ s/^#/\\/;
		$instructions .= "$inline \n";
		next;  
	} 
	# Now for definitions within file (creates a macro)
	elsif ($inline =~ /^(.*define)/) {
		# Add correct format to definition (increases flexibility in coding)
		$inline =~ s/^(.*define)/`define/;
		# In case we try to loop
		if($inline =~ s/\sLOOP$//) {
			$inline .= "\t8'd".($inst_counter);
		}
		# Add definition to definitions string
		$definitions .= "$inline \n";
	} 
	# For the NOP instruction
	else {
		# Obtain comments and  save them in tmp_comment
		$tmp_comment = $inline;
		$tmp_comment =~ s/^.*\s*\/\/// or $tmp_comment =~ s/.*//; # Added in case there is no comments
		$inline =~ s/\s*\/\/.*//;

		# Include NOP code in instructions
		$instructions .= "\t$inst_counter: oInstruction = { `$tmp_arguments[0] , $tmp_arguments[1]};";
		# Increase counter
		$inst_counter++;
		# Add comments
		$instructions .= ($tmp_comment) ? " \\\\ $tmp_comment \n": "\n" ;
		# Next line
		next;
	}

	# FOR VGA
	elsif ($inline =~ /^VGA\s/) {
		# Set and clean $tmp_comment, $inline 
		set_vars();
		
		# Check for correct format
		if ($#tmp_arguments != 3) {
			print "\t-E-\t Wrong number of arguments for VGA instruction. Given $#tmp_arguments, spected: 3 \t Line: <$line_counter> \n";
			exit;
		}
		
		# Include VGA code in instructions
		$instructions .= "\t$inst_counter: oInstruction = { `VGA , $tmp_arguments[1],5'b0 , $tmp_arguments[2], $tmp_arguments[3]  };"; # No need for destination
		# Increase instruction counter
		$inst_counter++;
		# Add comments
		$instructions .= ($tmp_comment) ? " \/\/ $tmp_comment \n": "\n" ;
		# Next line
		next;
	} 
}
# Done with input file.
close(IN_DH);

# Now lets output. In case there is an output file given as a parameter
if ($output_file) {
	# Open output file 
	myprint(">> Creating/overwritting output file: $output_file");
	open (OUT_DH, ">", "$output_file") or die "\t-E-\tCould not open file for OUTPUT: \t $output_file \n";
	# Output string contains the ROM module format.
	my $output_string = "
`timescale 1ns / 1ps
`include \"Defintions.v\"
";
	# Add the definitions in file:
	$output_string .= "$definitions";
	
	# Add the module definition
	$output_string .= "
module ROM
(
	input  wire[15:0]  		iAddress,
	output reg [27:0] 		oInstruction
);	
always @ ( iAddress )
begin
	case (iAddress)
	
";
	# Now add the instructions
	$output_string .= "$instructions\n";
	# Rest of file
	$output_string .= "
	default:
		oInstruction = { `LED ,  24'b10101010 };		//NOP
	endcase	
end
	
endmodule
";

	print OUT_DH $output_string;
	myprint(">> File created correctly.");
	close(OUT_DH);
} else {
	# If no output file is given, output will be printed in terminal
	print ">> Instructions \n\n";
	print "$instructions\n";
	print "\n\n>> Definitions \n\n";
	print "$definitions\n";
}


########################################################################
######### SUBROUTINES
########################################################################

# Verbose printing subroutine (Verbose enables a more detailed print)
sub myprint {
	# Get string to print
	my $tmp_string = shift;
	# If verbose mode is enabled, print string
	$verbose and print "$tmp_string \n";
}

sub set_vars {
	# Obtain comments and  save them in tmp_comment
	$tmp_comment = $inline;
	$tmp_comment =~ s/^.*\s*\/\/// or $tmp_comment =~ s/.*//; # Added in case there is no comments
	$inline =~ s/\s*\/\/.*//;
	
	# Format different spaces to just one space 
	$inline =~ s/\s+/ /g;
	
	# Obtain arguments spliting by space
	@tmp_arguments = split(' ', $inline);
}

