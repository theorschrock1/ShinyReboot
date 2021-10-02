#' Create a div with resizable rows or columns.

#' @name split_div
#' @param ... inner html (the rows to split)
#' @param inputId  [character] the shiny inputId and id of the outer div. Defaults to NULL.  If null, a random id will be generated.
#' @param class [character(1)] outer div class (the rows to split)
#' @param style [character(1)] outer div style (the rows to split)
#' @param sizes  [Number or Array] Initial sizes of each element in percents or CSS. Defaults to NULL
#' @param minSizes  [Number or Array] Number or Array 	Minimum size of each element. Defaults to NULL
#' @param direction [string] 	Direction to split: horizontal or vertical. Defaults to 'horizontal'.
#' @param expandToMin  [logical] Grow initial sizes to minSize Defaults to TRUE
#' @param gutterSize  [numeric]  Gutter size in pixels. Defaults to 10.
#' @param  gutterAlign [string]  choices: "start","center" or "end". Gutter alignment between elements. Defaults to 'center'.
#' @param  gutterAttrs [named_list(gutterTag='character(1)',class=character(1)',innerHtml='length(splitElements)-1)')] Useful if gutters should contain labels
#' @param snapOffset  [numeric]  Snap to minimum size offset in pixels. Defaults to 30
#' @param dragInterval  [numeric] Number of pixels to drag. Defaults to 1
#'                    gutterFunc=NULL, 	#JS Function 		Called to create each gutter element
#' @param elementStyle [JS Function] Called to set the style of each element. Defaults to NULL
#' @param gutterStyle [JS Function] Called to set the style of the gutter. Defaults to NULL
#' @param onDrag [JS Function] Callback on drag. Defaults to NULL
#' @param onDragStart [JS Function] Callback on drag start. Defaults to NULL
#' @param onDragEnd [JS Function] Callback on drag end. Defaults to NULL
#' @return \code{split_div}: html
#' @examples
#'  if(interactive()){
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'  bs_global_theme()
#'  ui <- fluidPage(bs_theme_dependencies(
#'  theme = bs_global_get()),
#'
#'  tags$h1("Split Div: Custom Gutters"),
#'
#'  splitCol(inputId='splitCol1',
#'  style='height:400px;',
#'  gutterSize = 30,
#'  div(class='bg-secondary',"div1"),
#'  div(class='bg-secondary',"div2"),
#'  div(class='bg-secondary',"div3"),
#'  gutterAttrs = list(
#'  gutterTag = 'div',
#'  class = 'my_gutter',
#'  innerHtml = list(
#'  actionButton(inputId='gr2', label='gutter1',class='btn btn-sm btn-dark'),
#'  actionButton(inputId='gr2', label= 'gutter2',class='btn btn-sm btn-dark')
#'  )
#'  )
#'  ),
#'
#'  verbatimTextOutput(outputId = "res1"))
#'  server <- function(input, output, session) {
#'
#'  output$res1=renderPrint({
#'  input$splitCol1
#'  })
#'  }
#'  shinyApp(ui, server)
#'  }

