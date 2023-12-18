#' Organize table of results for S2B function



makes2btable=function(complete_results,apid_main,A_index,B_index){
  
  #symblist=vertex_attr(Hs_uniprot2symb_graph(apid_main))
  s2b_apid_2=data.frame(id=complete_results[,1],avgdist=complete_results[,2],DA="candidate")
  s2b_apid_2$DA[A_index]="Disease 1"
  s2b_apid_2$DA[B_index]="Disease 2"
  s2b_apid_2$DA[intersect(A_index,B_index)]="Disease 1/Disease 2"
  library("writexl")
  #write_xlsx(s2b_apid_2,"D:/PROGRAMS/Comorbidity/gene-exp/ocidbc-table-result1.xlsx")
  s2b_apid_2
}
