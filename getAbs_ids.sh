#!/bin/bash

# Suggestion for the search strategy to fetch all papers in PubMed with Kenyan authors
# Considering that all authors (whether main authors or collaborating) are affiliated to
# particular institutions in various countries, we can leverage this to extract papers
# with Kenya in the author affiliation.

esearch -db pubmed -query "Kenya[Affiliation]" | \
	efetch -format abstract > kenpaps.txt
	grep "PMID:" kenpaps.txt | cut -f2 -d' ' > kenpmids.txt
#	| xargs | sed 's/ /,/g' > Kenpmids.txt

# You can uncomment this line and pipe the previous line ```| xargs | sed 's/ /,/g' > Kenpmids.txt```
# to it in order to convert the list of IDs into
# an efetch compartible format (e.g. 26895239,26894324,26893967,26892879)

# If we are only interested in the abstract of all papers with Kenyan authors, then the above
# code that returns the abstract should be enough and no need to fetch the PMIDs.
