#' Update a sortableDiv

#' @name updateSortableDiv

#' @param inputId the id of the sortable
#' @param ... sortable options to update
#' @param content Shiny tag or list of shiny tags.  Replaces the content of the sortable. Each element should have a data-id attribute.
#' @param order character vector of data ids.  Updates the order of the list.
#' @param append Shiny tag or list of shiny tags. Appends the content of the sortable. Each element should have a data-id attribute.
#' @param clear [Logical(1)] If TRUE, the content of the sortable will be removed.
#'
#'
#' @export
updateSortableDiv<- function(..., inputId,content=NULL,order = NULL,append=NULL,clear=FALSE,session = getDefaultReactiveDomain()) {

  options=list(...)
  assert_subset(names(options),choices=fn_fmls_names(assert_sortable_options))
  assert_sortable_options(...)
  assert_logical(clear)
  assert_any(content,
             check_class(classes="shiny.tag",null.ok = TRUE),
             check_list(types='shiny.tag'))
  assert_character(order,null.ok = TRUE)
  assert_any(append,
             check_class(classes="shiny.tag",null.ok = TRUE),
             check_list(types='shiny.tag'))


  if(nnull(append)){
    if(!all(sapply(append,tagHasAttribute,attr='data-id')))
       g_stop('All elements in a sortable div must have a `data-id` attribute.')
    if(is(append,'shiny.tag.list'))append=lapply(append,as.character) %>% unlist()
    append=as.character(append)%sep%""


  }
  if(nnull(content)){
    if(!all(sapply(content,tagHasAttribute,attr='data-id')))
       g_stop('All elements in a sortable div must have a `data-id` attribute.')
    if(is.list(content)&&!is(content,'shiny.tag'))content=lapply(content,as.character) %>% unlist()
    content=as.character(content) %sep%""

  }
  if(clear){
    content=""
  }
  #print(content)
  message <- drop_nulls(
    list(
      order =  order,
      options=options,
      append=append,
      content=content
    )
  )
  session$sendInputMessage(inputId, message)
}
