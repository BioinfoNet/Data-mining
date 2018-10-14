## Suggestion for the search strategy to fetch all papers in PubMed with Kenyan authors 
Considering that all authors (whether main authors or collaborating) are affiliated to
particular institutions in various countries, we can leverage this to extract papers
with Kenya in the author affiliation.

----

```
$ esearch -db pubmed -query "Kenya[Affiliation]" | \
	efetch -format abstract > kenpaps.txt
	grep "PMID:" kenpaps.txt | cut -f2 -d' ' > kenpmids.txt
	#| xargs | sed 's/ /,/g' > Kenpmids.txt
```
---
You can uncomment the line ```| xargs | sed 's/ /,/g' > Kenpmids.txt``` and pipe the previous 
line to it in order to convert the list of IDs into an efetch compartible format 
(e.g. 26895239,26894324,26893967,26892879)

If we are only interested in the abstract of all papers with Kenyan authors, then the above
code that returns the abstract should be enough and no need to fetch the PMIDs.

And from the line count in the _kenpmids.txt file_, we can see there are ***13473*** PMIDs 
relating to the same amount of papers with Kenyan authors.

Also attached is a file of all the abstracts for the 13473 papers.

## Reason for Suggested search Strategy
The search strategy that returned the over 25000 papers was based on searching ***Kenya*** as 
a search term.

That is 
 ```esearch -db pubmed -query "Kenya"```
This strategy searches ***Kenya*** in all fields and medical subject headings of the PubMed 
records and returns the combined results.

That is
 ```"kenya"[MeSH Terms] OR "kenya"[All Fields]```

Hence, we would not have accomplished our goal to fetch only papers that Kenyans are 
invovled in as authors.

---
### Note 
The search strategy ```[Open science] AND Kenya``` translates to 

```
(Open[All Fields] AND ("science"[MeSH Terms] OR 
"science"[All Fields])) AND ("kenya"[MeSH Terms] 
OR "kenya"[All Fields])
```

And it returns only 140 records.
