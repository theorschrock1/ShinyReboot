#' create html color picker.

#' @name ao_color_picker
#' @param ...
#' @param inputId  \code{[string]}
#' @param color  \code{[choice]}  Possible values: \code{unique(c(black(), dgreys(), white(), lgreys(), oranges(), purples(), yellows(), l_purples(),l_greens(), pinks(), d_greens(), reds(), l_blues(), browns(), blues(), bgreys()))}.  Defaults to \code{'#0A5ED3'}
#' @param opacity  \code{[number]}  Must be greater than \code{0}.  Must be less than \code{1}.  Defaults to \code{0}
#' @return \code{ao_color_picker}: \code{[html]}
#' @export
ao_color_picker <- function(..., inputId, color = "#0A5ED3", opacity = 0) {
    # create html color picker
    assert_string(inputId)
    assert_choice(color, choices = unique(c(black(), dgreys(), white(), lgreys(), oranges(), purples(), 
        yellows(), l_purples(), l_greens(), pinks(), d_greens(), reds(), l_blues(), browns(), 
        blues(), bgreys())))
    assert_number(opacity, lower = 0, upper = 1)
    out <- div(id = inputId, class = "w-100", h_arrange(class = "my-1", div(class = "color-label px-1 text-secondary", 
        "Color"), div(class = "border-top border-secondary w-100")), h_arrange(color_picker_col(list(black(), 
        dgreys())), color_picker_col(list(white(), lgreys())), color_picker_col(list(oranges(), 
        purples())), color_picker_col(list(yellows(), l_purples())), color_picker_col(list(l_greens(), 
        pinks())), color_picker_col(list(d_greens(), reds())), color_picker_col(list(l_blues(), 
        browns())), color_picker_col(list(blues(), bgreys()))), h_arrange(class = "my-1", div(id = paste0(inputId, 
        "_colorpicked"), class = "color-picked w-50 border rounded", `data-color` = color, `data-opacity` = opacity)), 
        h_arrange(div(class = "color-label px-1 text-secondary", "Opacity"), div(class = "border-top border-secondary w-100")), 
        h_arrange(sliderInput(paste0(inputId, "_opacity_slider"), label = NULL, min = 0, max = 1, 
            value = opacity, ticks = FALSE, width = "75%"), div(class = "ml-1 slider-input-wrapper", 
            tags$input(id = paste0(inputId, "_opacity_input"), class = "text-right slider-form form-control rounded-0 form-control-sm", 
                value = paste0(opacity, "%"), type = "text"))), ...)
    out %>% attachDependencies(html_dependency_ao_color_picker(), append = TRUE)
    # Returns: \code{[html]}
}
