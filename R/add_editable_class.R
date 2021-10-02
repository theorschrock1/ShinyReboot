#' Add an editable class.

#' @name add_editable_class
#' @param inputId  \code{[string]}
#' @param editable_class  \code{[string]}
#' @param assert_unique  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{add_editable_class}: \code{[html]}
#' @examples

#'  add_editable_class(inputId = 'myid', editable_class = 'pill-item',
#'  assert_unique = TRUE)
#'  add_editable_class(inputId = 'myid', editable_class = 'pill-item',
#'  assert_unique = FALSE)
#'  if(interactive()){
#'
#'
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
#'  add_editable_class(inputId='variable_rename',editable_class = 'pill-label'),
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
#'  data_dropdown(dropdown_button(inputId='action_rename',label='Rename'),
#'  dropdown_button(inputId='action_edit',label='Edit...'),
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
#'  target_class='pill-item')),
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
#'  print(input$myid_edit)
#'  })
#'  observe({
#'  print(input$variable_rename)
#'  })
#'  observeEvent(input$myid_action_rename,{
#'  print(input$myid_action_rename)
#'  update_editable('variable_rename',data_id =input$myid_action_rename,trigger=TRUE)
#'  })
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }
#' @export
add_editable_class <- function(inputId, editable_class,edit_event='dblclick', assert_unique = TRUE) {
    # Add an editable class
    assert_string(inputId)
    assert_string(editable_class)
    assert_string(edit_event)
    assert_logical(assert_unique, len = 1)
    div(id = inputId, class = "editable-text", `data-for` = editable_class, `data-assert_unique` = js_logical(assert_unique),`data-event`=edit_event) %>%
        attachDependencies(html_dependency_editable_text())
    # Returns: \code{[html]}
}
