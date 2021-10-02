#' Create a main menu bar [File,Edit,Code,View,etc].

#' @name main_menu_bar
#' @param ... should be named lists.  name represent the menu header and contents the dropdown options. Can be used recursively for multiple dropdown options.  See example.
#' @param class  [character]  Must have an exact length of 1.  Defaults to ''
#' @return \code{main_menu_bar}: [HTML]
#' @examples

#'  main_menu_bar(File = list('New', 'Open', 'Save', list(l2 = list('one',

#'  'two', 'three', list(l3 = list('one', 'two', 'three'))))),

#'  Data = .('New data source', 'Paste'), View = .('Graph',

#'  'Dashboard'))

#' @export
main_menu_bar <- function(..., class =NULL) {
    # Create a main menu bar [File,Edit,Code,View,etc]
    assert_character(class, len = 1,null.ok=TRUE)

    out<-flexRow(class ="main-menu",...)

    append_class(out)<-NULL
    attachDependencies(out,html_dependency_main_menu_bar())
    # Returns: [HTML]
}
# main_menu_bar <- function(..., class = "") {
#     # Create a main menu bar [File,Edit,Code,View,etc]
#     assert_character(class, len = 1)
#     dots = list(...)
#     headers = names(dots)
#     items <- map2(dots, headers, function(x, y) expr_eval(mm_item(!!x, !!!y)))
#     names(items) <- NULL
#     expr_eval(flexRow(class = glue("menu-bar main-menu {class}"), !!!items))
#     # Returns: [HTML]
# }
