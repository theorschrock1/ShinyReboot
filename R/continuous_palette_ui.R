#' Render a continuous palette ui.

#' @name continuous_palette_ui
#' @param inputId  \code{[string]}
#' @param data_range  \code{[numeric]}  Must have an exact length of \code{2}.
#' @param selected  \code{[string]}  Defaults to \code{'Blues'}
#' @return \code{continuous_palette_ui}: \code{[html]}
#' @export
continuous_palette_ui <- function(inputId, data_range, selected = "Blues") {
    # Render a continuous palette ui
    assert_string(inputId)
    assert_numeric(data_range, len = 2)
    assert_string(selected)
    ms = function(x) paste0(inputId, "-", x)
    out <- flexCol(id = inputId, class = "w-50 c-palette-picker", continuous_pallete_picker(inputId = ms("palette_picker"), 
        selected = selected), flexRow(class = "w-100", tags$span(class = "range-label  disabled mr-auto small", 
        "Min"), tags$span(class = "range-label mr-auto small  disabled", "Mid"), tags$span(class = "range-label small disabled", 
        "Max")), flexRow(class = "range-inputs w-100", tags$input(id = ms("variable_min"), 
        `data-min` = min(data_range), `data-handle` = "handle_min", type = "text", class = "p-0  rounded-0 my-group3 form-control shadow-none disabled w-15 mr-auto", 
        value = signif(min(data_range), 3), disabled = "disabled"), tags$input(id = ms("variable_mid"), 
        `data-mid` = mean(data_range), `data-handle` = "handle_mid", type = "text", class = "text-center p-0 rounded-0 my-group3 form-control shadow-none disabled w-15 mr-auto", 
        value = signif(mean(data_range), 3), disabled = "disabled"), tags$input(id = ms("variable_max"), 
        `data-max` = max(data_range), `data-handle` = "handle_max", type = "text", class = "p-0 rounded-0 my-group3 form-control shadow-none disabled w-15 text-right", 
        value = signif(max(data_range)), disabled = "disabled")), flexRow(class = "w-100", 
        default_color_picker(ms("color_min"), height = "32px", width = "31px", class = "spectrum_lim p-1"), 
        flexRow(class = "cont_p_selected border mt-1 p-1 flex-fill ", div(class = "c_palette")), 
        default_color_picker(ms("color_max"), height = "32px", width = "31px", class = "spectrum_lim p-1")), 
        flexRow(div(class = "form-check px-3  py-0 mr-auto", tags$input(type = "checkbox", 
            class = "form-check-input mycheck", id = ms("flip")), tags$label(class = "form-check-label mycheck-label m-0 p-0", 
            `for` = "exampleCheck1", "Reversed")), div(class = "form-check px-3  py-0", 
            tags$input(id = ms("edit_range"), type = "checkbox", class = "form-check-input mycheck"), 
            tags$label(class = "form-check-label mycheck-label m-0 p-0", `for` = "exampleCheck1", 
                "Edit Range"))), div(class = "ml-1 step-group my-group input-group input-group-sm", 
            div(class = "input-group-prepend", div(class = "input-group-text pl-0 m-0 my-group bg-white border-0", 
                tags$input(id = ms("stepped_range"), class = "check2", type = "checkbox", 
                  `aria-label` = "Radio button for following text input"), tags$span(class = "ml-1 small", 
                  "Stepped Color"))), tags$input(id = ms("n_steps"), type = "number", 
                class = "text-center p-0 rounded-0 my-group form-control shadow-none disabled", 
                value = "4", disabled = "disabled"), div(class = "input-group-append", 
                tags$span(class = "input-group-text pl-0 m-0 my-group bg-white border-0 ", 
                  tags$span(id = ms("steps-label"), class = "ml-1 small disabled", "Steps")))), 
        flexRow(div(id = ms("reset_palette"), class = "btn btn-sm btn-light", "Reset")))
    out %>% attachDependencies(html_dependency_continuous_palette_picker())
    # Returns: \code{[html]}
}
