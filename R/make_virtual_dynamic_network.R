#' @export
#' @import "igraph"
make.virtual.dynamic.network <- function(file = NULL,
  skip = 0, len = 10 ,by = 50, label.types = 100, prop.init = 0.02, prop.sensitive = 0.1) {
  if(!is.null(file)) {
    #' @importFrom "utils" "read.table"
    network <- read.table(file = file, skip = skip)
    names(network) <- c("from", "to")
    network$from <- paste0("V", network$from)
    network$to <- paste0("V", network$to)
    network <- network[network$from<network$to,]
  }
  g.all <- graph.data.frame(network, directed = F)
  vnum <- length(V(g.all))

  label.names <- paste0("L",1:label.types)
  V(g.all)$label <- sample(label.names, vnum, replace = T)
  V(g.all)$sensitive <- sample(2,vnum,replace = T,prob = c(prop.sensitive, 1-prop.sensitive))
  V(g.all)$anonymized <- F

  id.all <- names(sort(degree(g.all),decreasing = T))
  sp.index <- seq(length(id.all)*prop.init)
  id.current <- id.all[sp.index]
  id.remain <- id.all[-sp.index]
  dynet <- list()
  for (i in seq(len)) {
    dynet[[paste0("t",i)]] <- induced.subgraph(g.all,id.current)
    dynet[[paste0("t",i)]]$label.names <- label.names
    #add vertexs
    add.index <- seq(by)
    id.add <- id.remain[add.index]
    id.remain <- id.remain[-add.index]
    id.current <- c(id.current, id.add)
  }
  class(dynet) <- "dynamic.network"
  return(dynet)
}
