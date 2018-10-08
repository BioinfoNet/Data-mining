from Bio import Entrez
def paper_parser(term, identity):
    Entrez.email = "benmainye@gmail.com" #use your email
    handle = Entrez.esearch(db="pubmed", term=identity)
    record = Entrez.read(handle)
    print (record)
    handle2 = Entrez.esummary(db="pubmed", id = identity)
    record2 = Entrez.read(handle2)
    print("Extract interesting entries in the data")
    print("")
    print(record2[0]['Id'])
    print("")
    print(record2[0]['Title'])
    print("")
    print(record2[0]['AuthorList'])
    print("")
    print(record2[0]['FullJournalName'])
    print("")
    print(record2[0]['EPubDate'])
    return record2

paper2 = paper_parser(term="[Open science] AND Kenya", identity=30123385)
#%store paper2 >> papers2.txt run in ipython session
print(paper2)