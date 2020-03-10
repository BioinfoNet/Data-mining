#combining the file for data from Kenya pmids and kenya paper for analysis 
awk 'BEGIN {FS=OFS="\t"} NR==FNR {h[$1] = $3; next} {print $0,h[$1]}' Kenyapmcid2.csv Kenyapaper2.csv|sed 's/\t/,/g' | sed '1i Pmid,Journal,Year,Month,Pmcid' |sed 2d >PMID_PMC_Journal_Year_Kenya2.csv
