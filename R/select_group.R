#' Create a button group that can include select dropdowns.

#' @name select_group
#' @param ...
#' @param group_class  [NULL]  Defaults to NULL
#' @return \code{select_group}: HTML
#' @examples

#'  if (interactive()) {

#'  library(shiny)

#'  library(Schrock)

#'  library(ShinyReboot)

#'  library(bootstraplib)

#'  library(htmltools)

#'  bs_global_theme()

#'  ui <- fluidPage(bs_dependencies(theme = bs_global_get()),

#'  tags$head(reboot_Dependancies()), tags$h1('picker_page_btn'),

#'  select_group(select_picker(inputId = 'ace_theme',

#'  choices = getAceThemes(), selected = 'pastel_on_dark'),

#'  select_picker(inputId = 'font_size', choices = c('8px',

#'  '9px', '10px', '11px', '12px', '14px', '18px'),

#'  ), picker_page_btn(inputId = 'font_size_increase',

#'  pickerId = 'font_size', type = 'page-up', icon = 'format-font-size-increase'),

#'  picker_page_btn(inputId = 'font_size_decrease',

#'  pickerId = 'font_size', type = 'page-down',

#'  icon = 'format-font-size-decrease'), class = 'btn btn-outline-dark btn-sm'),

#'  verbatimTextOutput(outputId = 'res'), verbatimTextOutput(outputId = 'res2'))

#'  server <- function(input, output, session) {

#'  output$res <- renderPrint(input$font_size)

#'  output$res2 <- renderPrint(input$ace_theme)

#'  }

#'  shinyApp(ui, server)

#'  }

#' @export
select_group <- function(..., group_class = NULL,env=caller_env()) {
    # Create a button group that can include select dropdowns

    dots <- enexprs(...)
    attrs = dots[have_name(dots)]
    childern = dots[!have_name(dots)]
    nc = l(childern)
    attrs$class = paste(attrs$class, "rounded-0")

    is_last = seq(1:nc) == nc
    childern = map2(.x = childern, .y = is_last, function(x, y, vars) {
        if (!y)
            vars$class = paste(vars$class, "border-right-0")
        x[names(vars)] <- vars
        x
    }, vars = attrs)
    print(names(env))
    eval(expr(div(class = "btn-group select-group", !!!childern)),envir = env)%>% tagAppendAttributes(class = group_class)
    # expr_eval(div(class = "btn-group select-group", !!!childern),env = env) %>% tagAppendAttributes(class = group_class)
    # Returns: HTML
}
