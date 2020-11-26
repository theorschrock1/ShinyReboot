sortable_options=function(
                      name=NULL, #name or list(name,pull=[true|false|["foo", "bar"]|'clone'|function],put=[true|false|["foo", "bar"]|'clone'|function]],revertClone=[true|false])
                      pull=NULL,#[true|false|["foo", "bar"]|'clone'|function]]
                      put=NULL,#TRUE|FALSE|list(group_names=c())|list(class_names=c()]
                      revertClone=NULL,#TRUE|FALSE
                      sort=NULL,
                      delay=NULL,
                      delayOnTouchOnly=NULL,
                      multiDrag=NULL,
                      touchStartThreshold=NULL,
                      removeOnSpill=NULL,#Remove item on spill
                      disabled=NULL, #Disables the sortable if set to true.
                      animation= NULL, # ms, animation speed moving items when sorting, `0` — without animation
                      easing= NULL,# Easing for animation. Defaults to null. See https://easings.net/ for examples.
                      handle=NULL,# // Drag handle selector within list items
                      filter=NULL,# Selectors that do not lead to dragging (String or Function)
                      preventOnFilter=NULL, # Call `event.preventDefault()` when triggered `filter`
                      draggable=NULL,# Specifies which items inside the element should be draggable
                      dataIdAttr= NULL,
                      ghostClass=NULL, #Class name for the drop placeholder
                      chosenClass=NULL,#Class name for the chosen item
                      dragClass=NULL,#Class name for the dragging item
                      selectedClass=NULL,
                      swapThreshold= NULL,# Threshold of the swap zone
                      invertSwap=NULL, # Will always use inverted swap zone if set to true
                      invertedSwapThreshold=NULL,# // Threshold of the inverted swap zone (will be set to swapThreshold value by default)
                      direction=NULL,# Direction of Sortable (will be detected automatically if not given)
                      swap=NULL, #// Enable swap mode
                      swapClass=NULL,# // Class name for swap item (if swap mode is enabled)
                      forceFallback=NULL, #ignore the HTML5 DnD behaviour and force the fallback to kick in

                      fallbackClass=NULL,# // Class name for the cloned DOM Element when using forceFallback
                      fallbackOnBody=NULL,# // Appends the cloned DOM Element into the Document's Body
                      fallbackTolerance=NULL, #// Specify in pixels how far the mouse should move before it's considered as a drag.
                      dragoverBubble=NULL,
                      removeCloneOnHide=NULL,# // Remove the clone element when it is not showing, rather than just hiding it
                      multiDragKey=NULL,# // Key that must be down for items to be selected
                      emptyInsertThreshold=NULL, #// px, distance mouse must be from empty sortable to insert drag element into it
                      onChoose=NULL,#function (/**Event*/ evt) {evt.oldIndex; // element index within parent},
                      onUnchoose=NULL, #// Element is unchosen
                      onStart=NULL, #// Element dragging started
                      onEnd=NULL,#// Element dragging ended
                      onAdd=NULL,#// Element is dropped into the list from another list
                      onUpdate=NULL,#// Changed sorting within list
                      onSort=NULL,#// Called by any change to the list (add / update / remove)
                      onRemove=NULL,#// Element is removed from the list into another list
                      onFilter=NULL,#// Attempt to drag a filtered element,
                      onMove=NULL,#Event when you move an item in the list or between lists
                      onClone=NULL,#// Called when creating a clone of element
                      onChange=NULL,#// Called when dragging element changes position
                      onSelect=NULL,#// Called when an element is selected
                      onDeselect=NULL#// Called when an element is deselected
){
  assert_string(name,null.ok = TRUE)

  assert_any(put,
  check_logical(null.ok = T),
  check_character(),
  check_list(len = 1)
  )
  assert_any(pull,
           check_logical(null.ok = T),
           check_character())
  assert_logical(revertClone,null.ok = T)
  assert_logical(sort,null.ok = T)
  assert_number(delay,null.ok = T)
  assert_logical(delayOnTouchOnly,null.ok = T)
  assert_logical(multiDrag,null.ok = T)
  assert_number(touchStartThreshold,null.ok = T)
  assert_logical(removeOnSpill,null.ok = T)
  assert_logical(disabled,null.ok = T)
  assert_number(animation,null.ok = T)
  assert_string(easing,null.ok = T)
  assert_string(handle,null.ok = TRUE)
  assert_logical(preventOnFilter,null.ok = T)
  assert_character(draggable,null.ok = TRUE)
  assert_string(dataIdAttr,null.ok = T)
  assert_string(ghostClass,null.ok = T)
  assert_string(chosenClass,null.ok = T)
  assert_string(dragClass,null.ok = T)
  assert_string(selectedClass,null.ok = TRUE)
  assert_number(swapThreshold,lower=0,upper=1,null.ok = T)
  assert_number(invertedSwapThreshold,lower=0,upper=1,null.ok = T)
  assert_logical(invertSwap,null.ok = T)
  assert_choice(direction,choices=c('vertical','horizontal'),null.ok = T)
  assert_logical(swap,null.ok = TRUE)
  assert_string(swapClass,null.ok=TRUE)
  assert_logical(forceFallback,null.ok = T)
  assert_string(fallbackClass,null.ok = T)
  assert_logical(fallbackOnBody,null.ok = T)
  assert_number(fallbackTolerance,lower=0,null.ok = T)
  assert_logical(dragoverBubble,null.ok = T)
  assert_logical(removeCloneOnHide,null.ok = T)
  assert_number(emptyInsertThreshold,lower=0,null.ok = T)

  if(nnull(handle)&&!grepl(start_with('\\.'),handle))
    handle=paste0(".",handle)
  if(nnull(draggable)&&!grepl(start_with('\\.'),draggable))
    draggable=paste0(".",draggable)
  if(nnull(filter)&&!grepl(start_with('\\.'),filter))
    filter=paste0(".",filter)
if(nnull(put)&&is.list(put)&&names(put)!='class_types')
  g_stop("put must be logical, a vector of group names, or list of classes with format `list(class_types=c('class1,'class2'))`")

  # function (item) {
  #   classNames=['fd','fd1']
  #   if (classNames.some(className =>item.classList.contains(className))) {
  #     return true
  #   }
  #   return false}

  tmp=args2list()

# tmp= fn_fmls(sortable_options)
  tmp<-tmp[sapply(tmp,nnull)]
  tmp$group=tmp[c('name','pull','put','revert_clone')]
  tmp[['name']]<-NULL
  tmp[['pull']]<-NULL
  tmp[['put']]<-NULL
  tmp[['revert_clone']]<-NULL
  tmp$group=tmp$group[sapply(tmp$group,nnull)]
  #tmp$filter=c(tmp$filter,'.sortable-options')
  if(len0(tmp$group))tmp$group=NULL
  if(len0(tmp))return(
    "{}"
  )
  tmp<-tmp[sapply(tmp,nnull)]

  jsonlite::toJSON(tmp, auto_unbox = TRUE, json_verbatim = TRUE)


  }

