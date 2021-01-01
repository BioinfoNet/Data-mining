#!/bin/bash

# Suggestion for the search strategy

esearch -db pubmed -query "Kenya[Affiliation]" | \
	efetch -format abstract > kenpaps.txt
	grep "PMID:" kenpaps.txt | cut -f2 -d' ' > kenpmids.txt
#	| xargs | sed 's/ /,/g' > Kenpmids.txt

