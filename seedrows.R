#' Find set of node ids in graph


seedrows=function(seed_graph,seedvec){
  vertexlist=unlist(igraph::vertex_attr(seed_graph))
  rowindex=which(is.element(vertexlist,seedvec))
}
