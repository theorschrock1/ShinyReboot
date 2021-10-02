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
select_picker <- function(inputId, selected = NULL, choices, multiple = FALSE,class = NULL, width = "fit",content_fn=default_label_fn,picker_size='sm',picker_style='secondary',borders='normal',px=2,py=0,rounded=0,icons=NULL,display_content=NULL, ...) {
    # Generate a bootstrap select picker
    assert_choice(selected, choices = choices, null.ok = TRUE)
    assert_character(choices)
    assert_character(icons,len=length(choices),null.ok=TRUE)
    assert_character(display_content,len=length(choices),null.ok=TRUE)
    assert_string(inputId)
    assert_string(class,null.ok=TRUE)
    assert_string(width)
    assert_choice(picker_size,c('sm','md'))
    px<-paste0('px-',assert_integerish(px))
    py<-paste0('py-',assert_integerish(py))
    rounded<-paste0('rounded-',assert_integerish(rounded))
    assert_choice(picker_style,c('secondary','light'),null.ok=TRUE)
    borders =paste0('bd-',assert_choice(borders,c('thin','normal')))
    bs=NULL
    if(nnull(picker_style))bs=glue('btn-outline-{picker_style}')
    btnsize=NULL
    if(picker_size=='sm')btnsize='btn-sm'


    choiceOps=list(content=display_content%or%content_fn(choices))

    class=paste('btn',btnsize,bs,borders,px,py,rounded,'shadow-none',class)
    if (!grepl(pattern = "^[0-9]+px$|^[0-9]+\\%$|^auto$|^fit$", width))
        g_stop("invalid width '{width}': Must be 'auto','fit','px' or '%'")
    assert_logical(multiple)
    dots_list <- list(...)
   assert_subset(names(dots_list),c("actionsBox","container","countSelectedText","deselectAllText","dropdownAlignRight","dropupAuto","header","hideDisabled","iconBase","liveSearch","liveSearchNormalize","liveSearchPlaceholder","liveSearchStyle","maxOptions","maxOptionsText","mobile","multipleSeparator","noneSelectedText","noneResultsText","selectAllText","selectedTextFormat","selectOnTab","showContent","showIcon","showSubtext","showTick","size","tickIcon","title","virtualScroll","width","windowPadding"))
   if(is_null(dots_list$iconBase))
     dots_list$iconBase="mdi"
   if(nnull(icons)){
     choiceOps$icons=paste0(dots_list$iconBase,"-",icons)
     choiceOps$content=NULL
  if(nnull(display_content)){
       choices<-as.list(choices)
     names(choices)<-display_content
   }}
   options=expr_eval(pickerOptions(style=class,!!!dots_list))
   picker_out=pickerInput(inputId = inputId,label=NULL,choices=choices,multiple = multiple,selected = selected,width = width,inline=FALSE,choicesOpt =choiceOps ,options = options )
  child= picker_out$children[[2]]
    remove_class( child)<-'form-control'

    out<-tagList( child,htmlDependencies(picker_out),html_dependency_select_picker(),html_dependency_material_icons())
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

