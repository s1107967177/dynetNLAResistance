#' @export
#' @import "igraph"
lw.grouping <- function(dynet, l = 2, w = 3) {
  noise = 0
  gs.table <- list()
  dynet.grouped <- list()
  for (i in seq(length(dynet))) {
    result <- global.similarity.grouping(dynet[[i]],l,gs.table = gs.table,noise,i)
    noise <- result$noise
    gs.table <- c(gs.table,list(result$gs))
    if (i>w) gs.table[[1]] <- NULL
    dynet.grouped[[paste0("t",i)]] <- merged.groups(result$grouped.graph,gs.table)
    dynet.grouped[[paste0("t",i)]]$noise <- noise
  }
  class(dynet.grouped) <- "dynamic.network.grouped"
  return(dynet.grouped)
}
