#combining the file for data from Kenya pmids and kenya paper for analysis 
sed 's/"//g' ../data/Kenyapmcid2.csv > ../data/Kenyapmcid3.csv
sed 's/,//g' ../data/Kenyapaper2.csv > ../data/Kenyapaper3.csv
awk 'BEGIN {FS=OFS="\t"} NR==FNR {h[$1] = $3; next} {print $0,h[$1]}' ../data/Kenyapmcid3.csv ../data/Kenyapaper3.csv|sed 's/\t/,/g' | sed '1i Pmid,Journal,Year,Month,Pmcid' |sed 2d >../data/PMID_PMC_Journal_Year_Kenya2.csv
