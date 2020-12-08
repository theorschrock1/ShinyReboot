
#' @import glue
#' @import stringr
#' @import shiny
#' @import exprTools
#' @import htmltools
#' @import checkmate
#' @import rlang
#' @import sUtils
#' @importFrom jsonlite toJSON
#' @importFrom shinyWidgets pickerInput pickerOptions
#' @export
undisplay <- function(tag) {
  # if not already hidden
  if (
    !is.null(tag$attribs$style) &&
    !grepl("display:\\s+none", tag$attribs$style)
  ) {
    tag$attribs$style <- paste(
      "display: none;",
      tag$attribs$style
    )
  } else {
    tag$attribs$style <- "display: none;"
  }
  tag
}

#' @export
display <- function(tag) {
  if (
    !is.null(tag$attribs$style) &&
    grepl("display:\\s+none", tag$attribs$style)
  ) {
    tag$attribs$style <- gsub(
      "(\\s)*display:(\\s)*none(\\s)*(;)*(\\s)*",
      "",
      tag$attribs$style
    )
  }
  tag
}

#' @export
menu_divider=function(type){
  assert_choice(type,c("-","|"))
  class=char_approxfun(c("-","|"),c("dropdown-divider","separator"))(type)
  div(class=class)
}
#' @export
add_dividers=function(...,type){
  paste2 <- function(x, y, sep = "") paste(x, y, sep = sep)
  content<-list(...) %>% lapply(as_glue)
  seps=rep(as_glue(menu_divider(type)),(length(content)-1))
  HTML(reduce2(content,seps,paste2))
}

#' @export
'.'=function(...){
  list(...)
}
#' @export
tmpids=function(n){
  sapply(1:n,function(x)paste0('id',create_unique_id(4)))
}
#' @export
checkTagListFormat=function(children){
  if(class(children)=='list'&&length(children)==1&&class(children[[1]])=='list'&&(class(children[[1]][[1]])=="shiny.tag"|class(children[[1]][[1]])=="shiny.tag.list")){
    return(children[[1]])
  }
  children
}

#' @export
code_has_errors=function(code){!all(code%>% str_count("\\}")==code%>%str_count("\\{") ,
                               code%>% str_count("\\)")==code%>% str_count("\\("),
                               code%>% str_count("\\[")==code%>% str_count("\\]"),
                               code%>% str_count('\\"')%%2==0,
                               code%>% str_count("\\'")%%2==0
)
}

#' @export
check_valid_fn_string=function(x,null.ok=FALSE){

  if(is.null(x)&&!null.ok)
    return("Must not be NULL")
  if(is.null(x)&&null.ok)
    return(TRUE)
  res=check_string(x)
  if(!isTRUE(res))
    return(res)
  res=grepl(start_with('function\\('),x)
  if(!isTRUE(res))
    return("Must be in a 'function(){...}' format")
  res=grepl(ends_with('}'),x)
  if(!isTRUE(res))
    return("Must be in a 'function(){...}' format")
  openPcloseP=str_count(x,"\\(")+str_count(x,"\\)")

  if(openPcloseP<2|openPcloseP%%2!=0)
    return("Missing parantheses")
  openBcloseB=str_count(x,"\\{")+str_count(x,"\\}")
  if(openBcloseB<2|openBcloseB%%2!=0)
    return("Missing bracket {}")

  if(code_has_errors(x))
    return("Missing [] or unclosed quotation")
  return(TRUE)
}
#' @export
assert_valid_fn_string= makeAssertionFunction(check_valid_fn_string)
tmpids=function(n){
  sapply(1:n,function(x)paste0('id',create_unique_id(4)))
}

JQ=function(...){
  tmp<-enexprs(...) %>% exprs_deparse() %>% unlist()
  tmp=str_replace_all(tmp,"\\$","\\.") %>% str_replace_all(start_with("JQ"),"$")
  out<-tmp %sep%";\n"
  glue('{out};')
}
JsFn=function(...){
  tmp<-enexprs(...) %>% exprs_deparse() %>% unlist()
  tmp=str_replace_all(tmp,"\\$","\\.") %>% str_replace_all("JQ","$")
  out<-tmp %sep%";\n"
  str_replace_all(out,'\\)\n',"\\);\n")%sep%""
}
genSortableCallbacks=function(cb){

  glue_data(cb,"onChoose: function (/**Event*/ evt) {
  &&onChoose&&
},

// Element is unchosen
onUnchoose: function (/**Event*/ evt) {
     &&onUnchoose&&
},

// Element dragging started
onStart: function (/**Event*/ evt) {
   &&onStart&&
},

// Element dragging ended
onEnd: function (/**Event*/ evt) {
  &&onEnd&&
  item=evt.from;

   divIds = $(   item).children().
            map(function(i,div){return div.id}).
            get();
   Shiny.setInputValue('&&inputId&&',divIds);

},

// Element is dropped into the list from another list
onAdd: function (/**Event*/ evt) {
   &&onAdd&&
   item=evt.to;
   divIds = $(   item).children().
            map(function(i,div){return div.id}).
            get();
   Shiny.setInputValue('&&inputId&&',divIds);
},

// Changed sorting within list
onUpdate: function (/**Event*/ evt) {
  &&onUpdate&&
},

// Called by any change to the list (add / update / remove)
onSort: function (/**Event*/ evt) {
 &&onSort&&
},

// Element is removed from the list into another list
onRemove: function (/**Event*/ evt) {
  &&onRemove&&
},

// Attempt to drag a filtered element
onFilter: function (/**Event*/ evt) {
   &&onFilter&&
},

// Event when you move an item in the list or between lists
onMove: function (/**Event*/ evt, /**Event*/ originalEvent) {
 &&onMove&&
},

// Called when creating a clone of element
onClone: function (/**Event*/ evt) {
    &&onClone&&
},
	// Called when an item is selected
onSelect: function(/**Event*/evt) {
		&&onSelect&&
	},

	// Called when an item is deselected
onDeselect: function(/**Event*/evt) {
			&&onDeselect&&
	},
// Called when dragging element changes position
onChange: function (/**Event*/ evt) {
  &&onChange&&
  }",.open="&&",.close="&&")
}
genSplitCallbacks=function(cb){

  glue_data(cb,'"onDrag":"function(sizes){&&onDrag&&}","onDragStart":"function(sizes){&&onDragStart&&}","onDragEnd":"function(sizes){&&onDragEnd&&}"',.open="&&",.close="&&")
}


#' @export
get_bs4_hex<-function(name=NULL){

  bootstrapColors<- list(
    blue = '#007bff',
    indigo = '#6610f2',
    purple = '#6f42c1',
    pink = '#e83e8c',
    red = '#dc3545',
    orange = '#fd7e14',
    yellow = '#ffc107',
    green = '#28a745',
    teal = '#20c997',
    cyan = '#17a2b8',
    white = '#fff',
    gray = '#6c757d',
    gray_dark = '#343a40',
    default = '#dee2e6',
    primary = '#007bff',
    secondary = '#6c757d',
    success = '#28a745',
    info = '#17a2b8',
    warning = '#ffc107',
    danger = '#dc3545',
    light = '#f8f9fa',
    dark = '#343a40',
    none = 'transparent'
  )
  if(is.null(name))return(bootstrapColors)
  if(grepl(start_with("#"),name))return(name)
  assert_choice(name,choices=names(bootstrapColors),null.ok=TRUE)

  bootstrapColors[[name]]
}

