#' Generate a color picker button.

#' @name color_picker_btn
#' @param inputId  [string]
#' @param color  [string]   All non-missing elements must comply to regex pattern ^#.  Defaults to '#ffffff'
#' @param ...
#' @return \code{color_picker_btn}: HTML
#' @examples

#'  if (interactive()) {

#'  library('shiny')

#'  library('ShinyReboot')

#'  ui <- fluidPage(tagList(html_dependency_shinyReboot()),

#'  tags$h1('Spectrum color picker'), uiOutput('ui_colorPicker'),

#'  verbatimTextOutput(outputId = 'res'))

#'  server <- function(input, output, session) {

#'  output$res <- renderPrint(input$myColor)

#'  output$ui_colorPicker <- renderUI({

#'  color_picker_btn('myColor')

#'  })

#'  }

#'  shinyApp(ui, server)

#'  }

#' @export
color_picker_btn <- function(inputId, color, ...) {
    # Generate a color picker button
    assert_string(inputId)
    assert_string(color, pattern = start_with("#"))
    color <- restoreInput(inputId, color)
    colorPickerTag= tags$input(id = inputId,type = "color", class = "color-picker", name = inputId, value = color) %>%
        tagAppendAttributes(...)

    deps = htmlDependency("spectrum-colorpicker2", "2.0", c(href = "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2"),
        script = "dist/spectrum.min.js", stylesheet = "dist/spectrum.min.css")



    tagList(colorPickerTag, deps,tags$script(c(" $( document).on('shiny:connected', function() {",glue('Shiny.setInputValue("{inputId}","{color}");') ,"});")%sep%"\n"), shiny::singleton(tags$script("\n $( document ).ready(function() {\n  \n      \n$('.color-picker').on('change.spectrum', function(e, tinycolor) {\n let color=$(this).val();\nlet id=$(this).attr('id');\n  Shiny.setInputValue(id,color);\n  });\n  \n});")))
    # Returns: HTML
}
