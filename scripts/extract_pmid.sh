awk 'BEGIN{FS="\t"; OFS="\t"} {print $8,$6,$3,$2,$9}' ../data/Kenyapapers.csv |grep "Kenya" |awk 'BEGIN{FS="\t"; OFS="\t"} {print $1,$3,$4,$5}' |sed 's/"//g' |sort -u |sed  1i"Pmid \t Journal \t Year \t Month"  > ../data/Kenyapaper2.csv

awk '{print $1}' ../data/Kenyapaper2.csv >../data/Kenyapmid.csv 

