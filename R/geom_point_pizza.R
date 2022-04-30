#' @importFrom ggplot2 ggproto Geom aes
#' @importFrom dplyr mutate `%>%` group_by
#' @export
GeomPointPizza <- ggplot2::ggproto(
  `_class` = "GeomSimplePoint",
  `_inherit` = ggplot2::Geom,
  required_aes = c("x", "y"),
  default_aes = ggplot2::aes(shape = 19, colour = "black", stroke = 1, alpha = 1, fill = "white", size = 0.5),
  draw_key = ggplot2::draw_key_point,

  draw_panel = function(data, panel_params, coord) {
    coords <- coord$transform(data, panel_params) %>%
      group_by(x, y) %>%
      mutate(slice_id = 1:n(),
             num_slices = n()) %>%
      as.data.frame()

    grobs = lapply(
      1:nrow(coords),
      \(i) make_pizza_slice(
        x = coords[i, 'x'],
        y = coords[i, 'y'],
        radius = coords[i, 'size'] * .pt / 100,
        slice_id = coords[i, 'slice_id'],
        num_slices = coords[i, 'num_slices'],
        color = ggplot2::alpha(coords[i, 'colour'], coords[i, 'alpha']),
        fill = ggplot2::alpha(coords[i, 'fill'], coords[i, 'alpha']),
        lwd = coords[i, 'stroke'] * .stroke/2
      )
    )
    grid::gTree("pizza_grob", children = do.call(grid::gList, grobs))
  }
)

#' @importFrom ggplot2 layer
#' @export
geom_point_pizza <- function(mapping = NULL, data = NULL, stat = "identity",
                              position = "identity", na.rm = FALSE, show.legend = NA,
                              inherit.aes = TRUE, ...) {
  ggplot2::layer(
    geom = GeomPointPizza, mapping = mapping,  data = data, stat = stat,
    position = position, show.legend = show.legend, inherit.aes = inherit.aes,
    params = list(na.rm = na.rm, ...)
  )
}
