#' Search the material icon list.

#' @name search_mdi_icons
#' @param pattern  [character]  Must have an exact length of 1.
#' @return \code{search_mdi_icons}: [character]
#' @examples

#'  search_mdi_icons('database')

#' @export
search_mdi_icons <- function(pattern) {
    # Search the material icon list
    require(xml2)
    assert_character(pattern, len = 1)
    me <- read_html("html/mdi.html")
    allICons <- xml_find_all(me, "//i") %>% xml_attr("class")
    allICons[grepl(pattern, allICons)]
    # Returns: [character]
}



