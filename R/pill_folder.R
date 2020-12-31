#' Create a pill folder.

#' @name pill_folder
#' @param folder_id  \code{[string]}
#' @param folder_name  \code{[string]}
#' @param pill_items  \code{[list]}
#' @param sortable_group  \code{[string]}
#' @return \code{pill_folder}: \code{[html]}
#' @examples

#'  pill_folder(folder_id = 'folder_id', folder_name = 'Sales Data',
#'  pill_items = pill_item(id = c('sales1', 'transactions1',
#'  'traffic1', 'basket_size1'), label = c('sales', 'transactions',
#'  'traffic', 'basket size'), data = list(nformat = c('currency',
#'  'integer', 'integer', NA), filter = c(TRUE, FALSE,
#'  NA, FALSE), edit = c(NA, 0, 0, 0), submenu_units = c(0,
#'  0, 0, NA))), sortable_group = 'measures')
#' @export
pill_folder <- function(folder_id, folder_name, pill_items, sortable_group) {
    # Create a pill folder
    assert_string(folder_id)
    assert_string(folder_name)
    assert_string(sortable_group)
    assert_list(pill_items)
    out <- folder_collapse(inputId = paste0(folder_id, "_folder"), label = folder_name, pill_card(inputId = folder_id, 
        type = "column", sort_ops = sortable_options(name = sortable_group, pull = "clone", put = FALSE, 
            dragClass = "drag", sort = FALSE), pill_items))
    div(class = "pill-folder", `data-id` = folder_name, out)
    # Returns: \code{[html]}
}
