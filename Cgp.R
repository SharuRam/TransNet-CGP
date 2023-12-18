#' Cgp main function

Cgp=function(seed_graph,index1,index2){
  library(igraph)
  meandist=igraph::mean_distance(seed_graph,weights = NA)
  meandist
  betweencount=rep(0,igraph::gorder(seed_graph)) #lista del tama??o de seed_graph
  seedmat1=matrix(data=0,nrow=igraph::gorder(seed_graph),ncol=length(index1))
  seedmat2=matrix(data=0,nrow=igraph::gorder(seed_graph),ncol=length(index2))
  sp1=igraph::distances(seed_graph,v=index1,to=igraph::V(seed_graph))
  sp2=igraph::distances(seed_graph,v=index2,to=igraph::V(seed_graph))
  sp1[sp1==Inf]=igraph::vcount(seed_graph)
  sp2[sp2==Inf]=igraph::vcount(seed_graph)
  sp=sp1[,index2]
  maxbc=sum(sp>0 & sp<meandist)
  betweensub=union(index1,index2)
  for (i in 1:length(index1)){
    for (j in 1:length(index2)){
      m=sp1[i,index2[j]]
      if (m<meandist){
        sumsp=sp1[i,]+sp2[j,]
        nodelist=which(sumsp==m) # aquellos que cumplan la condicion, seran nodos presentes en un sh_path y seran a??adidos a nodelist
        betweencount[nodelist]=betweencount[nodelist]+1
        seedmat1[nodelist,i]=1
        seedmat2[nodelist,j]=1
      }else {
        nodelist=c(index1[i],index2[j])
        betweencount[nodelist]=betweencount[nodelist]+1
      }
    }
  }
  betweencount[index1]=betweencount[index1]-length(index2)
  betweencount[index2]=betweencount[index2]-length(index1)
  betweencount[intersect(index1,index2)]=betweencount[intersect(index1,index2)]+1
  betweencount=betweencount/maxbc
  vertindex=which(betweencount>0)
  clus=cluster_subgraph(seed_graph,vertindex)
  sc=clus$clus_nei
  #subg=induced_subgraph(seed_graph,vertindex,impl = "auto")
  #clusters_subg=cluster_walktrap(subg)
  #c=length(clusters_subg)
  #tbl=table(membership(clusters_subg))
  #plot(clusters_subg,subg,col = membership(clusters_subg),mark.groups = communities(clusters_subg),edge.color = c("black", "red")[crossing(clusters_subg, subg) + 1])
  bigvertexlist=igraph::vertex_attr(seed_graph)
  allstat=data.frame(protein=bigvertexlist[[1]],bcount=betweencount) ####
  cgptable=makes2btable(allstat,seed_graph,index1,index2)
  list(cgptable=cgptable,smat1=seedmat1,smat2=seedmat2,maxS2B=maxbc,scores=clus)
}

  