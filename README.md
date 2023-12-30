# TransNet-CGP
A Cluster-Based Comorbid Gene Prioritization by Integrating Transcriptomics and Network-Topological Features

This work proposes a clustering-based computational approach for prioritising the comorbid genes within the overlapping disease modules by analyzing Protein-Protein Interaction networks.

**Sample Data**

* a3h2_graph.RData - contains a human protein-protein physical interaction network derived. This variable is an igraph object. Node names are UniProt identifiers.
* ALS_vec.RData - a vector of UniProt identifiers of proteins previously associated with Amyotrophic Lateral Sclerosis (ALS)
* SMA_vec.RData - a vector of UniProt identifiers of proteins previously associated with Spinal Muscular Atrophy (SMA)
* gene_exp.xlsx - contains the gene expressions

**R code**

#Use gene-pcc.r to find the Pearson's Correlation between the gene pairs.

#The simpmain funcrion is to extract the main connected component of the input network and removing self loops and multiple edges:

``` r
simp_net = simpmain(a3h2_graph)
```

#The seedrows function is used to extract the index of nodes in the list

``` r
index1_als = seedrows(simp_net, ALS_vec)
index2_sma = seedrows(simp_net, SMA_vec)
```

#The Cgp function is used to get the table of ranked genes

``` r
rank_table = Cgp(simp_net,index1-als,index2-sma)
```
