radioGroupButtons(
  inputId = "somevalue1",
  label = "Make a choice: ",
  choices = c("A")
)
html2R('<div class="form-group shiny-input-container shiny-input-radiogroup shiny-input-container-inline">
  <label class="control-label" for="somevalue1">Make a choice: </label>
  <br/>
  <div id="somevalue1" class="radioGroupButtons">
    <div aria-label="..." class="btn-group btn-group-container-sw" data-toggle="buttons" role="group">
      <div class="btn-group btn-group-toggle" role="group">
        <button class="btn radiobtn btn-default active">
          <input type="radio" autocomplete="off" name="somevalue1" value="A" checked="checked"/>
          A
        </button>
      </div>
    </div>
  </div>
</div>')


radio_btn_group=function(inputId,labels,selected=NULL,btn_class="btn btn-sm",group_class=NULL){
    fn_description("Create BS4 radio button groups")
    fn_returns("HTML")
               div(id=inputId,`aria-label` = "...", class = "shiny-input-container shiny-input-radiogroup btn-group btn-group-toggle", `data-toggle` = "buttons",make_radio_btns(labels=labels,selected=selected,inputId,class=btn_class))%>% tagAppendAttributes(class=class)
     #   )
}

make_radio_btns=function(labels,selected=NULL,inputId,class=NULL){
if(is.null(selected))selected=labels[1]
  selected=labels%in%selected
  make_radio_btn=function(value,checked=FALSE,inputId,class=NULL){

  inputTag=tags$input(type = "radio", autocomplete = "off",
             name = inputId, value = value)
  if(checked)inputTag=tagAppendAttributes(inputTag,checked="checked")
  tags$button(inputTag,value) %>% tagAppendAttributes(class=class)

}
map2(labels,selected,make_radio_btn,inputId=inputId,class=class)
}

fn_document(radio_btn_group,{
if (interactive()) {
library(shiny)
library(bootstraplib)
library(exprTools)
library(ShinyReboot)
bs_global_theme()
ui <- fluidPage(
  tags$head(
    bs_dependencies(theme = bs_global_get()),
    reboot_Dependancies()
  ),
  tags$h1("radio_btn_group examples"),

  radio_btn_group(
    inputId = "somevalue1",
    labels = c("A", "B", "C"),
    selected='B',
    btn_class = "btn btn-sm btn-primary"
  ),
  verbatimTextOutput("value1"),

)
server <- function(input, output) {

  output$value1 <- renderPrint({ input$somevalue1 })


}
shinyApp(ui, server)

}
})
package_document()
radioButtons("dist", "Distribution type:",
             c("Normal" = "norm",
               "Uniform" = "unif",
               "Log-normal" = "lnorm",
               "Exponential" = "exp"))
radio_btn_group(inputId = "show_asd",labels = name,
                selected = name[1],btn_class="btn btn-sm btn-primary")
