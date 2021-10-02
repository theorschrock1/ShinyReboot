#' Create a dropdown ui

#' @name data_dropdown
#' @param ...
#' @param inputId  \code{[string]}
#' @param target_class  \code{[string]}
#' @param handle_class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @parem
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{dropdown_ui}: \code{[html]}

dropdown_ui=function(..., inputId, target, handle_class = NULL, class = NULL,width=NULL) {
  # Create a data dropdown
  assert_string(inputId)
  assert_string(target)
  if(target%nstarts_with% "[\\.\\#]"){
    g_stop("data_dropdown target must be a class or id that starts with either [`.`|`#`]")
  }
  assert_string(handle_class, null.ok = TRUE)
  assert_string(class, null.ok = TRUE)
  assert_string(width, null.ok = TRUE,pattern = ends_with("px|\\%"))
  out <- dd_menu(id = inputId, `data-for` = target, class = "data_dropdown context-menu shadow dropdown-ui", ...)
  dots=list(...)
  style=dots$style
  if(nnull(width)){
     wd<-paste0("width:",width,";")
     style<-paste0(dots$style,wd)
     }
  out = tagAppendAttributes(out, class = class, id = inputId, `data-handle` = handle_class,style=style)
  attachDependencies(out, html_dependency_data_dropdown(), append = TRUE)
  # Returns: \code{[html]}
}
