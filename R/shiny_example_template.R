#' Generate a shiny app template.

#' @name shiny_example_template
#' @param name
#' @return \code{shiny_example_template}: a shiny app template
#' @examples

#'  shiny_example_template('new_template')

#' @export
shiny_example_template <- function(name) {
    # Generate a shiny app template
    sname<-sym(name)
    expr({
        if (interactive()) {
            library("shiny")
            library("ShinyReboot")
            library("bootstraplib")
            bs_global_theme()
            ui <- fluidPage(
                bs_dependencies(theme = bs_global_get()),
                tags$h1(!!name),
                uiOutput("ui1"),
                verbatimTextOutput(outputId = "res"))
            server <- function(input, output, session) {


                output$ui1<-renderUI({
                    !!call2(sname, inputId = 'id1')
                })

                output$res <- renderPrint(input$id1)
            }
            shinyApp(ui, server)
        }
    })
    # Returns: a shiny app template
}
