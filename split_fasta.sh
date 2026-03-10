#!/bin/bash
# Splits a multi-sequence FASTA file into individual files

# Check if exactly two arguments provided
if [[ ! $# -eq 2 ]]; then
        echo "Usage: $0 <FASTA file> <output dir>"
        exit 1
fi

FILE=$1
OUTDIR=$2

# Check if file is a FASTA file
if $(echo "$FILE" | grep -Eqv "^*.fasta$") && $(echo "$FILE" | grep -Eqv "^*.fa$"); then
	echo "Error: Input file '$FILE' is not a FASTA file" >&2
	exit 1
fi

# Check if file exists
if [ ! -f "$FILE" ]; then
	echo "Error: Input file '$FILE' not found" >&2
	exit 1
fi

# Check if output directory exists
if [ ! -d "$OUTDIR" ]; then 
	# Create output directory if it does not exist
	mkdir "$OUTDIR"
fi
