#' @export
#' @import "igraph"
cost <- function(g, uid, vid, alpha = 1, beta = 2, gamma = 3) {
  anony.info <- anonymize2node(g, uid, vid)
  lgc <- function(id) {
    ga <- anony.info$ga
    g.label <- strsplit(V(g)[id]$label, split =  " ")[[1]]
    ga.label <- strsplit(V(g)[id]$label, split = " ")[[1]]
    1-length(intersect(g.label, ga.label))/length(union(g.label, ga.label))
  }
  etdiff <- length(E(anony.info$guva))-length(E(anony.info$guv))
  vtdiff <- length(V(anony.info$guva))-length(V(anony.info$guv))
  lgc.sum <- sum(sapply(V(anony.info$guv)$name,lgc))
  return(alpha*lgc.sum+beta*etdiff+gamma*vtdiff)
}
