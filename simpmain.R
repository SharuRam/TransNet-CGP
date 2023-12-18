#' Simplify network




simpmain=function(seed_graph){
  seed_graph_simp=igraph::simplify(seed_graph)
  library(igraph)
  #library(readr)
  library(base)
  
  dat<-read.csv(file.choose(),header=FALSE,encoding = "UTF-8")#choose file with pcc of edges
  for (i in 2:nrow(dat)) {
    eachline<-dat[i,]
    #ans <- unlist(strsplit(eachline, ","))[2]
    col1<-unlist(strsplit(as.character(eachline), ","))[1]
    col2<-unlist(strsplit(as.character(eachline),","))[2]
    weight1<-unlist(strsplit(as.character(eachline),","))[3]
    #print(col1)
    ed=as_data_frame(seed_graph_simp,what = "edges")
    #print(match(col1,ed$from))
    if(idval1<-match(col1,ed$from,nomatch = 0)!=0){
      if(idval2<-match(col2,ed$to,nomatch = 0)!=0){
        E(seed_graph_simp)[idval2]$weight<-weight1
      }
    }
  }
  #d_edge_attr <- as_data_frame(seed_graph_simp, what = "edges")
  seed_comp=igraph::components(seed_graph_simp)#divide el grafo en subgrafos
  main_id=which.max(seed_comp$csize)
  seed_graph_maincomp=igraph::induced_subgraph(seed_graph_simp,seed_comp[[1]]==main_id)
  seed_graph_maincomp
  #library(igraph)
  # write_graph(seed_graph,"C:/Users/hp/Documents/Comorbidity/S2B-master-original/Output/interactome1.txt",format = c("edgelist"))
}


