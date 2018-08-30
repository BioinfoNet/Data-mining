from Bio import Entrez
def paper_retriever(email, searchterm, pubmedid):
    '''The paper retriever function takes your email which uses the same name email as an 
    argument, pubmedid you can get this from the previous function, searchterm take the NCBI type of query as a string.
    
    Return the full paper depending on if it's open access or not.
    '''
    # Enter your own email
    Entrez.email = email
    
    # search NCBI from the particular search term with method esearch
    handle = Entrez.esearch(db="pubmed", term=searchterm)
    
    # get the results
    record = Entrez.read(handle)
    
    # the method efetch does and fetches the information you need brings it back to your Ipython session
    handle2 = Entrez.efetch(db="pubmed", id = pubmedid, rettype="gb",retmode="text")
    
    # using cell magic in a function in the jupyter notebook
    return handle2.read()

paper1 = paper_retriever(email="benmainye@gmail.com", searchterm="[Open science] AND Kenya",pubmedid=30123385)
#%store paper >> papers1.txt
print(paper1)