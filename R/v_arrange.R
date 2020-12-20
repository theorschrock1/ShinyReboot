#' Arrange html content.

#' @name v_arrange
#' @param ...
#' @param justify  \code{[choice]}  Possible values: \code{c('start', 'end', 'center', 'between', 'around')}.  Defaults to \code{'around'}
#' @param align  \code{[choice]}  Possible values: \code{c('start', 'end', 'center', 'baseline', 'stretch')}.  Defaults to \code{'center'}
#' @return \code{v_arrange}: \code{[html]}
#' @examples

#'  v_arrange(justify = 'around', align = 'center')
#'  v_arrange(justify = 'start', align = 'start')
#' @export
v_arrange <- function(..., justify = "around", align = "center") {
    # Arrange html content
    assert_choice(justify, choices = c("start", "end", "center", "between", "around"))
    assert_choice(align, choices = c("start", "end", "center", "baseline", "stretch"))
    out <- flexCol(...)
    out %>% tagAppendAttributes(class = glue("w-100 align-items-{align} justify-content-{justify}"))
    # Returns: \code{[html]}
}
