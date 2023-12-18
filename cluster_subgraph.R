cluster_subgraph=function(seed_graph,vi){
  library(igraph)
  library(writexl)
  subg=induced_subgraph(seed_graph,vi,impl = "auto")
  clusters_subg=cluster_walktrap(subg)
  c=length(clusters_subg)
  tbl=table(membership(clusters_subg))
  get.mean <- function(x){
    mean(V(g1)$degree[x]+(V(g1)$trans[x]))
    
  }
  #write_xlsx(tbl,"D:/PROGRAMS/Comorbidity/gene-exp/al-table1.xlsx")
  print(tbl)
  d_vert=data.frame()
  for (i in 1:c){
  g1 <- induced_subgraph(subg, which(clusters_subg$membership == i))
  nod=
  V(g1)$degree <- degree(g1, loops = TRUE, normalized = TRUE)
  V(g1)$trans <- transitivity(g1, type="localundirected")
  
  g_ngh <- neighborhood(g1, mindist = 1) 
  
  V(g1)$clus_nei <- sapply(g_ngh, get.mean)
  d_vert_attr <- as_data_frame(g1, what = "vertices")
  d_vert=rbind(d_vert,d_vert_attr)
  }
  #write_xlsx(d_vert,"D:/PROGRAMS/Comorbidity/gene-exp/ocidbs-score-table1.xlsx")
  
  #print (d_vert)
  #plot(clusters_subg,subg,col = membership(clusters_subg),mark.groups = communities(clusters_subg),edge.color = c("black", "red")[crossing(clusters_subg, subg) + 1])
  d_vert
}