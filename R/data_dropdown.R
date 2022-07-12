#' Create a data dropdown.

#' @name data_dropdown
#' @param ...
#' @param inputId  \code{[string]}
#' @param target_class  \code{[string]}
#' @param handle_class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param class  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{data_dropdown}: \code{[html]}
#' @examples

#'  data_dropdown(dropdown_button(inputId = 'edit', label = 'Edit...'),
#'  dropdown_checkbox(inputId = 'filter', value = FALSE,
#'  label = 'Show Filter'), dropdown_radio_group(inputId = 'radio_nformat',
#'  options = c('currency', 'percentage', 'float', 'integer'),
#'  labels = c('currency', 'percentage', 'float', 'integer')),
#'  dropdown_submenu(label = 'Units', dropdown_radio_group(inputId = 'radio_units',
#'  labels = c('duration', 'distance', 'mass', 'speed'),
#'  options = c('duration', 'distance', 'mass', 'speed'))),
#'  inputId = 'myid', handle_class = 'dropdown-handle', target_class = 'pill-item')
#'
#'  if(interactive()){
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'  bs_global_theme()
#'  ui <- fluidPage(
#'  bs_theme_dependencies(theme = bs_global_get()),
#'
#'  tags$h1("Data DropDown"),
#'  icon_mdi('pencil'),
#'  flexCol(class='w-50',
#'  pill_card(inputId ="nav_dimensions",
#'  type='column',
#'  sort_ops = sortable_options(
#'  name = 'nav_dimensions',
#'  pull = 'clone',
#'  put = FALSE,
#'  dragClass = 'drag',
#'  sort = FALSE
#'  ),
#'  pill_item(
#'  id = c('sales1', 'transactions1', 'traffic1',
#'  'basket_size1'),
#'  label = c('sales', 'transactions', 'traffic',
#'  'basket size'),
#'  data=list(
#'  nformat=c('currency','integer','integer',NA),
#'  filter=c(TRUE,FALSE,NA,FALSE),
#'  edit=c(NA,0,0,0)
#'  )
#'  )),
#'  data_dropdown(dropdown_button(inputId='action_edit',label='Edit...'),
#'  dropdown_checkbox(inputId='filter',value=FALSE,label='Show Filter'),
#'  dropdown_radio_group(inputId = 'radio_nformat',
#'  options = c('currency',
#'  'percentage',
#'  'float',
#'  'integer'
#'  ),
#'  labels = c('currency',
#'  'percentage',
#'  'float',
#'  'integer'
#'  )),
#'  dropdown_submenu(label = 'Units',
#'  dropdown_radio_group(
#'  inputId = 'radio_units',
#'  labels = c('duration','distance','mass','speed'),
#'  options= c('duration','distance','mass','speed'))) ,
#'  inputId='myid',
#'  handle_class = 'dropdown-handle',
#'  target='.pill-item')),
#'  verbatimTextOutput('res')
#'
#'  )
#'
#'  server = function(input, output, session) {
#'
#'  output$res<-renderText({
#'  glue("{names(input$myid)}:{unlist(input$myid)}")%sep%'\n'
#'  })
#'  observe({
#'  print(input$myid)
#'  })
#'  observe({
#'  print(input$myid_action_edit)
#'  })
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }




#' @export
data_dropdown <- function(..., inputId, target, handle_class = NULL, class = NULL,width='auto',position="absolute") {
    # Create a data dropdown
    assert_string(inputId)
    assert_string(target)
    assert_choice(position,c("relative","absolute"))
    assert_string(width,pattern=c("auto|fit|min_fit|\\d+px"))
    if(target%nstarts_with% "[\\.\\#]"){
       g_stop("data_dropdown target must be a class or id that starts with either [`.`|`#`] ")
    }
    assert_string(handle_class, null.ok = TRUE)
    assert_string(class, null.ok = TRUE)
    ws=NULL
    if(width%detect%"px$"){
        ws=paste0('width:',width,";")
        width='fixed'
    }
    if(position=='relative'){
        ws=paste0(ws,'position:relative;')
    }
    out <- dd_menu(id = inputId, `data-for` = target, class = "data_dropdown context-menu shadow",`data-width`=width,`data-position`=position,...)
    out = tagAppendAttributes(out, class = class, id = inputId, `data-handle` = handle_class,style=ws)
    attachDependencies(out, html_dependency_data_dropdown(), append = TRUE)
    # Returns: \code{[html]}
}