sortable_options()
sortableDiv=function(...,inputId,options=sortable_options()){
  fn_description("Create a sortable div")
  fn_returns("HTML")
  assert_string(inputId)

  dots <-list(...)
  attrs = dots[have_name(dots)]
  childern = dots[!have_name(dots)]
  if(!all(sapply(childern,tagHasAttribute,attr='data-id')))
    g_stop('All elements in a sortable div must have a `data-id` attribute.')
  sortableTag<-div(id=inputId,class='sortable-div', !!!childern ,tags$script(type = "application/json",`data-for` =inputId,`data-id`='sortable-options',options)) %>%
    tagAppendAttributes(!!!attrs)
  tagList( sortableTag,html_dependency_sortable_JS())

}

fn_document(sortableDiv,{
  sortableDiv(class='p-1',
              inputId='sortablejs1',
              div(class='m-1 bg-secondary',`data-id`="one",'one'),
              div(class='m-1 bg-secondary',`data-id`="two",'two'),
              div(class='m-1 bg-secondary',`data-id`="three",'three'), options=sortable_options(name="things")
  )
})

updateSortableDiv<- function(inputId,...,order = NULL,append=NULL,remove=NULL,replace=NULL,session = getDefaultReactiveDomain()) {
  options=list(...)
  assert_subset(names(options),choices=fn_fmls_names(assert_sortable_options))
  assert_sortable_options(...)

  if(nnull(append)){
    insertUI(
      selector=inputId,
      where = c("beforeEnd"),
      append,
      multiple = FALSE,
      immediate = FALSE,
      session = session)

  }
  message <- drop_nulls(
    list(
      value =  order,
      remove=remove
    )
  )
  session$sendInputMessage(inputId, message)
}

sortable_options()
shiny_example_template("sortablejs")





    library("shiny")
    library("ShinyReboot")
    library("bootstraplib")
    bs_global_theme()
    ui <- fluidPage(bs_dependencies(theme = bs_global_get()),
                    tags$h1("sortablejs"),

                    fluidRow(
                    column(6,

                    h6("List1"),
                    sortableDiv(class='p-1',
                      inputId='sortablejs1',
                      div(class='m-1 bg-secondary',`data-id`="one",'one'),
                      div(class='m-1 bg-secondary',`data-id`="two",'two'),
                      div(class='m-1 bg-secondary',`data-id`="three",'three'), options=sortable_options(name="things")
                    ),
                    verbatimTextOutput(outputId = "res"),
                    h6("List3"),
                    sortableDiv(class='p-1',
                                inputId = 'sortablejs3',
                                div(class = 'm-1 bg-success', `data-id` = "one2", 'one'),
                                div(class = 'm-1 bg-success', `data-id` = "two2", 'two'),
                                div(class = 'm-1 bg-success', `data-id` = "three2", 'three'),
                                options = sortable_options(name = "things")
                    )),
                    column(6,
                    uiOutput("sort2"),
                    verbatimTextOutput(outputId = "res2"),
                    h6("List4"),
                    sortableDiv(class='p-1',
                                inputId = 'sortablejs4',
                                div(class = 'm-1 bg-warning', `data-id` = "one", 'one'),
                                div(class = 'm-1 bg-warning', `data-id` = "two", 'two'),
                                div(class = 'm-1 bg-warning', `data-id` = "three", 'three'),
                                options = sortable_options(name = "things",put=list(class_types=c('bg-warning','bg-success')))
                    ))))
    server <- function(input, output, session) {
      output$res <- renderPrint(input$sortablejs1)
      output$res2 <- renderPrint(input$sortablejs2)

      output$sort2<-renderUI({
        tagList(
          h6("List2"),
        sortableDiv(class='p-1',
          inputId = 'sortablejs2',
          div(class = 'm-1 bg-primary', `data-id` = "one2", 'one'),
          div(class = 'm-1 bg-primary', `data-id` = "two2", 'two'),
          div(class = 'm-1 bg-primary', `data-id` = "three2", 'three'),
          options = sortable_options(name = "things")
        ))
      })

    }
    shinyApp(ui, server)





