while read line; 
do 
efetch -db pubmed -id $line -format xml | xtract -pattern ArticleIdList -element ArticleId ; 

done   < ../Data/Papers_PMIDs.txt| cut -f1,4 >> ../Data/pmid_pmc_check.txt