#' @importFrom grid grid.polygon
make_pizza_slice <- function(x, y, radius, slice_id, num_slices, color, fill, lwd, angle_offset = 0) {
  quality <- 128 %/% num_slices
  scale <- 2 * pi / num_slices
  t <- seq((slice_id - 1) * (scale), slice_id * scale, length.out = quality + 1) + angle_offset * pi / 180

  if (num_slices == 1) {
    xs <- cos(t) * radius + x
    ys <- sin(t) * radius + y
  } else {
    xs <- c(0, cos(t) * radius) + x
    ys <- c(0, sin(t) * radius) + y
  }

  grid::polygonGrob(xs, ys, gp = grid::gpar(fill = fill, col = color, lwd = lwd),
                     default.units = "native")
}
