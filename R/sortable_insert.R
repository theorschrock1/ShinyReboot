#' insert html into a sortable div.

#' @name sortable_insert
#' @param ...
#' @param inputId  \code{[string]}
#' @param where  \code{[choice]}  Possible values: \code{c('start', 'end', 'before', 'after')}.  Defaults to \code{'start'}
#' @param data_id  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{sortable_insert}: \code{[invisible(NULL)]}
#' @examples
#'  if(interactive()){
#'    sortable_insert<-
#'      function(...,inputId,
#'               where="start",
#'               data_id=NULL,
#'               session=getDefaultReactiveDomain()){
#'        #Documentation
#'        fdoc("insert html into a sortable div","[invisible(NULL)]")
#'        #Assertions
#'        assert_string(inputId)
#'        assert_choice(where, choices = c("start", "end", "before", "after"
#'        ))
#'        assert_string(data_id, null.ok = TRUE)
#'        if(where%in% c("before", "after")&is.null(data_id))
#'          g_stop("A sortable item's data_id cannot be NULL if where==`{where}`")
#'        #TO DO
#'        ns<-session_ns(session)
#'        selector= glue('#{ns(inputId)}')
#'        if(nnull(data_id)&&where%in% c("before", "after"))
#'          selector<-glue('{selector} > [data-id="{data_id}"]')
#'
#'        content<-tagList(...)
#'       print(selector)
#'        where<-chr_approx(
#'          c("start", "end", "before", "after"),
#'          c("afterBegin","beforeEnd","beforeBegin", "afterEnd"))(where)
#'        insertUI(selector,
#'                 where=  where,
#'                 ui=content,
#'                 session=session)
#'      }
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'  bs_global_theme()
#'  ui <- fluidPage(bs_theme_dependencies(
#'  theme = bs_global_get()),
#'
#'  tags$h1("Insert into sortable"),
#'
#'  sortableDiv(
#'    class = 'p-1',
#'    inputId = 'sortablejs1',
#'    div(class = 'm-1 bg-secondary',
#'        `data-id` = 'one', 'one'),
#'    div(class = 'm-1 bg-secondary',
#'        `data-id` = 'two', 'two'),
#'    div(class = 'm-1 bg-secondary',
#'        `data-id` = 'four', 'four'),
#'    options = sortable_options(name = 'things')
#'  ),
#'  actionButton(inputId='gr1', label='add zero',class='btn btn-sm btn-dark'),
#'  actionButton(inputId='gr3', label='add fractions',class='btn btn-sm btn-dark'),
#'  actionButton(inputId='gr2', label='add three',class='btn btn-sm btn-dark'),
#'
#'  verbatimTextOutput(outputId = "res1"),
#'  verbatimTextOutput(outputId = "res2")
#'  )
#'
#'  server <- function(input, output, session) {
#'
#'    observeEvent(input$gr2,{
#'
#'     sortable_insert(inputId='sortablejs1',
#'          where='after',
#'          data_id='two',
#'          div(class = 'm-1 bg-success',
#'          `data-id` = 'three', 'three'))
#'
#'     })
#'    observeEvent(input$gr1,{
#'      sortable_insert(inputId='sortablejs1',
#'                      where='start',
#'                      div(class = 'm-1 bg-success',
#'                          `data-id` = 'zero', 'zero'))
#'
#'    })
#'    observeEvent(input$gr3,{
#'      insert<-sortableDiv(
#'        class = 'p-1',
#'        inputId = 'sortablejs2',
#'        div(class = 'm-1 bg-warning',
#'            `data-id` = '0.025', '0.025'),
#'        div(class = 'm-1 bg-warning',
#'            `data-id` = '0.50',  '0.50'),
#'        div(class = 'm-1 bg-warning',
#'            `data-id` = '0.75',  '0.70'),
#'        options = sortable_options(name = 'things')
#'      )
#'      sortable_insert(inputId='sortablejs1',
#'                      where='before',
#'                      data_id='one',
#'                      insert
#'                      )
#'
#'    })
#'  output$res1=renderPrint({
#'  input$sortablejs1
#'  })
#'  output$res2=renderPrint({
#'    input$sortablejs2
#'  })
#'  }
#'  shinyApp(ui, server)
#' }
#'

#' @export
sortable_insert <- function(..., inputId, where = "start", data_id = NULL, session = getDefaultReactiveDomain()) {
    # insert html into a sortable div
    assert_string(inputId)
    assert_choice(where, choices = c("start", "end", "before", "after"))
    assert_string(data_id, null.ok = TRUE)
    if (where %in% c("before", "after") & is.null(data_id))
        g_stop("A sortable item's data_id cannot be NULL if where==`{where}`")
    ns <- session_ns(session)
    selector = glue("#{ns(inputId)}")
    if (nnull(data_id) && where %in% c("before", "after"))
        selector <- glue("{selector} > [data-id=\"{data_id}\"]")
    content <- tagList(...)
    print(selector)
    where <- chr_approx(c("start", "end", "before", "after"), c("afterBegin",
        "beforeEnd", "beforeBegin", "afterEnd"))(where)
    insertUI(selector, where = where, ui = content, session = session,immediate = TRUE)
    # Returns: \code{[invisible(NULL)]}
}
