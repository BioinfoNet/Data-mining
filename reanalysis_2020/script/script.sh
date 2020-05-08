awk 'BEGIN {FS=","; OFS =","} {
if ($5 == "NA")
	print $0,"closed";
else
	print $0,"open";
}' ../data/PMID_PMC_Journal_Year_Kenya2.csv | sed '1i Pmid,Journal,Year,Month,Pmcid,Status' |sed 2d  > ../data/PMID_PMC_Journal_Year_Kenya3.csv 

