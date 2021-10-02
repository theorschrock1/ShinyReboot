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
range_slider_input <- function(..., inputId, label = NULL, units_label = NULL, range,lower_val = NULL, upper_val = NULL, prefix = NULL, suffix = NULL, signif = 5, class = "w-100",variable_id=NULL) {
    # Create a range slider input
    dots = list(...)
    if (l(dots) > 0)
        assert_names(names(dots))
    assert_string(inputId)
    assert_string(variable_id,null.ok=TRUE)
    assert_atomic_vector(range)

    if(is.null(variable_id))
        variable_id=inputId
    assert_string(label, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    if(is.numeric(range)){
        tclass='edit-numeric '
        iclass=''
        factor_range=FALSE
        min=min(range)
        max=max(range)
        step=NULL
        script=NULL
        ticks=FALSE
    }else{
        iclass=' factor-range'
        tclass='factor '
        factor_range=TRUE
        min=0
        step=1
        max=length(range)-1
        ticks=FALSE
        if(max<=20)
            ticks<-TRUE
        script=tags$script(type = "application/json",`data-for`=inputId,HTML(toJSON(list(values =range),
                                                                                         auto_unbox = TRUE)))
    }
    if(factor_range){
        if(nnull(lower_val)){
       lower_val=which(range==lower_val)-1
        }else{
            lower_val=min
        }
        if(nnull(upper_val)){
            upper_val=which(range==upper_val)-1
        }else{
            upper_val=max
        }
    }
    assert_number(min)
    assert_number(max, lower = min)
    assert_number(lower_val, null.ok = TRUE)
    assert_number(upper_val, null.ok = TRUE)
    assert_string(prefix, null.ok = TRUE)
    assert_string(suffix, null.ok = TRUE)
    assert_int(signif)
    ms = function(x) paste0(inputId, "_", x)
    format_number_label = function(x, prefix, suffix, digits) {
        x = switch(
            suffix%or%"",
            K = x / 10 ^ 3,
            M = x / 10 ^ 6,
            B = x / 10 ^ 9,
            T = x / 10 ^ 12,
            `%` = x / 10 ^ -2,
            x
        )
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
    if(!is.numeric(lower_val)){

    }
    lower_val = lower_val %or% min
    upper_val = upper_val %or% max
    if (lower_val < min)
        lower_val = min
    if (upper_val > max)
        upper_val = max
    header=NULL
    if(nnull(label)){
    header=filter_head(inputId,label,search=FALSE,clear_filter=TRUE,options_dropdown=TRUE)
    }

    if(!factor_range){
        upper_lab=format_number_label(upper_val,
                            prefix, suffix)
        lower_lab=format_number_label(lower_val, prefix, suffix)
       labels_div= flexRow(
            class = "mb-2",
            div(
                id = ms("min_input"),
                class = glue("edit-numeric flex-fill range-min text-left"),
                lower_lab
            ),
            div(
                id = paste0(inputId,
                            "_max_input"),
                class = glue("edit-numeric range-max flex-fill  text-right"),
                upper_lab
            )
        )
    }else{
        upper_lab=range[upper_val+1]
        lower_lab=range[lower_val+1]
        labels_div= h_arrange(justify = 'start',
            class = "mb-2 ",
            div(
                id = ms("min_input"),
                class = glue("factor range-min"),
                lower_lab
            ),
            div(class='mx-2',"-"),
            div(
                id = paste0(inputId,
                            "_max_input"),
                class = glue("factor range-max"),
                upper_lab
            )
        )
    }
    out = div(
        id = inputId,
        class = glue("ao-range-slider d-flex flex-column data-filter{iclass}"),
        `data-id`=variable_id,
        `data-prefix` = prefix,
        `data-min` = min,
        `data-max` = max,
        `data-suffix` = suffix,
        `data-lower` = lower_val,
        `data-upper` = upper_val,
        `data-digits` = 5,
        header,
        labels_div,
        flexRow(
            class = "px-1",
            sliderInput(
                paste0(inputId, "_range_slider"),
                label = NULL,
                min = min,
                max = max,
                width='100%',
                step=step,
                value = c(lower_val, upper_val),
                ticks = ticks
            )
        ),
        script
    )
    out %>% tagAppendAttributes(class = class, ...) %>% attachDependencies(html_dependency_ao_range_slider(), append =TRUE)
    # Returns: \code{[html]}
}
