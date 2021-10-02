#' Create a standard dropdown.

#' @name standard_dropdown
#' @param ...
#' @param inputId  \code{[string]}
#' @param target_class  \code{[string]}
#' @param handle_class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{standard_dropdown}: \code{[html]}
#' @examples





#' @export
standard_dropdown <- function(..., inputId, target, handle_class = NULL, class = NULL,width='auto') {
  # Create a data dropdown
  assert_string(inputId)
  assert_string(target)

  assert_string(width,pattern=c("auto|fit|min_fit|\\d+px"))
  if(target%nstarts_with% "[\\.\\#]"){
    g_stop("data_dropdown target must be a class or id that starts with either [`.`|`#`] ")
  }
  assert_string(handle_class, null.ok = TRUE)
  assert_string(class, null.ok = TRUE)
  ws=NULL
  if(width%detect%"px$"){
    ws=paste0('width:',width,";")
    width='fixed'
  }

  out <- dd_menu(id = inputId, `data-for` = target, class = "standard_dropdown context-menu shadow",`data-width`=width,...)
  out = tagAppendAttributes(out, class = class, id = inputId, `data-handle` = handle_class,style=ws)
  attachDependencies(out, html_dependency_standard_dropdown(), append = TRUE)
  # Returns: \code{[html]}
}

