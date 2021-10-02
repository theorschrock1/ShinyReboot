#' Generate a default color picker.

#' @name default_color_picker
#' @param inputId  \code{[string]}
#' @param value  \code{[string]}  All non-missing elements must comply to regex pattern \code{'''^#'''}.  NULL is ok.  Defaults to \code{'#ffffff'}
#' @param width  \code{[string]}  All non-missing elements must comply to regex pattern \code{'''\\d+px$|\\%$'''}.  Defaults to \code{'25px'}
#' @param height  \code{[string]}  All non-missing elements must comply to regex pattern \code{'''\\d+px$'''}.  Defaults to \code{'25px'}
#' @param ...
#' @return \code{default_color_picker}: \code{[html]}
#' @export
default_color_picker <- function(inputId, value = NULL, width = "25px", height = "25px",
    ...) {
    # Generate a default color picker
    assert_string(inputId)
    assert_string(value, pattern = "^#", null.ok = TRUE)
    assert_string(width, pattern = "\\d+px$|\\%$")
    assert_string(height, pattern = "\\d+px$")
    wd_ht = glue("width:{width};height:{height};")
    tags$input(type = "color", class = "default-color-picker", id = inputId,`data-value` = value%or%'#ffffff',style = wd_ht) %>% tagAppendAttributes(...) %>% attachDependencies(html_dependency_default_color_picker())
    # Returns: \code{[html]}
}
