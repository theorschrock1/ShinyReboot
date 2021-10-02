#' Create a row div with resizable columns.

#' @name splitRow
#' @param ... inner html (the rows to split)
#' @param inputId  [character] the shiny inputId and id of the outer div. Defaults to NULL.  If null, a random id will be generated.
#' @param class [character(1)] outer div class
#' @param style [character(1)] outer div style
#' @param sizes  [Number or Array] Initial sizes of each element in percents or CSS. Defaults to NULL
#' @param minSizes  [Number or Array] Number or Array 	Minimum size of each element. Defaults to NULL
#' @param expandToMin  [logical] Grow initial sizes to minSize Defaults to TRUE
#' @param gutterSize  [numeric]  Gutter size in pixels. Defaults to 10
#' @param snapOffset  [numeric]  Snap to minimum size offset in pixels. Defaults to 30
#' @param dragInterval  [numeric] Number of pixels to drag. Defaults to 1
#' @return \code{splitRow}: html
#' @examples
#' if(interactive()){
#'    library("shiny")
#'    library("ShinyReboot")
#'    library("bslib")
#'    bs_theme_dependencies(
#'           theme = bs_global_get())
#'  bs_global_theme()
#'  ui <- fluidPage(bs_theme_dependencies(
#'           theme = bs_global_get()),
#'
#'                  tags$h1("Split Div"),
#'                  splitRow(inputId='splitRow',style='width:100%;',
#'                        splitCol(inputId='splitCol1',
#'                                    style='height:400px;',
#'                         div(class='bg-secondary',"div1"),
#'                         div(class='bg-secondary',"div2")
#'                            ),
#'                         splitCol(inputId='splitCol2',
#'                                  style='height:400px;',
#'                                  div(class='bg-secondary',"div1"),
#'                                div(class='bg-secondary',"div2")
#'                         )),
#'                  verbatimTextOutput(outputId = "res"),
#'                  verbatimTextOutput(outputId = "res1"),
#'                  verbatimTextOutput(outputId = "res2"))
#'  server <- function(input, output, session) {
#'    output$res=renderPrint({
#'      input$splitRow
#'    })
#'    output$res1=renderPrint({
#'      input$splitCol1
#'    })
#'    output$res2=renderPrint({
#'      input$splitCol2
#'    })
#'  }
#'  shinyApp(ui, server)
#'}
#' @export
splitRow <- function(..., inputId = NULL, class="", style=NULL, sizes = NULL, minSizes = NULL,
    expandToMin = TRUE, gutterSize = 10, snapOffset = 30, dragInterval = 1) {
    # Create a row div with resizable columns

    dots=list(...)
    n = l(dots)
    more_args=dots[have_name(dots)]
    n=n-l(more_args)
    html= dots[!have_name(dots)]
    if (is.null(sizes))
        sizes <- rep(1/n, n)
    if (is.null(minSizes))
        minSizes <- rep(30, n)
    if (l(minSizes) == 1)
        minSizes <- rep(minSizes, n)
   expr_eval(split_div(inputId = inputId, class = paste("d-flex flex-row", class),style=style, sizes = sizes, minSize = minSizes,
        direction = "horizontal", expandToMin = expandToMin, gutterSize = gutterSize,
        snapOffset = snapOffset, dragInterval = dragInterval,!!!more_args, !!!html))
    # Returns: html
}
