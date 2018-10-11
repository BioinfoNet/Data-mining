## Check access

Here, we would like to check the ratio of closed and open access publications by Kenyan Authors. 

First, we install Entrez-Direct using conda.

```conda install -c bioconda entrez-direct```

The proposed steps:

Get all the PubMed IDs from the abstracts using the command

``grep 'PMID:' abstracts.txt |cut -f2 -d" " > Data/Papers_PMIDs.txt``

To determine whether the article is openly available, we check if the PMIC id is available. Inspired by [this artice]).

```bash
while read line; 
do 
efetch -db pubmed -id $line -format xml | xtract -pattern ArticleIdList -element ArticleId ; 

done   < Data/Papers_PMIDs.txt| cut -f1,4 >> Data/pmid_pmc_check.txt


```

The above snippet is run as `./fetch_pmc.sh >> Data/pmc_pmid.txt` on the command line. NB: This script is memory intensive, and takes very long to complete. 

Having extracted that information, the next stage is to determine when the paper was published. 

We extracted those details using the bash script:

```
grep 'doi:' abstracts.txt| sed 's/;/./g' |cut -f 2,3 -d'.' |cut -f1 -d':' >Data/Journal_Year.txt
```
Turns out the above command doesn't get us all the papers. So we are testing a new apprach:

```
grep '^[1-9]*[0-9]*[0-9]\. ' abstracts.txt | grep '\. [1-2]' >prelim_headers 
```

The `prelim_headers` file contains preliminary header info, from which we would want to etract the journal and date of publication details. However, this file is missing data for some PMIDs. Therefore, we are exploring the use of `awk` to extract the PMID and journal info so that they can be safely joined to the `pmid_pmc_check.txt` file. 

#### Retracted papers
we also note that retracted articles exits, which wil not be captured by our commands above. 


##### Combine the files
Next, we combine these details with the PMIDs into one file using:

`paste -d'.' Data/pmid_pmc.txt Data/Journal_Year.txt |sed "s/\./\\t/g" >Data/PMID_PMC_Journal_Year.txt`

Now we can perform further analysis on the file. 
```
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
```
Where the PMC is not available, the paper could not be downloaded for free.

NB: Papers before 1963 do not contain metadata. We will limit any further analysis to papers published after 1963. After all, that when Kenya attained independence. 