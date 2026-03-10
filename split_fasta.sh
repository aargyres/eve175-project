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

# Iterate through lines of a file
while IFS= read -r line; do
	# Process header lines
	if echo "$line" | grep -q "^>"; then
		# Set filename to first word of header
		FILENAME=$(echo "$line" | sed 's/^>//' | awk '{split($0, words, " ")} END {print words[1]}')
		FILENAME="${FILENAME}.fa"
		# Add header line to file
		echo "$line" > ${OUTDIR}/${FILENAME}
	# Process sequence lines
	else
		echo "$line" >> ${OUTDIR}/${FILENAME}
	fi
done < "$FILE"
