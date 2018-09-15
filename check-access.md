## Check access

Here, we would like to check the ratio of closed and open access publications by Kenyan Authors. 

First, we install Entrez-Direct using conda.

```conda install -c bioconda entrez-direct```

The proposed steps:

Get all the PubMed IDs from the abstracts using the command

``grep 'PMID:' abstracts.txt |cut -f2 -d" " > Papers_PMIDs.txt``

To determine whether the article is openly available, we check if the PMIC id is available. Inspired by [this artice]).

```bash
while read line; 
do 
efetch -db pubmed -id $line -format xml | xtract -pattern ArticleIdList -element ArticleId ; 

done   < Papers_PMIDs.txt| cut -f1,4 >> pmid_pmc_check.txt
```

The above snippet is run as `./fetch_pmc.sh >>pmc_pmid.txt` on the command line. NB: This script is memory intensive, and takes very long to complete. 

Having extracted that information, the next stage is to determine when the paper was published. 

We extracted those details using the bash script:

```
grep 'doi:' abstracts.txt| sed 's/;/./g' |cut -f 2,3 -d'.' |cut -f1 -d':' >Journal_Year.txt
```

Next, we combine these details with the PMIDs into one file using:

`paste -d'.' pmid_pmc.txt Journal_Year.txt |sed "s/\./\\t/g" >PMID_PMC_Journal_Year.txt`

Now we can perform further analysis on the file. 

PMID    PMC    Journal    Year of Publication
30165703    NA     J Infect Dis     2018 Aug 24
30165548    NA     J Infect Dis     2018 Aug 27
30165370    NA     PLoS One     2018 Aug 30
30161172    NA     PLoS One     2018 Aug 30
30161101    NA     MMWR Morb Mortal Wkly Rep     2018 Aug 31
30158702    NA     Nature     2018 Aug 29
30158473    NA     Toxins (Basel)     2018 Aug 29
30157877    PMC6114501     Reprod Health     2018 Aug 29
30157796    PMC6114840     BMC Psychiatry     2018 Aug 29

20012479    NIHMS189797     Planta     1974 Jan
20010179    NA     Oecologia     1973 Jun
20009099    PMC2827511     Evolution     1968 Jun
20007201    PMC2878101     Demography     1967 Jun
20004783    NA     Demography     1967 Mar
20003478    PMC2803188     J Phycol     1966 Sep
20003178    PMC2802588     Am J Clin Nutr     1963 Sep

Where the PMC is not available, the paper could not be freely downloaded.

NB: Papers before 1963 do not contain metadata. We will limit any further analysis to papers published after 1963. After all, that when Kenya attained independence. 