#' @importFrom grid grid.polygon unit
make_pizza_slice <- function(x, y, size,
                             slice_id, num_slices, color, fill, lwd,
                             fontsize, angle_offset = 0) {
  quality <- 128 %/% num_slices
  scale <- 2 * pi / num_slices
  t <- seq((slice_id - 1) * (scale), slice_id * scale, length.out = quality + 1) + angle_offset * pi / 180

  if (num_slices == 1) {
    xs <- unit(cos(t) * 1, "char") + unit(x, "native")
    ys <- unit(sin(t) * 1, "char") + unit(y, "native")
  } else {
    xs <- unit(c(0, cos(t) * 1), "char") + unit(x, "native")
    ys <- unit(c(0, sin(t) * 1), "char") + unit(y, "native")
  }

  grid::polygonGrob(xs, ys, gp = grid::gpar(fill = fill, col = color, lwd = lwd,
                                            fontsize = fontsize),
                     default.units = "native")
}
