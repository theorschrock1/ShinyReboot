tagList(
  tags$script(src = "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2/dist/spectrum.min.js"),
  tags$link(rel = "stylesheet", type = "text/css", href = "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2/dist/spectrum.min.css"),

  )
)
list(htmlDependency("ionrangeslider", "2.1.6",
                    c(href = "shared/ionrangeslider"),
                    script = "js/ion.rangeSlider.min.js",
                    stylesheet = c("css/ion.rangeSlider.css", "css/ion.rangeSlider.skinShiny.css")),
     htmlDependency("strftime", "0.9.2", c(href = "shared/strftime"),
                    script = "strftime-min.js"))
tag<-div("id")
attach
html_dependency_shinyReboot <- function() {
  htmltools::htmlDependency(
    name = "ShinyReboot",
    version = packageVersion("ShinyReboot"),
    src = c(href ="ShinyReboot", file = "assets"),
    package = "ShinyReboot",
    script = "js/setShinyInput.js",
    all_files = FALSE
  )
}
setInputValue=function(inputId,value,session = shiny::getDefaultReactiveDomain()){
  fn_description("Set a shiny input value from the server side")
  fn_returns("NULL")

  assert_string(inputId)

  session$sendCustomMessage("setInputValue",c(inputId,value))
}



dep <- htmlDependency("ShinyReboot", "1.11.4", c(href="ShinyReboot"),
                      script = "js/")
color_picker_btn=function(inputId,color="#ffffff",...){
  fn_description("Generate a color picker button")
  fn_returns("HTML")
  assert_string(inputId)
  assert_string(color,pattern=start_with("#"))
  color<-restoreInput(inputId,color)
colorPickerTag=div(id = inputId,
                   class = "form-group shiny-input-container color-picker",
                   tags$input(
                     type = "color",
                     name =inputId,
                     value = color,
                     class = "form-control form-control-sm"
                   ) %>% tagAppendAttributes(...)
)
deps=htmlDependency("spectrum-colorpicker2","2.0",
                    c(href='https://cdn.jsdelivr.net/npm/spectrum-colorpicker2'),   script = "dist/spectrum.min.js",
                    stylesheet = "dist/spectrum.min.css")
setInputValue(inputId,color)
tagList(attachDependencies(colorPickerTag, deps),shiny::singleton(
  tags$script("
 $( document ).ready(function() {


$('.color-picker').on('change.spectrum', function(e, tinycolor) {
  console.log($(this).find('input').val());
  let color=$(this).find('input').val();
  let id=$(this).attr('id');
  Shiny.setInputValue(id,color);
  });

});")))
}




fn_document(setInputValue,{
if (interactive()) {

library("shiny")
library("ShinyReboot")

ui <- fluidPage(
  tagList(html_dependency_shinyReboot()),
  tags$h1("Set a shiny input value"),

  verbatimTextOutput(outputId = "res")

)

server <- function(input, output, session) {

  output$res <- renderPrint(input$myColor)

  observe({
    setInputValue("")
  })

}

shinyApp(ui, server)
}
})




library('shiny')
library('ShinyReboot')
ui <- fluidPage(tagList(html_dependency_shinyReboot()),
                tags$h1('Spectrum color picker'),
                color_picker_btn('myColor',"#ffffff"),
                verbatimTextOutput(outputId = 'res'))
server <- function(input, output, session) {
  output$res <- renderPrint(input$myColor)


}
shinyApp(ui, server)
materialIconGallery()
