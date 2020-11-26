#' Create a drop down menu header.
#'
#' For use inside ml_dropdown

#' @name dd_header
#' @param ...
#' @param id  [character]  Must have an exact length of 1.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @param carat  [logical]  Must have an exact length of 1.  Defaults to TRUE
#' @param is_submenu  [logical]  Defaults to FALSE
#' @return \code{dd_header}: [HTML]
#' @examples

#'  header = 'Drop Down'

#'  ml_dropdown(class = 'multi-level-dropdown', dd_header(header,

#'  id = label2id(header), class = 'menu-text', carat = FALSE),

#'  dd_menu(id = label2id(header), class = 'shadow', dd_item(id = 'option1',

#'  label = 'Option 1'), dd_item(id = 'option2', label = 'Option 2'),

#'  dd_item(id = 'option3', label = 'Option 3')))

#' @export
dd_header <- function(..., id, class = "", carat = TRUE, is_submenu = FALSE) {
    # Create a drop down menu header.  For use inside ml_dropdown

    assert_character(id,len = 1)
    assert_character(class,len = 1)
    assert_logical(carat,len=1)
    assert_logical(is_submenu,len=1)
    toggle<-''
    if(carat)toggle<-'dropdown-toggle'
    if(is_submenu==F){
        tags$span(class=glue("{class} {toggle}"),href="#",id=id,`data-toggle`="dropdown",`aria-haspopup`="true",`aria-expanded`="false",...)
    }else{
        tags$a(class=glue("dropdown-item {class} {toggle}"),href="#",id=id,`data-toggle`="dropdown",`aria-haspopup`="true",`aria-expanded`="false",...)
    }
    # Returns: [HTML]
}