#' @export
split_div=function(...,
                    inputId=NULL, #string //id of the outer div (used to create ids of inner div, inner div ids will be overwritten if present)
                    class=NULL, #string //class of the outer div
                    style=NULL, #string //style of the outer div
                    sizes=NULL, 	#Array //Initial sizes of each element in percents or CSS values.
                    minSize=100, 	#Number or Array 	100 	Minimum size of each element.
                    expandToMin=FALSE, 	#Boolean 	false 	Grow initial sizes to minSize
                    gutterSize=10,
                    #Number 	10 	Gutter size in pixels.
                    gutterAlign='center', 	#String 	'center' 	Gutter alignment between elements.
                    snapOffset=30, 	#Number 	30 	Snap to minimum size offset in pixels.
                    dragInterval=1, 	#Number 	1 	Number of pixels to drag.
                    direction='horizontal', 	#String 	'horizontal' 	Direction to split: horizontal or vertical.
                    gutterAttrs=NULL, #list(htmlTag,class,text)
                    gutterFunc=NULL, 	#JS Function 		Called to create each gutter element
                    elementStyle=NULL, #JS Function 		Called to set the style of each element.
                    gutterStyle =NULL,	#JS Function  		Called to set the style of the gutter.
                    onDrag=NULL, 	#JS Function 		Callback on drag.
                    onDragStart=NULL, 	#JS Function 		Callback on drag start.
                    onDragEnd=NULL 	#JS Function 		Callback on drag end.
){

  innerHTML<-list(...)

  if(is.null(inputId))inputId=paste0('sp-js',create_unique_id(3))
  assert_character(inputId,len=1)
  assert_character(class,len=1,null.ok = TRUE)
  assert_character(style,len=1,null.ok = TRUE)
  assert_numeric(sizes,len=length(innerHTML),null.ok = TRUE)
  if(sum(sizes)>1)
    g_stop("sum of split div sizes should equal 1")
  sizes[1]=sizes[1]+(1-sum(sizes))
  sizes=sizes*100
  assert_numeric(minSize)
  assert_logical(expandToMin)
  assert_number(gutterSize)
  assert_choice(gutterAlign,choices=c("start","center","end"))
  assert_number(snapOffset)
  assert_choice(direction,c("horizontal","vertical"))
  assert_list(gutterAttrs,len=3,null.ok = T)
  assert_valid_fn_string(onDrag,null.ok = TRUE)
  assert_valid_fn_string(onDragEnd,null.ok = TRUE)
  assert_valid_fn_string(onDragStart,null.ok = TRUE)
  # childs=1:l(  innerHTML)
  # split_ids=glue("'#{id} > :nth-child({childs})'")%sep%","
  ids=paste0(inputId,'-split-id-',1:l(  innerHTML))
  #split_ids=paste0("#",ids)
  split_ids=glue('[data-id="{ids}"]')
  #if(any(sapply(innerHTML,function(x)has_name(x,"id"))==F))g_stop("all html elements must have unique ids")
  innerHTML=map2(innerHTML,ids,function(x,y){
    #x$attribs$id<-y
    x$attribs$`data-id`<-y
    x
  })

  cursor="row-resize"
  if(direction=="horizontal")cursor="col-resize"
  gutterFunc<-
    create_gutters(gutterAttrs,n_gutters=l( innerHTML)-1)%or%gutterFunc
  args<-list(sizes=sizes,
             minSize=minSize,
             expandToMin=  expandToMin,
             gutterSize=  gutterSize,
             gutterAlign=gutterAlign,
             cursor=cursor,
             snapOffset=snapOffset,
             dragInterval=dragInterval,
             direction=direction,
             gutter=gutterFunc,
             elementStyle=elementStyle,
             gutterStyle =gutterStyle,
             onDrag=onDrag,
             onDragStart=onDragStart,
             onDragEnd=  onDragEnd)


  args<- args[sapply( args,nnull)]

  # callback_ops=args[(grepl("^on",names( args)))]
  #
  # args= args[!(grepl("^on",names( args)))]
  # args<- args[sapply( args,nnull)]


  # callback_ops$onDragStart='$(.ace_editor").each(function(){
  #   $(this).data("aceEditor").resize(true);
  # });'
  #
  # if(is.null(onDragStart))callback_ops$onDragStart<-""
  # if(is.null(onDragEnd))callback_ops$onDragEnd<-""
  # if(is.null(onDrag))callback_ops$onDrag<-""
  # args$CALLBACK<-"CALLBACKS"
  #
  # cb<-genSplitCallbacks(callback_ops)


  out<-toJSON(list(split_ids=split_ids,options=args), auto_unbox = TRUE, json_verbatim = TRUE)
  #as_glue(str_replace_all(out,'"CALLBACK":"CALLBACKS"', cb))
  # tags$script(
  #   type = "application/json",
  #   `data-for` =inputId,
  #   out
  # )

  splitTag=div(id=inputId,class=class,style=style,!!!innerHTML,
   tags$script(
    type = "application/json",
    `data-for` = inputId,
      HTML(out)
  )) %>% tagAppendAttributes(class='split-div')

 attachDependencies( splitTag,html_dependency_split_JS() )
}


create_gutters=function(gutterAttrs,n_gutters){
  if(is.null(gutterAttrs))return()
  assert_names(names(gutterAttrs),must.include=c("gutterTag","class","innerHtml"))
  if(length(gutterAttrs$innerHtml)!=n_gutters){
    g_stop("Number of gutter text attributes must equal {n_gutters}, not {length(gutterAttrs$innerHtml)}")
  }
  assert_character(gutterAttrs$class,len=1)
  assert_character(gutterAttrs$gutterTag,len=1)
  gutter_classes=paste("gutter gutter-${direction}",gutterAttrs$class)
  text=unlist(lapply(gutterAttrs$innerHtml,as.character))
  gutter_text=toJSON(c("",text))

    gutterFunc=glue("function(index, direction){gutterText=&gutter_text&;const gutter = document.createElement('&gutterAttrs$gutterTag&');gutter.className = `&gutter_classes&`;$(gutter).html(gutterText[index]);return gutter;}",.open="&",.close="&")
    gutterFunc
}



