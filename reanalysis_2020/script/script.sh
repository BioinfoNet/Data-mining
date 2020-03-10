awk 'BEGIN {FS=","; OFS =","} {
if ($5 == "NA")
	print $0,"closed";
else
	print $0,"open";
}' PMID_PMC_Journal_Year_Kenya.csv > PMID_PMC_Journal_Year_Kenya3.csv 

