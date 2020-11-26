#' Create a div with resizable rows or columns.

#' @name split_div
#' @param ... inner html (the rows to split)
#' @param class [character(1)] outer div class (the rows to split)
#' @param style [character(1)] outer div style (the rows to split)
#' @param id  [character] the id of the outer div. Defaults to NULL
#' @param sizes  [Number or Array] Initial sizes of each element in percents or CSS. Defaults to NULL
#' @param minSizes  [Number or Array] Number or Array 	Minimum size of each element. Defaults to NULL
#' @param direction [string] 	Direction to split: horizontal or vertical. Defaults to 'horizontal'.
#' @param expandToMin  [logical] Grow initial sizes to minSize Defaults to TRUE
#' @param gutterSize  [numeric]  Gutter size in pixels. Defaults to 10.
#' @param  gutterAlign [string]  choices: "start","center" or "end". Gutter alignment between elements. Defaults to 'center'.
#' @param  gutterAttrs [named_list(htmlTag='character(1)',class=character(1)',text='character(length(innerhtml)-1)')] Useful if gutters should contain labels
#' @param snapOffset  [numeric]  Snap to minimum size offset in pixels. Defaults to 30
#' @param dragInterval  [numeric] Number of pixels to drag. Defaults to 1
#'                    gutterFunc=NULL, 	#JS Function 		Called to create each gutter element
#' @param elementStyle [JS Function] Called to set the style of each element. Defaults to NULL
#' @param gutterStyle [JS Function] Called to set the style of the gutter. Defaults to NULL
#' @param onDrag [JS Function] Callback on drag. Defaults to NULL
#' @param onDragStart [JS Function] Callback on drag start. Defaults to NULL
#' @param onDragEnd [JS Function] Callback on drag end. Defaults to NULL
#' @return \code{split_div}: html

#' @export
split_div=function(...,
                   id, #string //id of the outer div (used to create ids of inner div, inner div ids will be overwritten if present)
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
  fn_description("Create a div with resizable rows or columns")
  fn_returns("html")
  innerHTML<-list(...)


  assert_character(id,len=1)
  assert_character(class,len=1,null.ok = TRUE)
  assert_character(style,len=1,null.ok = TRUE)
  assert_numeric(sizes,len=length(innerHTML),null.ok = TRUE)
  assert_numeric(minSize)
  assert_logical(expandToMin)
  assert_number(gutterSize)
  assert_choice(gutterAlign,choices=c("start","center","end"))
  assert_number(snapOffset)
  assert_choice(direction,c("horizontal","vertical"))
  assert_list(gutterAttrs,len=3,null.ok = T)

  # childs=1:l(  innerHTML)
  # split_ids=glue("'#{id} > :nth-child({childs})'")%sep%","
  ids=paste0(id,'-id',1:l(  innerHTML))
  split_ids=paste0("'#",ids,"'")%sep%","
  #if(any(sapply(innerHTML,function(x)has_name(x,"id"))==F))g_stop("all html elements must have unique ids")
  innerHTML=map2(innerHTML,ids,function(x,y){
    x$attribs$id<-y
    x
  })
  if(nnull(gutterAttrs)){
    assert_names(names(gutterAttrs),must.include=c("htmlTag","class","text"))
    assert_character(gutterAttrs$text,len=length(innerHTML)-1)
    assert_character(gutterAttrs$class,len=1)
    assert_character(gutterAttrs$htmlTag,len=1)
    gutter_classes=c(glue("gutter gutter-{direction}"),gutterAttrs$class)%sep%" "
    gutter_text=c("'none'",glue("'{gutterAttrs$text}'"))%sep%","

    gutterFunc=glue("function(index, direction){
      gutterText=[&gutter_text&]
      const gutter = document.createElement('&gutterAttrs$htmlTag&')
      gutter.className = '&gutter_classes&'
      gutter.textContent=  gutterText[index]
      return gutter
    }",.open="&",.close="&")
  }
  cursor="row-resize"
  if(direction=="horizontal")cursor="col-resize"
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
  if(!is.null(sizes)){
    sizes=  sizes*100
    args$sizes<-c("[",sizes%sep%",","]")%sep%" "

  }
  args$minSize<-c("[",  minSize%sep%",","]")%sep%" "
  args<- args[sapply( args,nnull)]
  notchar=   c("gutter"," elementStyle","gutterStyle","onDrag","onDragStart"," onDragEnd","sizes","minSize")
  callback_ops=args[(grepl("^on",names( args)))]
  callback_ops<-lapply(callback_ops,function(x){
    if(nnull(x))return(x)
    ""
  })
  args= args[!(grepl("^on",names( args)))]
  args<- args[sapply( args,nnull)]
  args[names(args)%nin%notchar]<-
    lapply(args[names(args)%nin%notchar],function(x){
      if(!is.character(x))return(x)
      glue("'{x}'")
    })

  args<-lapply(args,function(x){
    if(!is.logical(x))return(x)
    tolower(as.character(x))
  })


  argsIn<-paste0(names(args),":",unlist(args))%sep%",\n"
  print(callback_ops)

  if(is.null(onDragStart))callback_ops$onDragStart<-""
  if(is.null(onDragEnd))callback_ops$onDragEnd<-""
  if(is.null(onDrag))callback_ops$onDrag<-""


  cb<-genSplitCallbacks(callback_ops)
  scpt=HTML(glue('$(function(){
  Split([&split_ids&], {
   &argsIn&,
   &cb&
    });\n});',.open="&",.close="&"))
  inner=expr_eval(list(!!!innerHTML))
expr_eval(div(id=id,class=class,style=style,!!!inner,!!tags$script(scpt)))
}
