#' Set a shiny input value from the server side.

#' @name setInputValue
#' @param inputId  [string]
#' @param value the new value of the input
#' @param session  [NULL]  Defaults to shiny::getDefaultReactiveDomain()
#' @return \code{setInputValue}: NULL
#' @examples

#'  if (interactive()) {

#'  library('shiny')

#'  library('ShinyReboot')

#'  ui <- fluidPage(tagList(html_dependency_setShinyInput()),

#'  tags$h1('Set a shiny input value'), verbatimTextOutput(outputId = 'res'))

#'  server <- function(input, output, session) {

#'  output$res <- renderPrint(input$myColor)

#'  observe({

#'  setInputValue('myColor', '#ffffff')

#'  })

#'  }

#'  shinyApp(ui, server)

#'  }

#' @export
setInputValue <- function(inputId, value, session = shiny::getDefaultReactiveDomain()) {
    # Set a shiny input value from the server side
    assert_string(inputId)
    session$sendCustomMessage("setInputValue", c(inputId, value))
    # Returns: NULL
}
