updateSortableDiv<- function(inputId,...,content=NULL,order = NULL,append=NULL,clear=FALSE,session = getDefaultReactiveDomain()) {
  fn_description("Update a sortable div")
  fn_returns("NULL")
  options=list(...)
  assert_subset(names(options),choices=fn_fmls_names(assert_sortable_options))
  assert_sortable_options(...)
  assert_logical(clear)
  assert_any(content,
             check_class(classes="shiny.tag"),
             check_list(types='shiny.tag'))
  assert_character(order)
  assert_any(append,
             check_class(classes="shiny.tag"),
             check_list(types='shiny.tag'))
  if(nnull(append)){
    if(is(append,'shiny.tag.list'))append=lapply(append,as.character) %>% unlist()
    append=as.character(append)%sep%""


  }
  if(nnull(content)){
    if(is.list(content)&&!is(content,'shiny.tag'))content=lapply(content,as.character) %>% unlist()
    content=as.character(content) %sep%""

  }
  if(clear){
    content=""
  }
  message <- drop_nulls(
    list(
      value =  order,
      options=options,
      append=append,
      content=content
    )
  )
  session$sendInputMessage(inputId, message)
}


library("shiny")
library("ShinyReboot")
library("bootstraplib")
library("Schrock")
library('exprTools')
bs_global_theme()
ui <- fluidPage(bs_dependencies(theme = bs_global_get()),
                tags$h1("sortablejs"),

                fluidRow(column(9,
                                fluidRow(checkboxInput('disable',"Disable"),
                                         actionButton('sort',"Sort"),
                                         actionButton("append","Append"),
                                         actionButton("update","Update"),
                                         actionButton("clear","Clear")),
                                uiOutput("sort2"),
                                verbatimTextOutput('res2')
                )))
server <- function(input, output, session) {
  output$res2 <- renderPrint(input$sortablejs2)

  output$sort2<-renderUI({
    ltmp=sample(letters)[1:5]
    inner<- lapply(expr_glue(div(class = 'm-1 p-1 bg-primary text-light', `data-id` = "{ltmp}", '{ltmp}')),eval)

    sortableDiv(class='p-1',
                inputId = 'sortablejs2',
                inner,
                options = sortable_options(name = "things",
                                           onEnd='function(evt){console.log("ending")}')
    )
  })
  observeEvent(input$sort,{
    req(input$sort)
    updateSortableDiv(inputId='sortablejs2',order=sort(input$sortablejs2))
  })


  observeEvent(input$append,{
    req(input$append)
    id<-letters[letters%nin%input$sortablejs2][1:2]
    print("here")
    updateSortableDiv(inputId='sortablejs2',append=tagList(
      div(class = 'm-1 p-1 bg-success text-light', `data-id` = id[1],id[1]

          ),
      div(class = 'm-1 p-1 bg-success text-light', `data-id` = id[2],id[2]

      )
      ))
  })

  observeEvent(input$disable,{

    updateSortableDiv(inputId='sortablejs2',disabled=input$disable)
  })
  observeEvent(input$update,{
    req(input$update)
  ltmp=sample(letters)[1:5]
  inner<- lapply(expr_glue(div(class = 'm-1 p-1 bg-secondary text-light', `data-id` = "{ltmp}", '{ltmp}')),eval)
  updateSortableDiv(inputId='sortablejs2',content=inner)
  },ignoreInit = TRUE)

  observeEvent(input$clear,{
    req(input$clear)
    updateSortableDiv(inputId='sortablejs2',clear=TRUE)
  },ignoreInit = TRUE)
}


shinyApp(ui, server)

