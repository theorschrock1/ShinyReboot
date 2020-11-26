#' Create BS4 radio button groups.

#' @name radio_btn_group
#' @param inputId
#' @param labels
#' @param selected  [NULL]  Defaults to NULL
#' @param btn_class  [character]  Defaults to 'btn btn-sm'
#' @param group_class  [NULL]  Defaults to NULL
#' @return \code{radio_btn_group}: HTML
#' @examples

#'  if (interactive()) {
#'  library(shiny)
#'  library(bootstraplib)
#'  library(exprTools)
#'  library(ShinyReboot)
#'  bs_global_theme()
#'  ui <- fluidPage(tags$head(bs_dependencies(theme = bs_global_get()),
#'  reboot_Dependancies()), tags$h1('radio_btn_group examples'),
#'  radio_btn_group(inputId = 'somevalue1', labels = c('A',
#'  'B', 'C'), selected = 'B', btn_class = 'btn btn-sm btn-primary'),
#'  verbatimTextOutput('value1'), )
#'  server <- function(input, output) {
#'  output$value1 <- renderPrint({
#'  input$somevalue1
#'  })
#'  }
#'  shinyApp(ui, server)
#'  }

#' @export
radio_btn_group <- function(inputId, labels, selected = NULL, btn_class = "btn btn-sm",
    group_class = NULL) {
    # Create BS4 radio button groups
    div(id = inputId, `aria-label` = "...", class = "shiny-input-container shiny-input-radiogroup btn-group btn-group-toggle",
        `data-toggle` = "buttons", make_radio_btns(labels = labels, selected = selected,
            inputId=inputId, class = btn_class)) %>% htmltools::tagAppendAttributes(class =group_class)
    # Returns: HTML
}
make_radio_btns=function(labels,selected=NULL,inputId,class=NULL){
    if(is.null(selected))selected=labels[1]
    selected=labels%in%selected
    make_radio_btn=function(value,checked=FALSE,inputId,class=NULL){

        inputTag=tags$input(type = "radio", autocomplete = "off",
                            name = inputId, value = value)
        if(checked)inputTag=tagAppendAttributes(inputTag,checked="checked")
        b_out=tags$button(inputTag,value) %>% tagAppendAttributes(class=class)
        if(checked)b_out= b_out%>% tagAppendAttributes(class="active")
        b_out
    }
    map2(labels,selected,make_radio_btn,inputId=inputId,class=class)
}

