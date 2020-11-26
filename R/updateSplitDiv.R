#' Update a Split Div.

#' @name updateSplitDiv
#' @param inputId  [string]
#' @param sizes  [numeric] New inner div sizes. Must have an exact length of input[[inputId]] and add up to 1 e.g. \code{c(.25,.25,.5)}.  NULL is ok.  Defaults to NULL.
#' @param collapse [integerish] Index of inner div to collapse. max length of input[[inputId]]-1.  min length of 1.  Values must be equal to less than length(input[[inputId]]).   Values must must be greater than 0.  NULL is ok.  Defaults to NULL.
#' @param maximize [integerish] Index of a single inner div to maximize (all other div will be collapsed to their min. max length of 1. NULL is ok.  Defaults to NULL.
#' @param session  Current session.  Defaults to getDefaultReactiveDomain()
#' @return \code{updateSplitDiv}: NULL
#' @export
#'
#' @examples
#' if(interactive()){
#'  ui <- fluidPage(bs_dependencies(theme = bs_global_get()),
#'  tags$h5("Split Div Update Examples"), fluidRow(class = "justify-content-center",
#'  div(class = "btn-group", actionButton("reset", "Reset Sizes",
#'  class = "btn btn-sm btn-outline-dark"), actionButton("collapse1",
#'  "Minimize div1", class = "btn btn-sm btn-outline-dark "),
#'  actionButton("collapse3", "Minimize div3", class = "btn btn-sm btn-outline-dark"),
#'  actionButton("collapseAll", "Maximize div4",
#'  class = "btn btn-sm btn-outline-dark"))), br(),
#'  splitCol(inputId = "splitCol", style = "width:100%;height:500px;",
#'  minSizes = c(25, 25, 25, 25), div(class = "bg-primary",
#'  "div1"), div(class = "bg-primary", "div2"), div(class = "bg-primary",
#'  "div3"), div(class = "bg-primary", "div4")),
#'  verbatimTextOutput(outputId = "res"))
#'  server <- function(input, output, session) {
#'  output$res = renderPrint({
#'  input$splitCol
#'  })
#'  observeEvent(input$collapse1, {
#'  req(input$collapse1)
#'  updateSplitDiv(inputId = "splitCol", collapse = 1)
#'  })
#'  observeEvent(input$collapse3, {
#'  req(input$collapse3)
#'  updateSplitDiv(inputId = "splitCol", collapse = 3)
#'  })
#'  observeEvent(input$collapseAll, {
#'  req(input$collapseAll)
#'  updateSplitDiv(inputId = "splitCol", maximize = 4)
#'  })
#'  observeEvent(input$reset, {
#'  req(input$reset)
#'  updateSplitDiv(inputId = "splitCol", sizes = rep(0.25,
#'  l(input$splitCol)))
#'  })
#'  }
#'  shinyApp(ui, server)
#' }
updateSplitDiv <- function(inputId, sizes = NULL, collapse = NULL,maximize=NULL, session = getDefaultReactiveDomain()) {
    # Update a Split Div
    assert_string(inputId)


    id <- last(str_split(inputId, "-")[[1]])
    input = list()
    input[[id]] = session$input[[id]]
    tmp <- expr(input$tmp)
    tmp[[3]] <- sym(id)
    expr_eval(assert_numeric(sizes,len=length(!!tmp),null.ok=TRUE))
    expr_eval(assert_integerish(collapse,max.len=length(!!tmp)-1,min.len = 1,upper =length(!!tmp),lower=1,null.ok = TRUE))
    expr_eval(assert_integerish(maximize,max.len=1,min.len = 1,upper =length(!!tmp),lower=1,null.ok = TRUE))
    if(nnull(maximize)){
        all<-1:l(input[[id]])
        collapse<-all%NIN%maximize
        sizes=NULL
    }
    if (sum(sizes) > 1)
        g_stop("sum of split div sizes should equal 1")
    message <- drop_nulls(list(sizes = sizes*100, collapse = collapse-1))

    session$sendInputMessage(inputId, message)
    # Returns: NULL
}
