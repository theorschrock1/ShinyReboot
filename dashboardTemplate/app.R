#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(bootstraplib)
library(shinyReboot)
library(exprTools)
library(Schrock)
bs_global_theme()
ui <- fluidPage(
    bs_dependencies(theme = bs_global_get()),
    tags$head(
        reboot_Dependancies(),
        tags$link(href="style.css" ,rel="stylesheet"),
        tags$link(href="sticky-footer.css", rel="stylesheet")
        ),
    nav_fixed_top(class='navbar-dark bg-dark shadow-sm',
                  nav_brand(class="mr-0 px-3 py-1 align-items-center", href="#",
                            'AO ANALYTICS'
                            ),
                  nav_toggler(data_target="#sidebarMenu",class= 'd-md-none collapsed')
                  ),
    div(class="container-fluid mr-0",
        sidebar_left(id="sidebarMenu",class='d-md-block bg-white shadow-sm',
                     sidebar_sticky(
                         h6("Sidebar")
                         )),
        main(
            h6("Panel title")
        )
        ))
# Define server logic required to draw a histogram
server <- function(input, output,session) {


}

# Run the application
shinyApp(ui = ui, server = server)
