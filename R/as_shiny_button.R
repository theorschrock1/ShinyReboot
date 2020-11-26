#' Convert an html element into a shiny action button.

#' @name as_shiny_button
#' @param tag  [class]
#' @return \code{as_shiny_button}: HTML (shiny.tag)
#' @examples

#'  if (interactive()) { 

#'  library('shiny') 

#'  library('ShinyReboot') 

#'  bs_global_theme() 

#'  ui <- fluidPage(bs_dependencies(theme = bs_global_get()), 

#'  tags$head(reboot_Dependancies()), tags$h1('as_shiny_button'), 

#'  as_shiny_button(div(id = 'shiny_button', class = 'border', 

#'  'click me!')), verbatimTextOutput(outputId = 'res')) 

#'  server <- function(input, output, session) { 

#'  output$res <- renderPrint(input[['shiny_button']]) 

#'  } 

#'  shinyApp(ui, server) 

#'  } 

#' @export
as_shiny_button <- function(tag) {
    # Convert an html element into a shiny action button
    assert_class(tag, "shiny.tag")
    if ("id" %nin% names(tag$attribs)) 
        g_stop("html tag must have an id to be converted to a shiny button")
    tagAppendAttributes(tag, class = "action-button", `data-val` = "0")
    # Returns: HTML (shiny.tag)
}
