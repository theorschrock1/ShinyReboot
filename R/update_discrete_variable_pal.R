#' update a discrete variable palette input.

#' @name update_discrete_variable_pal
#' @param inputId  \code{[string]}
#' @param var_names  \code{[character]}
#' @param var_ids  \code{[character]}  NULL is ok.  Defaults to \code{NULL}
#' @param colors  \code{[character]}  NULL is ok.  Must have an exact length of \code{length(var_names)}.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{update_discrete_variable_pal}: \code{[invisible(NULL)]}
#' @export
update_discrete_variable_pal <- function(inputId, var_names, var_ids = NULL, colors = NULL, session = getDefaultReactiveDomain()) {
    # update a discrete variable palette input
    assert_string(inputId)
    assert_character(var_names)
    assert_character(var_ids, null.ok = TRUE)
    assert_character(colors, null.ok = TRUE, len = length(var_names))
    assert_choice(palette, choices = ggthemes_palette_names(), null.ok = TRUE)
    ms = function(x) paste0(inputId, "_", x)
    c(palette, color_divs) %<-% generate_sortable_pal_items(n = length(var_names), colors = colors, 
        palette = palette)
    var_divs <- generate_sortable_var_items(var_names = var_names, var_ids = var_ids)
    updateSortableDiv(ms("selected_colors"), content = color_divs)
    updateSortableDiv(ms("selected_vars"), content = var_divs)
    if (nnull(palette)) {
        shinyWidgets::updatePickerInput(session = session, ms("palette_picker"), value = palette)
    }
    return(invisible(NULL))
    # Returns: \code{[invisible(NULL)]}
}
