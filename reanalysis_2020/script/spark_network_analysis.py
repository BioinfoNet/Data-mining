# current version of spark
spark version 2.4.4

# initialize the graphframes package on terminal
# make sure you have installed spark first
bash pyspark --packages graphframes:graphframes:0.6.0-spark2.3-s_2.11

# import relevant packages
from graphframes import *
from pyspark.sql import functions as F
from pyspark import SparkContext

# load vertices and edges
# use spark.read.csv and take the first row to be the header
v = spark.read.csv("../data/nodes.csv", header = True)

# now load the relationships dataframe
e = spark.read.csv("../data/relationships.csv", header = True)

# make a graphframe
g = GraphFrame(v, e)

# define degree centrality 
# find the total degree
total_degree = g.degrees
in_degree = g.inDegrees
out_degree = g.outDegrees

# finding popularity in individual nodes in terms of outgoing and incoming relationships
(total_degree.join(in_degree, "id", how = "left").join(out_degree, "id", how="left").fillna(0).sort("inDegree", ascending=False).show())
degree_cen = total_degree.join(in_degree, "id", how = "left").join(out_degree, "id", how="left").fillna(0).sort("inDegree", ascending=False)

# save the file your directory
degree_cen.coalesce(1).write.csv("../data/popularity_scores.csv")

# find influence in a network: page rank
# adjust the restProbability and put a low maxIter: you may get better results with more iterations
results = g.pageRank(resetProbability=0.15, maxIter = 100)

# find the most influential nodes with this 
pageRankres = results.vertices.sort("pagerank", ascending=False)

# store the results to disk
pageRankres.coalesce(1).write.csv("../data/pagerank_scores.csv")

# cohesiveness of a specific group or your overall network
# result not useful due to the nature of the graph
result = g.triangleCount()
(result.sort("count", ascending=False)
.filter('count > 0')
.show())

# strongly connected components
# adjust the max iterations 
contCompS = g.stronglyConnectedComponents(maxIter=10)

# sort by component, arrange by component that exists, use a custom aggregation function collect_list and rename id to pmid
# see the full contents of the dataframe
(contCompS.sort("component")
.groupby("component")
.agg(F.collect_list("id").alias("pmid"))
.show(31,truncate=False))

# store the results for later interpretation
# copy the results to a file

# connected components
contComp = g.connectedComponents()
(contComp.sort("component")
.groupby("component")
.agg(F.collect_list("id").alias("pmid"))
.show(truncate=False))

# label propagation 
# finds community detection
# subset to show first 30 results
labelP = g.labelPropagation(maxIter=10)
(labelP
.sort("label")
.groupby("label")
.agg(F.collect_list("id"))
.show(31,truncate=False))

# copy paste results to a file
