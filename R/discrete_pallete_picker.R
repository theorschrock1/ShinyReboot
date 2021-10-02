#' create a discrete color palette picker.

#' @name discrete_pallete_picker
#' @param inputId  \code{[string]}
#' @param package  \code{[subset]}  Defaults to \code{'ggthemes'}
#' @param min_colors  \code{[integerish]}  Defaults to \code{7}
#' @param selected  \code{[choice]}  Possible values: \code{palette_names}.  Defaults to \code{NULL}
#' @return \code{discrete_pallete_picker}: \code{[html]}
#' @examples

#'  discrete_pallete_picker(inputId = 'myid')
#' @export
discrete_pallete_picker <- function(inputId, package = "ggthemes", min_colors = 7, selected = NULL) {
    # create a discrete color palette picker
    palnames = as.data.table(paletteer::palettes_d_names)
    assert_string(inputId)
    assert_subset(package, choices=palnames$package)
    assert_integerish(min_colors)
    pt = palnames[palnames$package %in% "ggthemes" & palnames$length > 7, ]
    pals <- paste0(pt$package, "::", pt$palette)
    names = str_replace_all(pt$palette, "_", " ")
    palette_names = pt$palette
    display = function(pal, name) {
        out = as.character(paletteer_d(pal))
        inner = glue("<div class='flex-fill' style='background-color:{out};min-width:20%;'></div>") %sep%
            ""
        glue("<div class='d-flex h-100'><div class='palette d-flex align-self-stretch flex-wrap' style='width:20px;'> {inner}</div><div class='ml-1'>{name}</div></div>")
    }
    disp <- map2(pals, names, display) %>% unlist()
    if (nnull(selected)) {
        assert_choice(selected, choices = palette_names)
    }
    select_picker(inputId, selected = selected %or% palette_names[1], choices = palette_names, display_content = disp,
        width = "100%", class = "border-top-0 border-right-0 border-left-0")
    # Returns: \code{[html]}
}
