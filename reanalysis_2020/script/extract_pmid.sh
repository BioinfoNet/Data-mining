awk 'BEGIN{FS="\t"; OFS="\t"} {print $8,$6,$3,$2,$9}' /home/icipe/Downloads/open_science/data/data2/Kenyapapers.csv |grep "Kenya" |awk 'BEGIN{FS="\t"; OFS="\t"} {print $1,$3,$4,$5}' |sed 's/"//g' |sort -u |sed  1i"Pmid \t Journal \t Year \t Month"  > /home/icipe/Downloads/open_science/data/data2/Kenyapaper2.csv

awk '{print $1}' /home/icipe/Downloads/open_science/data/data2/Kenyapaper2.csv >/home/icipe/Downloads/open_science/data/data2/Kenyapmid.csv 

