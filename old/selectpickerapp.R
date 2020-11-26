



    library(shiny)
    library(Schrock)
    library(ShinyReboot)
    library(bootstraplib)
    library(htmltools)
    bs_global_theme()
    ui <- fluidPage(bs_dependencies(theme = bs_global_get()),
                    tags$head(reboot_Dependancies()),
                    tags$h1("picker_page_btn"),
                    uiOutput("settings"),
                    verbatimTextOutput(outputId = "res"),
                    verbatimTextOutput(outputId = "res2"))
    server <- function(input, output, session) {
      output$settings=renderUI({
        select_group(
          select_picker(
            inputId="app_btn_ace_theme",
            choices=getAceThemes(),
            selected='pastel_on_dark'
          ),
          select_picker(
            inputId="app_btn_font_size",
            choices=c("8px", "9px", "10px", "11px", "12px", "14px", "18px")
          ),
          picker_page_btn(
            inputId = 'app_btn_font_size_increase',
            pickerId = "app_btn_font_size",
            type = 'page-up',
            icon = 'format-font-size-increase'
          ),
          picker_page_btn(
            inputId = 'app_btn_font_size_decrease',
            pickerId = "app_btn_font_size",
            type = 'page-down',
            icon = 'format-font-size-decrease'
          ),
          class='btn btn-outline-dark btn-sm'
        )
      })
      output$res <- renderPrint(input$font_size)
      output$res2 <- renderPrint(input$ace_theme)
    }
    shinyApp(ui, server)



tags$select(
    id = "picker1",
    class = "selectpicker",
    `data-style` = "btn btn-outline-dark btn-sm rounded-0 border-right-0",

      tags$option("Mustard"),
      tags$option("Ketchup"),
      tags$option("Relish")
    )
  ),
  tags$select(
    id = "picker2",
    class = "selectpicker",
    `data-style` = "btn btn-outline-dark btn-sm rounded-0 border-right-0",
    `data-width` = "fit",
    tags$optgroup(
      label = "Camping",
      tags$option("8px"),
      tags$option("9px"),
      tags$option("10px"),
      tags$option("11px"),
      tags$option("12px"),
      tags$option("14px"),
      tags$option("18px")
    )
  ),
  tags$button(
    id = "increase_font",
    `data-val` = "0",
    class = "btn btn-outline-dark action-button btn-sm rounded-0 border-right-0 pager pager-increase",
    `data-name` = "picker2",
    tags$span(class = "mdi mdi-format-font-size-increase align-middle ")
  ),
  tags$button(
    id = "decrease_font",
    class = "btn btn-outline-dark btn-sm rounded-0 text-center align-middle pager pager-decrease",
    `data-name` = "picker2",
    tags$span(class = "mdi mdi-format-font-size-decrease align-middle ")
  )
)
