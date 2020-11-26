#' Create a button to page a select picker.

#' @name picker_page_btn
#' @param inputId  [string]
#' @param pickerId  [string]
#' @param class  [character]  Defaults to 'btn'
#' @param type  [choice]  Possible values: c('c', 'page-up', 'page-down').  Defaults to c('page-up', 'page-down')
#' @param icon  [string]  Defaults to ''
#' @param icon_size  [choice]  Possible values: c( 'xs', 'sm', 'md', 'lg', 'xl').  Defaults to c('md')
#' @param ...
#' @return \code{picker_page_btn}: HTML
#' @examples

#'  if (interactive()) {

#'  library('shiny')

#'  library(Schrock)

#'  library('ShinyReboot')

#'  library('bootstraplib')

#'  library('htmltools')

#'  bs_global_theme()

#'  ui <- fluidPage(bs_dependencies(theme = bs_global_get()),

#'  tags$head(reboot_Dependancies()), tags$h1('picker_page_btn'),

#'  div(class = 'btn-group', select_picker(inputId = 'font_size',

#'  choices = c('8px', '9px', '10px', '11px', '12px',

#'  '14px', '18px'), class = 'btn btn-outline-dark btn-sm rounded-0'),

#'  picker_page_btn(inputId = 'font_size_increase',

#'  pickerId = 'font_size', type = 'page-up', class = 'btn btn-outline-dark btn-sm rounded-0',

#'  icon = 'format-font-size-increase'), picker_page_btn(inputId = 'font_size_decrease',

#'  pickerId = 'font_size', type = 'page-down',

#'  class = 'btn btn-outline-dark btn-sm rounded-0',

#'  icon = 'format-font-size-decrease')), verbatimTextOutput(outputId = 'res'))

#'  server <- function(input, output, session) {

#'  output$res <- renderPrint(input$font_size)

#'  }

#'  shinyApp(ui, server)

#'  }

#' @export
picker_page_btn <- function(inputId, pickerId, class = "btn", type = c("page-up",
    "page-down"), icon = "", icon_size = c("md"), ...) {
    # Create a button to page a select picker
    assert_string(inputId)
    assert_string(pickerId)
    assert_string(icon)
    assert_choice(type, choices = c("page-up", "page-down"))
    assert_choice(icon_size, choices = c("xs", "sm", "md", "lg", "xl"))
    icon_size = paste(paste0("mdi-", icon_size))
    dots <- list(...)
    attrs = dots[have_name(dots)]
    attrs[c("id", "class", "data-name")] <- list(inputId, class, pickerId)
    childern = dots[!have_name(dots)]
    pickerpage_tag = tags$button(class = paste("select-pager", type), icon_mdi(icon,
        class = icon_size), !!!childern) %>% tagAppendAttributes(!!!attrs)
    out <- tagList(pickerpage_tag, html_dependency_picker_page_btn())

    out
    # Returns: HTML
}
