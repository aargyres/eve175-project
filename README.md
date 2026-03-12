## EVE 175 Project Assignment 12: FASTA File Splitter
Splits a multi-sequence FASTA file into individual files and puts them in a 
specified output directory. 

## Usage 
split_fasta.sh splits an input FASTA file into individual files and writes the 
files to a user-provided output directory.

Usage: ./split_fasta.sh <FASTA file> <output dir>

Example: ./split_fasta.sh example.fa example_dir

## Input Formats
<FASTA file>: file with .fa or .fasta extension in FASTA format; can have one
or more sequences
<output dir>: output directory; can be an existing directory or a new directory

## Output Formats
Puts .fa files in specified output directory.

Prints statement with the names and number of files that were created.
Example Output:
Created: example_dir/gene1.fa
Created: example_dir/gene2.fa
Created: examplee_dir/gene3.fa
Total files created: 3 files 

## Dependencies
split_fasta.sh assumes that the user has permission to read the FASTA file and 
to access the output directory. The script also assumes that the .fa or .fasta 
file follows appropriate FASTA format, with each header line marked with '>' 
and followed by sequence lines. 

## Test Cases
test.sh runs split_fasta.sh and tests 7 different cases:
1. Valid FASTA file with an existing output directory 
2. Valid FASTA file with a new output directory
3. Valid FASTA file with only one word in the header
4. Valid FASTA file with extra spaces in the header
5. A non-existent FASTA file
6. No arguments provided
7. Wrong number of arguments provided
