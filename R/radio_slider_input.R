#' Create a radio slider input.

#' @name radio_slider_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param units_label  \code{[NULL]}  Defaults to \code{NULL}.
#' @param choices  \code{[atomic_vector]}
#' @param selected  \code{[choice]}  Possible values: \code{choices}.  NULL is ok.  Defaults to \code{NULL}
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{'w-100'}
#' @return \code{radio_slider_input}: \code{[html]}
#' @examples

#'  radio_slider_input(inputId = 'myid', choices = names(mtcars))
#' @export
radio_slider_input <- function(..., inputId, label = NULL, units_label = NULL, choices, selected = NULL, class = "w-100",variable_id=NULL) {
    # Create a radio slider input
    dots = list(...)
    if (l(dots) > 0)
        assert_names(names(dots))
    assert_string(inputId)
    assert_string(variable_id,null.ok=TRUE)
    if(is.null(variable_id))
        variable_id=inputId
    assert_string(label, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    assert_atomic_vector(choices)
    assert_choice(selected, choices = choices, null.ok = TRUE)

    drange <- seq(0,length(choices),by=1)
    selected = c(selected %or% "(All)")
    values = c("(All)", choices)
    selected_val = drange[which(values == selected)]
    ticks = TRUE
    if (length(choices) > 20)
        ticks <- FALSE
    ms = function(x) paste0(inputId, "_", x)
    header=NULL
    if(nnull(label)){
        header=filter_head(inputId,label,search=FALSE,clear_filter=TRUE,options_dropdown=TRUE)
    }
    out = div(
        id = inputId,
        `data-id`=variable_id,
        class = "ao-radio-slider data-filter d-flex flex-column w-100",
        `data-value` = selected,
        header,
        flexRow(
            class = "mb-3 w-100 px-2 border",
            div(id = ms("max_input"), class = "edit-numeric range-max flex-fill w-100", selected)
        ),
        flexRow(
            class = "px-1",
            sliderInput(
                paste0(inputId, "_range_slider"),
                label = NULL,
                min = 0,
                max = length(choices),
                step = 1,
                value = selected_val,
                ticks = ticks,
                width='100%'
            ),
            icon_btn(ms("shift_left"), "chevron-left", class = "border mx-1  shift-left toggle-slider"),
            icon_btn(ms("shift_right"), "chevron-right", class = "border mr-1 shift-right toggle-slider")
        ),
        tags$script(type = "application/json",`data-for`=inputId,HTML(toJSON(list(values = values),
                           auto_unbox = TRUE)))
    )
    out %>% tagAppendAttributes(class = class, ...) %>% attachDependencies(html_dependency_ao_radio_slider(), append = TRUE)
    # Returns: \code{[html]}
}
