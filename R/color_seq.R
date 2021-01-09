#' Create a color sequence.

#' @name color_seq
#' @param colors  \code{[character]}
#' @param from  \code{[number]}  Must be greater than \code{0}.  Must be less than \code{1}.
#' @param to  \code{[number]}  Must be greater than \code{from}.  Must be less than \code{1}.
#' @param length  \code{[number]}
#' @return \code{color_seq}: \code{[character]} A character vector of hex colors
#' @examples

#'  color_seq(colors = c('white', 'purple'), from = 0.25, to = 1,
#'  length = 3)
#' @export
color_seq <- function(colors, from, to, length) {
    # Create a color sequence
    assert_character(colors)
    assert_number(from, lower = 0, upper = 1)
    assert_number(to, lower = from, upper = 1)
    assert_number(length)
    ramp <- colour_ramp(colors)
    ramp(seq(from, to, length = length))
    # Returns: \code{[character]} A character vector of hex colors
}
