#' Create a div with sortable elements.

#' @name sortable_div

#' @param inputId [string] shiny input id and id of outer div.
#' @param ... innerHTML (sortable items)
#' @param class [character(1)] outer div class
#' @param style [character(1)] outer div style
#' @param group group name from sharable lists. name or list(name,pull=[true|false|["foo", "bar"]|'clone'|function],put=[true|false|["foo", "bar"]|'clone'|function]],revertClone=[true|false])
#' @param sort [logical] Is the list sortable? Defaults to TRUE.
#' @param delay [number] ms, Drag delay.
#' @param delayOnTouchOnly [logical] Use Drag delay on mobile/touch devices. Defaults to FALSE.
#' @param multiDrag=NULL,
#' @param touchStartThreshold=0,
#' @param removeOnSpill [logical]  Remove item on spill. Defaults to FALSE.
#' @param disabled [logical] Disables the sortable if set to true. Defaults to FALSE.
#' @param store #see Store on sortable.js github.
#' @param animation [number] ms, animation speed moving items when sorting, `0` — without animation. Defaults to 150.
#' @param easing= [string]  Easing for animation. Defaults to null. See https://easings.net/ for examples. Defaults to  "cubic-bezier(1, 0, 0, 1)".
#' @param handle [string (css class)] Drag handle selector within list items. Defaults to NULL.
#' @param filter [string (css class)] Selectors that do not lead to dragging (String or Function). Defaults to NULL.
#' @param preventOnFilter [logical] Call `event.preventDefault()` when triggered `filter`
#' @param draggable [string (css class)] Specifies which items inside the element should be draggable.
#' @param dataIdAttr [string (css class)] Defaults to"data-id".
#' @param ghostClass [string (css class)] Class name for the drop placeholder
#' @param chosenClass [string (css class)] Class name for the chosen item
#' @param dragClass [string (css class)] Class name for the dragging item
#' @param selectedClass [string (css class)] Class name for the selected item/s
#' @param swapThreshold [number range(0,1)]  Threshold of the swap zone.  Defaults to 1.
#' @param invertSwap=[logical] Will always use inverted swap zone if set to TRUE. Defaults to TRUE
#' @param invertedSwapThreshold  [number range(0,1)] Threshold of the inverted swap zone (will be set to swapThreshold value by default. Defaults to .5.
#' @param direction ["horizontal"|"vertical"]  Direction of Sortable (will be detected automatically if not given). Defualts to "horizontal".
#' @param swap [logical] #// Enable swap mode. [logical]
#' @param swapClass [character(1)] Class name for swap item (if swap mode is enabled). Defaults to NULL.
#' @param forceFallback [logical] ignore the HTML5 DnD behaviour and force the fallback to kick in. Defaults to FALSE.
#' @param fallbackClass [character(1)] Class name for the cloned DOM Element when using forceFallback. Defaults to NULL.
#' @param fallbackOnBody [logical] Appends the cloned DOM Element into the Document's Body. Defaults to FALSE
#' @param fallbackTolerance [number], Specify in pixels how far the mouse should move before it's considered as a drag. Defaults to 0
#' @param dragoverBubble [logical] Defaults to FALSE.
#' @param removeCloneOnHide [logical] Remove the clone element when it is not showing, rather than just hiding it. Defaults to TRUE
#' @param multiDragKey [string] Key that must be down for items to be selected. Defaults to NULL
#' @param InsertThreshold [number] px, distance mouse must be from empty sortable to insert drag element into it
#' @param onChoose [JS] Element is choosen. Defaults to NULL.
#' @param onUnchoose  [JS] Element is unchosen. Defaults to NULL.
#' @param onStart [JS]  Element dragging started. Defaults to NULL.
#' @param onEnd [JS] Element dragging ended. Defaults to NULL.
#' @param onAdd [JS] Element is dropped into the list from another list. Defaults to NULL.
#' @param onUpdate  [JS] Changed sorting within list. Defaults to NULL.
#' @param onSort  [JS] Called by any change to the list (add / update / remove). Defaults to NULL.
#' @param onRemove  [JS] Element is removed from the list into another list. Defaults to NULL.
#' @param onFilter [JS] Attempt to drag a filtered element. Defaults to NULL.
#' @param onMove [JS] Called when you move an item in the list or between lists. Defaults to NULL.
#' @param onClone [JS] Called when creating a clone of element. Defaults to NULL.
#' @param onChange [JS] Called when dragging element changes position. Defaults to NULL.
#' @param onSelect [JS] Called when an element is selected. Defaults to NULL.
#' @param Deselect [JS] Called when an element is deselected. Defaults to NULL.
#' @return \code{sortable_div}: HTML

