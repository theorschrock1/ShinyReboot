#' Generate a bootstrap select picker.

#' @name select_picker
#' @param inputId  [string]
#' @param selected  [choice]  Possible values: c('choices').  NULL is ok.  Defaults to NULL
#' @param choices  [character] Select choices
#' @param multiple  [logical]  Allow multiple selection? Defaults to FALSE
#' @param class  [string]  Defaults to 'btn btn-sm btn-outline-dark'
#' @param width  [string]  Must be 'auto','fit','px' or '\%'. Defaults to 'fit'
#' @param content_fn [function] A function to create the display content. Can return
#' strings or html.  Defaults to a function that replaces underscores '_' with spaces and
#' capitalizes each option.
#' @param ...  Additional HTML attributes
#' @return select_picker: HTML

#' @examples
#'  if (interactive()) {
#'  library('shiny')
#'  library('ShinyReboot')
#'  bs_global_theme()
#'  ui <- fluidPage(bs_dependencies(theme = bs_global_get()),
#'  tags$head(reboot_Dependancies()), tags$h1('select_picker'),
#'  select_picker(inputId = 'select_picker', choices = letters[1:5]),
#'  verbatimTextOutput(outputId = 'res'))
#'  server <- function(input, output, session) {
#'  output$res <- renderPrint(input[['select_picker']])
#'  }
#'  shinyApp(ui, server)
#'  }
#'  if (interactive()) {
#'  library('shiny')
#' library('ShinyReboot')
#'  bs_global_theme()
#'  ui <- fluidPage(
#'    bs_dependencies(theme = bs_global_get()),
#'    tags$head(reboot_Dependancies()),
#'    tags$h1('select_picker'),
#'    uiOutput("picker"),
#'    verbatimTextOutput(outputId = 'res')
#'  )
#'  server <- function(input, output, session) {
#'    output$picker=renderUI({
#'
#'      select_picker(inputId = 'select_picker', choices = letters[1:5])
#'    })
#'    output$res <- renderPrint(input[['select_picker']])
#'  }
#'  shinyApp(ui, server)
#'  }

#' @export
select_picker <- function(inputId, selected = NULL, choices, multiple = FALSE,class = "btn btn-sm btn-outline-dark", width = "fit",content_fn=default_label_fn, ...) {
    # Generate a bootstrap select picker
    assert_choice(selected, choices = choices, null.ok = TRUE)
    assert_character(choices)
    assert_string(inputId)
    assert_string(class)
    assert_string(width)
    if (!grepl(pattern = "^[0-9]+px$|^[0-9]+\\%$|^auto$|^fit$", width))
        g_stop("invalid width '{width}': Must be 'auto','fit','px' or '%'")
    assert_logical(multiple)
    dots_list <- list(...)
   assert_subset(names(dots_list),c("actionsBox","container","countSelectedText","deselectAllText","dropdownAlignRight","dropupAuto","header","hideDisabled","iconBase","liveSearch","liveSearchNormalize","liveSearchPlaceholder","liveSearchStyle","maxOptions","maxOptionsText","mobile","multipleSeparator","noneSelectedText","noneResultsText","selectAllText","selectedTextFormat","selectOnTab","showContent","showIcon","showSubtext","showTick","size","tickIcon","title","virtualScroll","width","windowPadding"))
   options=expr_eval(pickerOptions(style=class,!!!dots_list))
   picker_out=pickerInput(inputId = inputId,label=NULL,choices=choices,multiple = multiple,selected = selected,width = width,inline=FALSE,choicesOpt = list(content=content_fn(choices)),options = options )
  child= picker_out$children[[2]]
    remove_class( child)<-'form-control'

    out<-tagList( child,htmlDependencies(picker_out))
    out

    #tagList( bootstrap_select_depends(),selectTag)
    # Returns: HTML
}
#' @export
default_label_fn=function(x){
  capitalize= function (string) {
  capped <- grep("^[A-Z]", string, invert = TRUE)
  substr(string[capped], 1, 1) <- toupper(substr(string[capped],
                                                 1, 1))
  return(string)
}
capitalize(str_replace_all(x,"_"," "))
}

