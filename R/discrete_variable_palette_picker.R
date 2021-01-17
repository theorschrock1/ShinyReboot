#' Create a discrete variable color palette selector.

#' @name discrete_variable_palette_picker
#' @param inputId  \code{[string]}
#' @param var_names  \code{[character]}
#' @param var_ids  \code{[character]}  NULL is ok.  Defaults to \code{NULL}
#' @param colors  \code{[character]}  NULL is ok.  Must have an exact length of \code{length(var_names)}.  Defaults to \code{NULL}
#' @param palette  \code{[choice]}  Possible values: \code{ggthemes_palette_names()}.  NULL is ok.  Defaults to \code{NULL}
#' @return \code{discrete_variable_palette_picker}: \code{[html]}
#' @export
discrete_variable_palette_picker <- function(inputId, var_names, var_ids = NULL, 
    colors = NULL, palette = NULL) {
    # Create a discrete variable color palette selector
    assert_string(inputId)
    assert_character(var_names)
    assert_character(var_ids, null.ok = TRUE)
    assert_character(colors, null.ok = TRUE, len = length(var_names))
    assert_choice(palette, choices = ggthemes_palette_names(), null.ok = TRUE)
    d_names = data.table(palettes_d_names)
    pals <- d_names[package == "ggthemes" & length > 7]
    gg_pals = ggthemes_palette_names()
    if (is.null(palette) && is.null(colors)) {
        tmp <- pals[length >= length(var_names)]
        if (nrow(tmp) == 0) {
            palette = "manyeys"
            colors <- colour_ramp(paletteer_d("ggthemes::manyeys"))(seq(from = 0, 
                to = 1, length.out = length(var_names)))
        } else {
            palette = tmp$palette[1]
        }
    }
    if (is.null(colors)) {
        colors = rep_len(paletteer_d(glue("ggthemes::{palette}")), length.out = length(var_names))
    }
    ms = function(x) paste0(inputId, "_", x)
    color_divs <- lapply(colors, function(x) div(`data-id` = x, class = "sortable_colors border m-1", 
        style = paste0("background-color:", x)))
    var_divs <- map2(var_names, var_ids %or% var_names, function(x, y) div(`data-id` = y, 
        class = "align-content-middle d-flex sortable_vars m-1 w-100 px-1", 
        tags$span(class = "align-self-center", x)))
    out = flexRow(class = "d-pallete-picker w-100", flexRow(class = "bg-white order-1 w-50  m-2  var-div", 
        sortableDiv(class = "selected_colors", color_divs, inputId = ms("selected_colors"), 
            options = sortable_options(name = "sortable_colors", pull = FALSE, 
                swap = T, put = FALSE, sort = TRUE)), sortableDiv(var_divs, 
            class = "flex-fill selected_vars", inputId = ms("selected_vars"), 
            options = sortable_options(name = "sortable_colors", ghostClass = "ghost", 
                pull = FALSE, put = FALSE, sort = TRUE))), flexCol(class = "w-50 p-1", 
        div(class = "w-100 mb-1", h6(class = "small mb-1", "Select Palette:"), 
            discrete_pallete_picker(inputId = ms("palette_picker"), selected = palette)), 
        discrete_palatte_divs(pal = paste0("ggthemes", "::", palette)), tags$button(id = ms("assign_palette"), 
            class = "assign_palette-btn mt-1 py-0 rounded-0 btn btn-sm border btn-light shadow-none", 
            "Assign Palette")))
    out %>% attachDependencies(html_dependency_d_palette_picker(), append = TRUE)
    # Returns: \code{[html]}
}