#' @export
sortable_div=function(...,inputId,
  class=NULL,
  style=NULL,
  group=NULL, #name or list(name,pull=[true|false|["foo", "bar"]|'clone'|function],put=[true|false|["foo", "bar"]|'clone'|function]],revertClone=[true|false])
  sort=TRUE,
  delay=0,
  delayOnTouchOnly=FALSE,
  multiDrag=NULL,
  touchStartThreshold=0,
  removeOnSpill=FALSE,#Remove item on spill
  disabled=FALSE, #Disables the sortable if set to true.
  store=NULL, #see Store
  animation= 150, # ms, animation speed moving items when sorting, `0` — without animation
  easing= "cubic-bezier(1, 0, 0, 1)",# Easing for animation. Defaults to null. See https://easings.net/ for examples.
  handle=NULL,# // Drag handle selector within list items
  filter=NULL,# Selectors that do not lead to dragging (String or Function)
  preventOnFilter=TRUE, # Call `event.preventDefault()` when triggered `filter`
  draggable=NULL,# Specifies which items inside the element should be draggable
  dataIdAttr= "data-id",
  ghostClass= NULL, #Class name for the drop placeholder
  chosenClass= NULL,#Class name for the chosen item
  dragClass=NULL,#Class name for the dragging item
  selectedClass=NULL,
  swapThreshold= 1,# Threshold of the swap zone
  invertSwap=TRUE, # Will always use inverted swap zone if set to true
  invertedSwapThreshold=.5,# // Threshold of the inverted swap zone (will be set to swapThreshold value by default)
  direction="horizontal",# Direction of Sortable (will be detected automatically if not given)
  swap=NULL, #// Enable swap mode
  swapClass=NULL,# // Class name for swap item (if swap mode is enabled)
  forceFallback=FALSE, #ignore the HTML5 DnD behaviour and force the fallback to kick in

  fallbackClass="sortable-fallback",# // Class name for the cloned DOM Element when using forceFallback
  fallbackOnBody=FALSE,# // Appends the cloned DOM Element into the Document's Body
  fallbackTolerance=0, #// Specify in pixels how far the mouse should move before it's considered as a drag.
  dragoverBubble=FALSE,
  removeCloneOnHide=TRUE,# // Remove the clone element when it is not showing, rather than just hiding it
  multiDragKey=NULL,# // Key that must be down for items to be selected
  emptyInsertThreshold=5, #// px, distance mouse must be from empty sortable to insert drag element into it
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

  tmp=args2list()
  tmp$`...`<-NULL
  tmp$inputId<-NULL
  tmp$class<-NULL
  tmp$style<-NULL
  callback_ops=tmp[(grepl("^on",names(tmp)))]
  callback_ops<-lapply(callback_ops,function(x){
    if(nnull(x))return(x)
    ""
  })
  tmp=tmp[!(grepl("^on",names(tmp))|names(tmp)==
              "setData")]
  tmp<-tmp[sapply(tmp,nnull)]


  tmp[!(grepl("^on",names(tmp))|names(tmp)==
          "setData")]<-
    lapply(tmp[!(grepl("^on",names(tmp))|names(tmp)==
                   "setData")],function(x){
                     if(!is.character(x))return(x)
                     if(is.character(x)&&len1(x)&&grepl("^function\\(",x))return(x)
                     glue("'{x}'")
                   })

  tmp<-lapply(tmp,function(x){
    if(!is.logical(x))return(x)
    tolower(as.character(x))
  })


  if(is.list( tmp$group)){
    tmp$group<-lapply(tmp$group,function(x){
      if(!is.character(x))return(x)
      if(is.character(x)&&len1(x)&&grepl("^function\\(",x))return(x)
      out=glue("'{x}'")
      if(len(out)>1)out=glue('[{out%sep%","}]')
      out
    })
    tmp$group<-lapply(tmp$group,function(x){
      if(!is.logical(x))return(x)
      tolower(as.character(x))
    })
    tmp$group<-c('{',
                 paste0(names(tmp$group),":",unlist(tmp$group))%sep%",\n",
                 '}')%sep%"\n"
  }

  opts=tmp[!(grepl("^on",names(tmp))|names(tmp)==
               "setData")]
  jq=""
if(disabled==TRUE){
 jq= glue('$("#&&inputId&&").on("dragenter",function() {
    sortable.option("disabled", false);
    console.log("enabled");
  });
  $("#&&inputId&&").on("dragleave",function() {
    sortable.option("disabled", true);
    console.log("disabled");
  });',.open="&&",.close="&&")
}
  callback_ops$inputId<-inputId
  cb<-genSortableCallbacks(callback_ops)
  opts<-paste0(names(opts),":",unlist(opts))%sep%",\n"
  options= glue('$(function(){
  let sortable=new Sortable(&&inputId&&,{
  &&opts&&,
  &&cb&&
});
  &&jq&&
});
                ',.open="&&",.close="&&")

 tagList(div(id=inputId,class=class,style=style,...),tags$script(HTML(options)))
}


