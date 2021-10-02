#' Create an icon toggler.

#' @name icon_toggler
#' @param inputId  \code{[string]} shiny input id
#' @param value  \code{[logical]} Is the icon toggler 'on' or 'off'?  Must have an exact length of \code{1}.  Defaults to \code{FALSE}
#' @param icon_false  \code{[string]} the 'off' icon
#' @param icon_true  \code{[string]} the 'on' icon
#' @param ... additional html attributes or content
#' @return \code{icon_toggler}: \code{[html]}
#' @examples
#'  icon_toggler(inputId = 'myid', value = FALSE, icon_false = 'folder-outline',
#'  icon_true = 'folder-open-outline')
#'  icon_toggler(inputId = 'myid', value = TRUE, icon_false = 'folder-outline',
#'  icon_true = 'folder-open-outline', class = 'icon-sm')
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
#'  flexRow(class='mdi-md align-items-center text-center',div(icon_mdi('chevron-right',class='pr-0 mr-0')),icon_toggler('myid',value=TRUE,icon_false = 'folder-outline',icon_true = 'folder-open-outline',class='icon')),
#'  actionButton('close','Close Folder'),
#'  verbatimTextOutput('res')
#'  )
#'
#'  server = function(input, output, session) {
#'
#'  output$res<-renderText({
#'  input$myid
#'  })
#'  observeEvent(input$close,{
#'
#'  update_icon_toggler('myid',FALSE)
#'  })
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }
#'
#' @export
icon_toggler <- function(...,inputId, value = FALSE, icon_false, icon_true,icon_class=NULL,pre="=") {
    # Create an icon toggler
    assert_string(inputId)
    assert_logical(value, len = 1)
    assert_string(icon_false)
    assert_string(icon_true)
    #if(value==FALSE){
      tag = tags$div(role = 'button', div(
                         class = icon_class,
                         span(class = 'data-calculation', pre),
                         icon_mdi(name = icon_false,
                                  class = 'icon-false'),icon_mdi(name = icon_true,
                                                                  class = 'icon-true')), ...)
    #}else{
      # tag = tags$div(role = 'button', div(
      #   class = icon_class,
      #   span(class = 'data-calculation', pre),
      #   icon_mdi(name = icon_true,
      #            class = 'icon-toggle')
      # ), ...)
   # }
    class <- "icon-toggler"
    out <- tagAppendAttributes(tag,
                               id = inputId,
                               class = class,
                               `data-value` = js_logical(value),
                               `data-icon-true` = paste0('mdi-',icon_true),
                               `data-icon-false` = paste0('mdi-',icon_false))
    out %>% attachDependencies(html_dependency_icon_toggler(),append=TRUE)
    # Returns: \code{[html]}
}
#'  @export
update_icon_toggler <-function(inputId,value,session=getDefaultReactiveDomain()){
    assert_string(inputId)
    assert_logical(value)
    message=list(value=value)
    session$sendInputMessage(inputId, message)
}
