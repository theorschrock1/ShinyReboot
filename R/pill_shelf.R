#' Create a variable pill shelf.

#' @name pill_shelf
#' @param ids  \code{[list]}
#' @param data  \code{[list]}
#' @param group_name  \code{[string]}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{pill_shelf}: \code{[html]}
#' @export
pill_shelf <- function(ids, data, group_name, session = getDefaultReactiveDomain()) {
    # Create a variable pill shelf
    if (inherits(session, "session_proxy")) {
        ns <- session$ns
    } else {
        ns = function(x) x
    }
    assert_list(ids)
    assert_list(data)
    assert_string(group_name)
    out <- map2(ids, data, function(x, y) {
        pill_item(id = x$id, label = x$label, icon = x$icon, type = unique(x$type), data = y)
    })
    folders <- out[names(out) != "none"]
    fnames <- str_split(names(folders), ":::")
    fpills <- map2(fnames, folders, function(x, y) pill_folder(folder_id = ns(x[1]), folder_name = x[2], 
        pill_items = y, sortable_group = group_name))
    base <- out$none
    fnames = lapply(names(folders), function(x) str_split(x, ":::")[[1]][2]) %>% unlist()
    pnames <- c(ids$none$label, fnames)
    all_pills <- c(base, fpills)
    all_pills[order(pnames)]
    # Returns: \code{[html]}
}
