#' Create a collapsible folder.

#' @name folder_collapse
#' @param ...
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.
#' @param open  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param open_icon  \code{[string]}  NULL is ok.  Defaults to \code{'folder-outline'}
#' @param closed_icon  \code{[string]}  NULL is ok.  Defaults to \code{'folder-open-outline'}
#' @return \code{folder_collapse}: \code{[html]}
#' @examples

#'  folder_collapse(inputId = 'myid', label = 'folder1', div('one'),
#'  div('two'))
#'
#'  if(interactive()){
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'  bs_global_theme()
#'  ui <- fluidPage(
#'  bs_theme_dependencies(theme = bs_global_get()),
#'
#'  tags$h1("Icon Toggle"),
#'  folder_collapse(inputId='myid',label='folder1',div('one'),div('two'))
#'  )
#'
#'  server = function(input, output, session) {
#'
#'  output$res<-renderText({
#'  input$myid
#'  })
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }

#'
#' @export
folder_collapse <- function(..., inputId, label, open = FALSE, open_icon ="folder-open" ,
    closed_icon ="folder" ) {
    # Create a collapsible folder
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_logical(open, len = 1)
    assert_string(open_icon, null.ok = TRUE)
    assert_string(closed_icon, null.ok = TRUE)
    collapse = "collapse"
    content <- div(id = paste0(inputId, "collapse"), class = collapse, ...)
    tagList(flexRow(class = "align-items-center text-center", div(icon_mdi("chevron-right")),
        icon_toggler(inputId = inputId, value = open, icon_false = closed_icon, icon_true = open_icon,
            class = "icon", `data-toggle` = "collapse", `aria-expanded` = js_logical(open),
            `data-target` = paste0("#", inputId, "collapse"), span(class = "folder-label",
                label))), content)
    # Returns: \code{[html]}
}
