#' Create a navigation list.

#' Should be used in conjuction with navListContent
#' @name navList
#' @param ...
#' @param nav_id  [character] The navigation id. Used for name spacing.  This id should match the id used in navListContent(). Must have an exact length of 1.
#' @param type  [choice("tabs"|"pills")]  Defaults to 'tabs'
#' @param class  [character]  Must have an exact length of 1.  NULL is ok.  Defaults to NULL
#' @param format  [choice("column"|"fill"|"justified")]  NULL is ok.  Defaults to NULL
#' @return \code{navList}: html
#' @examples

#'  navList(nav_id = 'data', class = 'main-nav', type = 'pills',

#'  format = 'justified', navItem(tab_id = 'one', 'One',

#'  active = TRUE), navItem(tab_id = 'two', 'Two'))

#' @export
navList <- function(..., nav_id, type = "tabs", class = NULL, format = NULL) {
    # Create a navigation list
    dots <- enexprs(...)
    outerHTML = list(...)
    innerHTML=lapply(outerHTML,function(x)x$children[[1]])
    assert_character(nav_id, len = 1)
    assert_choice(format, c("column", "fill", "justified"), null.ok = TRUE)
    frmt = ""
    if (nnull(format))
        frmt = glue(" nav-{format}")
    assert_choice(type, c("tabs", "pills"))
    assert_character(class, len = 1, null.ok = TRUE)
    if (any(sapply(lapply(dots, check_call, "navItem"), isTRUE) == F))
        g_stop("`...` must contain navItems()")
    ids = lapply(innerHTML, function(x) html_id(x))
    if(l(unlist(ids))!=l(ids))g_stop("All inner elements should have unique ids")
    if (anyDuplicated(unlist(ids)))
        g_stop("Duplicated tab_id found")
    innerHTML=lapply(innerHTML,function(x,nav_id){
      x$attribs$id=glue("{nav_id}-{x$attribs$id}")
      x$attribs$href=glue("#{nav_id}-{x$attribs$`aria-controls`}")
      x$attribs$`aria-controls`=glue("{nav_id}-{x$attribs$`aria-controls`}")

        x
    },nav_id=nav_id)
    if(type=="pills")
      innerHTML=lapply(innerHTML,function(x){
        x$attribs$`data-toggle`<-"pills"
        x
      })
    is_active = unlist(sapply(innerHTML, function(x)hasHTMLclass(x,'active')))
    if (all(is_active==FALSE))
        append_class(innerHTML[[1]])<-'active'
    if (length(is_active[is_active == TRUE]) > 1)
        g_stop("Only one navItem can be active")
    clss = ""
    active_tag=unlist(sapply(innerHTML, function(x){
        if(hasHTMLclass(x,'active')){
        return(x$attribs$id)
    }else{
        NULL
    }
    }))

    active_tag=glue('"#{active_tag}"')
  Jq=c('$( document ).ready(function() {',
   glue("$({active_tag}).addClass('active show');"),
          "});")%sep%"\n"
    if (nnull(class))
        clss <- paste0(" ", class)

  innerHTML=map2(outerHTML,innerHTML,function(x,y){
    x$children<-y
    x
    })
    eval(expr(tagList(tags$ul(class = glue("nav nav-{type}{frmt}{clss}"), id = nav_id, role = "tablist",
        !!!innerHTML),tags$script(HTML(Jq)))))
    # Returns: html
}





