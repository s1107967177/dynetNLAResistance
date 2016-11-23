#' @export
#' @import "igraph"
#' @import "parallel"
#' @import "doParallel"
#' @import "foreach"
anonymization <- function(g, alpha = 1, beta = 2, gamma = 3) {
  gs.merged <- g$gs.merged
  group.anonymized <- vector(length = length(gs.merged))
  names(group.anonymized) <- names(gs.merged)
  candidate.set <- list()

  cl <- makeForkCluster(detectCores()-1)
  registerDoParallel(cl)
  #---------------------------------------------------------------------------------------------------
  # nedge.num <- sapply(make_ego_graph(g, 1, V(g)$name), function(x) length(E(x)))
  # names(nedge.num) <- V(g)$name
  # id <- NULL
  # nlabel.num <- foreach(id=V(g)$name, .combine = c) %dopar%
  #   length(strsplit(paste(neighbors(g,id)$label, collapse = " "), split = " ")[[1]])
  # names(nlabel.num) <- V(g)$name
  # cat("Length nedge.num : ", length(nedge.num), " Length nlabel.num: ", length((nlabel.num)), "\n")
  #---------------------------------------------------------------------------------------------------
  degree.old <- degree(g)
  while(length(gs.merged)>0) {
    cat("Merged group-set's size: ", length(gs.merged), "\n")
    #' @importFrom "utils" "object.size"
    cat("Vertex number: ", length(V(g)), "\n")
    group <- gs.merged[1]
    gf <- group[[1]]
    gs.merged[1] <- NULL
    uf <- gf[1]
    gf <- gf[-1]
    ui.cost <- foreach(ui=gf,.combine = c) %dopar% cost(g,uf,ui,alpha,beta,gamma)
    names(ui.cost) <- gf
    gf <- names(sort(ui.cost))

    cat("iterating...\n")
    for( ui in rep(gf,2)) {
      result <- anonymize2node(g, uf, ui)
      g <- result$ga
    }

    #---------------------------------------------------------------------------------------------------
    # cat("inspect destroyed\n")
    # nedge.num.new <- sapply(make_ego_graph(g, 1, V(g)$name), function(x) length(E(x)))
    # names(nedge.num.new) <- V(g)$name
    # nlabel.num.new <- foreach(id=V(g)$name, .combine = c) %dopar%
    #   length(strsplit(paste(neighbors(g,id)$label, collapse = " "), split = " ")[[1]])
    # names(nlabel.num.new) <- V(g)$name
    # cat("Length nedge.num : ", length(nedge.num), " Length nlabel.num: ", length((nlabel.num)), "\n")
    #----------------------------------------------------------------------------------------------------
    degree.new <- degree(g)
    destroyed <- setdiff(V(g)[V(g)$anonymized == T]$name, group[[1]])
    # destroyed <- destroyed[!(nedge.num.new[destroyed] == nedge.num[destroyed] & nlabel.num.new[destroyed] == nlabel.num[destroyed])]
    destroyed <- destroyed[degree.new[destroyed]>degree.old[destroyed]]
    if(length(destroyed)>0) {
      cat("Destroyed vertexs: ", destroyed, "\n")
    }
    # nedge.num <- nedge.num.new
    # nlabel.num <- nlabel.num.new
    degree.old <- degree.new
    candidate.set <- c(candidate.set, group)
    group.destroyed <- list()
    for(leader in names(candidate.set)) {
      if(any(candidate.set[[leader]]%in%destroyed)) {
        group.destroyed[[leader]] <- candidate.set[[leader]]
        V(g)[group.destroyed[[leader]]]$anonymized <- F
      }
    }
    if(length(group.destroyed)>0) {
      cat("Destroyed groups: ", names(group.destroyed) ,"\n")
    }
    group.anonymized[names(group.destroyed)] <- F
    group.anonymized[names(group)] <- T
    gs.merged <- c(gs.merged, group.destroyed)
    if(length(group.destroyed)>0) {
      candidate.set[names(group.destroyed)] <- NULL
    }
    cat("Anonymized groups: ",names(group.anonymized[group.anonymized==T]),"\n\n")
  }
  stopCluster(cl)
  return(g)
}
