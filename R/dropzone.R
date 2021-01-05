#' Create a html dropzone.

#' @name dropzone
#' @param ...
#' @return \code{dropzone}: \code{[html]}
#' @export
dropzone <- function(...) {
    # Create a html dropzone
    tag <- div(...) %>% attachDependencies(html_dependency_dropzone(), append = TRUE)
    tag %>% tagAppendAttributes(class = "dropzone")
    # Returns: \code{[html]}
}
