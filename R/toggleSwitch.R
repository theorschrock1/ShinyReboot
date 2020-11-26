#' Generate a BS4 toggle switch.

#' @name toggleSwitch
#' @param inputId  [string]
#' @param label  [string]  NULL is ok.  Defaults to NULL
#' @param value [logical] The value of the toggle.
#' @param class  [string]  NULL is ok.  Defaults to NULL
#' @param color_checked  [string]  Defaults to 'primary'
#' @param color_unchecked  [string]  Defaults to 'gray'
#' @param knob_color_checked  [string]  NULL is ok.  Defaults to NULL
#' @param knob_color_unchecked  [string]  NULL is ok.  Defaults to NULL
#' @return \code{toggleSwitch}: HTML
#' @examples

#'  if (interactive()) {

#'  library('shiny')

#'  library('ShinyReboot')

#'  library('bootstraplib')

#'  bs_global_theme()

#'  ui <- fluidPage(bs_dependencies(theme = bs_global_get()),

#'  tags$head(), tags$h1('toggle_switch'), uiOutput('widget'),

#'  actionButton('false', 'set to FALSE'), verbatimTextOutput(outputId = 'res'))

#'  server <- function(input, output, session) {

#'  output$res <- renderPrint(input$myId)

#'  output$widget <- renderUI({

#'  toggleSwitch(inputId = 'myId', label = 'A toggle',

#'  color_checked = 'dark')

#'  })

#'  observeEvent(input$false, {

#'  updateCheckboxInput(session, 'myId', value = FALSE)

#'  })

#'  }

#'  shinyApp(ui, server)

#'  }

#' @export
toggleSwitch <- function(inputId, label = NULL, value=FALSE,class = NULL, color_checked = "primary",
    color_unchecked = "gray", knob_color_checked = NULL, knob_color_unchecked = NULL) {
    # Generate a BS4 toggle switch
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    assert_string(color_unchecked)
    assert_string(color_checked)
    assert_logical(value,len=1)

    assert_string(knob_color_unchecked, null.ok = TRUE)
    assert_string(knob_color_checked, null.ok = TRUE)
    nob_color_checked = knob_color_unchecked %or% "white"
    bg_unchecked = "white"
    bd_unchecked = color_unchecked
    nob_unchecked = knob_color_unchecked %or% color_unchecked
    bg_checked = color_checked
    bd_checked = color_checked
    inputId = inputId
    nob_checked = knob_color_checked %or% "white"
    style = tags$style(HTML(cglue(".&&inputId&& .custom-control-label::before {\n  /* switch background color unchecked */ \n    background-color: &&get_bs4_hex(bg_unchecked)&&;\n    /* switch  border color unchecked */ \n    border: &&get_bs4_hex(bd_unchecked)&& solid 1px;\n}\n.&&inputId&&  .custom-control-label::after {\n  /* nob color unchecked */ \n    background-color:&&get_bs4_hex(nob_unchecked)&&;\n}\n.&&inputId&& .custom-control-input:focus ~ .custom-control-label::before {\n  /* switch box-shadow */ \n    box-shadow: 0 0 0 0rem rgba(68,207,142,0.25);\n    border: &&get_bs4_hex(bd_unchecked)&& solid 1px;\n}\n.&&inputId&&  .custom-control-input:checked ~ .custom-control-label::before {\n  /* switch background color checked */ \n    background-color: &&get_bs4_hex(bg_checked)&&;\n    /* switch  border color checked */ \n    border-color: && get_bs4_hex(bd_checked)&&;\n    \n}\n.&&inputId&&  .custom-control-input:checked ~ .custom-control-label::after {\n  /* nob color checked */ \n    background-color:  &&get_bs4_hex(nob_checked)&&;\n}",
        env = current_env())))
    class = paste(class, inputId)
    inputTag=tags$input(type = "checkbox", class = "custom-control-input",
               id = inputId)
    if(value==TRUE)inputTag<-inputTag %>%  tagAppendAttributes(checked = "checked")
    labelTag=tags$label(class = "custom-control-label", `for` = inputId, label)
    if(is.null(label))labelTag=labelTag%>%
        tagAppendAttributes(class = "p-0 m-0")
    out = div(class = "custom-control custom-switch ",  inputTag,  labelTag) %>%
        tagAppendAttributes(class = class)

    tagList(style, out)
    # Returns: HTML
}
