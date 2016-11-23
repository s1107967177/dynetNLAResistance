#' @export
#' @import "igraph"
draw.graph <- function(g,center) {
  label.names <- unique(V(g)$label)
  #' @importFrom "grDevices" "rainbow"
  colbar <- rainbow(length(label.names))
  names(colbar) <- label.names
  plot.igraph(g, main = center,
          vertex.label = V(g)$name,
          vertex.color = colbar[V(g)$label],
          vertex.shape = c("rectangle", "circle")[V(g)$sensitive])
}
