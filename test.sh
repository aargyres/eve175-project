#!/bin/bash
# Runs test cases for split_fasta.sh

PASS=0
FAIL=0

run_split_fasta() {
	~/programming_project/eve175-project/split_fasta.sh $@ 2> /dev/null
}

# Test Case 1: Valid FASTA file with existing output directory
FASTA=~/programming_project/data/combined.fa
OUTDIR=/tmp/test1

# Create output directory test1 if it does not already exist
if [ ! -d "$OUTDIR" ]; then
	mkdir "$OUTDIR"
fi

EXPECTED="Created: /tmp/test1/geneA.fa
Created: /tmp/test1/geneB.fa
Created: /tmp/test1/geneC.fa
Created: /tmp/test1/geneD.fa
Created: /tmp/test1/geneE.fa
Created: /tmp/test1/geneF.fa
Created: /tmp/test1/geneG.fa
Created: /tmp/test1/geneH.fa
Created: /tmp/test1/geneI.fa
Created: /tmp/test1/geneJ.fa
Created: /tmp/test1/geneK.fa
Total files created: 11"

# Run split_fasta.sh
OUTPUT=$(run_split_fasta $FASTA $OUTDIR)

# See if output matches expected output
if [ "$OUTPUT" == "$EXPECTED" ]; then
	echo "PASS: correct output for valid FASTA file and existing output directory"
	((PASS++))
else
	echo "FAIL: wrong output for valid FASTA file and existing output directory"
	((FAIL++))
fi

# Test Case 2: Valid FASTA file with new output directory
OUTDIR=/tmp/test2
# Remove output directory test2 if it already exists
if [ -d "$OUTDIR" ]; then
	rm -rf "$OUTDIR"
fi

EXPECTED="Created: /tmp/test2/geneA.fa
Created: /tmp/test2/geneB.fa
Created: /tmp/test2/geneC.fa
Created: /tmp/test2/geneD.fa
Created: /tmp/test2/geneE.fa
Created: /tmp/test2/geneF.fa
Created: /tmp/test2/geneG.fa
Created: /tmp/test2/geneH.fa
Created: /tmp/test2/geneI.fa
Created: /tmp/test2/geneJ.fa
Created: /tmp/test2/geneK.fa
Total files created: 11"

# Run split_fasta.sh
OUTPUT=$(run_split_fasta $FASTA $OUTDIR)


# See if output matches expected output
if [ "$OUTPUT" == "$EXPECTED" ]; then
	echo "PASS: correct output for valid FASTA file and new output directory"
	((PASS++))
else
	echo "FAIL: wrong output for valid FASTA file and new output directory"
	((FAIL++))
fi

# Test Case 3: FASTA file header with only 1 word (no spaces)
cat > /tmp/test_header.fa << 'EOF'
>gene1
ATGGT
EOF

FASTA=/tmp/test_header.fa
OUTDIR=/tmp/test3

# Run split_fasta.sh
EXPECTED="Created: /tmp/test3/gene1.fa
Total files created: 1"
OUTPUT=$(run_split_fasta $FASTA $OUTDIR)

# See if output matches expected output
if [ "$OUTPUT" == "$EXPECTED" ]; then
	echo "PASS: correct output for FASTA file with one word header"
	((PASS++))
else
	echo "FAIL: wrong output for FASTA file with one word header"
	((FAIL++))
fi

# Test Case 4: FASTA file header with extra spaces
cat > /tmp/test_spaces_header.fa << 'EOF'
> gene1  Homo  sapiens
TTGAC
EOF

FASTA=/tmp/test_spaces_header.fa
OUTDIR=/tmp/test4

# Run split_fasta.sh
EXPECTED="Created: /tmp/test4/gene1.fa
Total files created: 1"
OUTPUT=$(run_split_fasta $FASTA $OUTDIR)

# See if output matches expected output
if [ "$OUTPUT" == "$EXPECTED" ]; then
	echo "PASS: correct output for FASTA file with extra spaces in header"
	((PASS++))
else
	echo "FAIL: wrong output for FASTA file with extra spaces in header"
	((FAIL++))
fi

# Test Case 5: Non-existent FASTA file with an output directory
FASTA=~/non_existent.fa
OUTDIR=/tmp/test5

# Make sure FASTA file does not exist
if [ -f "$FASTA" ]; then
	rm "$FASTA"
fi

# Run split_fasta.sh
OUTPUT=$(run_split_fasta $FASTA $OUTDIR)

# See if output matches expected output
if [ $? -eq 1 ]; then
	echo "PASS: exits with error for non-existent file"
	((PASS++))
else
	echo "FAIL: should exit with error for non-existent file"
	((FAIL++))
fi

# Test Case 6: No arguments
EXPECTED="Usage: /eve175-home/e175st21/programming_project/eve175-project/split_fasta.sh <FASTA file> <output dir>"

# Run split_fasta.sh
OUTPUT=$(run_split_fasta)

# See if output matches expected output
if [ $? -eq 1 ] && [ "$OUTPUT" == "$EXPECTED" ]; then
	echo "PASS: exits with usage statement for no arguments"
	((PASS++))
else
	echo "FAIL: should exit with usage statement for no arguments"
	((FAIL++))
fi

# Test Case 7: Wrong number of arguments
FASTA=~/programming_project/data/combined.fa
EXPECTED="Usage: /eve175-home/e175st21/programming_project/eve175-project/split_fasta.sh <FASTA file> <output dir>"

# Run split_fasta.sh
OUTPUT=$(run_split_fasta $FASTA test7 random)

# See if output matches expected output
if [ $? -eq 1 ] && [ "$OUTPUT" == "$EXPECTED" ]; then
	echo "PASS: exits with error for wrong number of arguments"
	((PASS++))
else
	echo "FAIL: should exit with error for wrong number of arguments"
	((FAIL++))
fi

# Clean up
rm -rf /tmp/test1 /tmp/test2 /tmp/test3 /tmp/test4 /tmp/test_header.fa /tmp/test_spaces_header.fa

# Display how many test cases passed and failed
echo ""
echo "Results: $PASS passed, $FAIL failed"

