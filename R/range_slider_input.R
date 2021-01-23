#' Create a range slider input.

#' @name range_slider_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param units_label  \code{[NULL]}  Defaults to \code{NULL}.
#' @param min  \code{[number]}
#' @param max  \code{[number]}  Must be greater than \code{min}.
#' @param lower_val  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param upper_val  \code{[number]}  NULL is ok.  Defaults to \code{NULL}
#' @param prefix  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param suffix  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param signif  \code{[int]}  Defaults to \code{5}
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{'w-100'}
#' @return \code{range_slider_input}: \code{[html]}
#' @examples

#'  range_slider_input(inputId = 'myid', label = NULL, min = 0,
#'  max = 100, lower_val = 0, upper_val = 100, prefix = NULL,
#'  suffix = '%', signif = 4)
#' @export
range_slider_input <- function(..., inputId, label = NULL, units_label = NULL, min, max, 
    lower_val = NULL, upper_val = NULL, prefix = NULL, suffix = NULL, signif = 5, class = "w-100") {
    # Create a range slider input
    dots = list(...)
    if (l(dots) > 0) 
        assert_names(names(dots))
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    assert_number(min)
    assert_number(max, lower = min)
    assert_number(lower_val, null.ok = TRUE)
    assert_number(upper_val, null.ok = TRUE)
    assert_string(prefix, null.ok = TRUE)
    assert_string(suffix, null.ok = TRUE)
    assert_int(signif)
    ms = function(x) paste0(inputId, "_", x)
    format_number_label = function(x, prefix, suffix, digits) {
        x = switch(suffix, K = x/10^3, M = x/10^6, B = x/10^9, T = x/10^12, `%` = x/10^-2, 
            x)
        negPrefix = nnull(prefix) & x < 0
        x = signif(x, digits)
        if (negPrefix) {
            x = -1 * x
        }
        out = paste0(prefix, label_comma()(x), suffix)
        if (negPrefix) {
            out = paste0("(", out, ")")
        }
        out
    }
    lower_val = lower_val %or% min
    upper_val = upper_val %or% max
    if (lower_val < min) 
        lower_val = min
    if (upper_val > max) 
        upper_val = max
    out = div(id = "inputId", class = "ao-range-slider d-flex flex-column", `data-prefix` = prefix, 
        `data-min` = min, `data-max` = max, `data-suffix` = suffix, `data-lower` = lower_val, 
        `data-upper` = upper_val, `data-digits` = 5, h_arrange(justify = "start", class = "px-1 ao-range-label", 
            label, tags$span(class = "pl-1 label-units", units_label)), flexRow(class = "mb-2", 
            div(id = ms("min_input"), class = "edit-numeric flex-fill range-min text-left", 
                format_number_label(upper_val, prefix, suffix)), div(id = paste0(inputId, 
                "_max_input"), class = "edit-numeric range-max flex-fill  text-right", format_number_label(upper_val, 
                prefix, suffix))), flexRow(class = "px-1", sliderInput(paste0(inputId, "_range_slider"), 
            label = NULL, min = min, max = max, value = c(lower_val, upper_val), ticks = FALSE)))
    out %>% tagAppendAttributes(class = class, ...) %>% attachDependencies(html_dependency_ao_range_slider())
    # Returns: \code{[html]}
}
