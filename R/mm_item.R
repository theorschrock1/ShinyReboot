#' Create a multi-level dropdown menu item.

#' @name mm_item
#' @param items  [list]
#' @param header  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to 'menu-item'
#' @param carat  [logical]  Must have an exact length of 1.  Defaults to FALSE
#' @param submenu  [logical]  Must have an exact length of 1.  Defaults to FALSE
#' @return \code{mm_item}: [HTML]
#' @examples

#'  mm_item(item = list('New', 'Open', 'Save', list(l2 = list('one',
#'  'two', 'three'))), header = 'File', carat = FALSE, submenu = FALSE)

#' @export
mm_item <- function(items, header, class = "menu-item", carat = FALSE, submenu = FALSE,id=NULL) {
    # Create a multi-level dropdown menu item
    assert_list(items)
    assert_character(header, len = 1)
    assert_character(class, len = 1)
    assert_logical(carat, len = 1)
    assert_logical(submenu, len = 1)
    items = map2(header, items, function(x, y) {
        if (is.list(y)) {
            return(mm_item(y[[1]], names(y), class = "dropright sub-menu-item", carat = TRUE, submenu = TRUE,id=label2id(paste(x, names(y)))))
        }
        if(!is_null(id))id=label2id(paste(id, y))
        dd_item(label = y, id = id%or%label2id(paste(x, y)), class = "ao-action-button")
    })
    ml_dropdown(class = class, is_submenu = submenu, dd_header(header, id = tolower(header), class = "menu-text",
        carat = carat, is_submenu = submenu), dd_menu(id = tolower(header), class = "shadow", items))
    # Returns: [HTML]
}
