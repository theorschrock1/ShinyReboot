#' Configuation options for divs with sortable elements.

#' @name sortable_options

#' @param name group name from sharable lists
#' @param pull [TRUE|FALSE|character(group_names)|'clone']
#' @param put [TRUE|FALSE|c(group_names)|list(class_names=c())] If True, items with the same group name can be put into the list.  If FALSE, no outside items can be put into the list. If a vector of group names, items from specified sortable can be put into the list.  If a list of class names, items with only with specfied class name can be put into the list.
#' @param revertClone [logical(1)] Revert cloned element to initial position after moving to a another list.
#' @param sort [logical] Is the list sortable? Defaults to TRUE.
#' @param delay [number] ms, Drag delay.
#' @param delayOnTouchOnly [logical] Use Drag delay on mobile/touch devices. Defaults to FALSE.
#' @param multiDrag [logical] Enable multidrag.
#' @param deselectOnBody [logical] Deselect selected elements when a click occurs outside the sortable? Defaults to TRUE.
#' @param touchStartThreshold=0,
#' @param removeOnSpill [logical]  Remove item on spill. Defaults to FALSE.
#' @param revertOnSpill  [logical] Revert item to original sortable on spill.
#' @param disabled [logical] Disables the sortable if set to true. Defaults to FALSE.
#' @param store #see Store on sortable.js github.
#' @param animation [number] ms, animation speed moving items when sorting, `0` — without animation. Defaults to 150.
#' @param easing [string]  Easing for animation. Defaults to null. See https://easings.net/ for examples. Defaults to  "cubic-bezier(1, 0, 0, 1)".
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
#' @param setData [JS] 'dataTransfer' object of HTML5 DragEvent.
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
#' @param onSpill [JS] Called when an elements is spilled outside a sortable. Defaults to NULL.
#' @parem customGetValueFn [JS] Called when the shiny binding gets the value of the input. Defaults to NULL.
#' @return \code{sortable_options}: HTML[JSON]

#' @export
sortable_options=function(
name=NULL, #name or list(name,pull=[true|false|["foo", "bar"]|'clone'|function],put=[true|false|["foo", "bar"]|'clone'|function]],revertClone=[true|false])
pull=NULL,#[true|false|["foo", "bar"]|'clone'|function]]
put=NULL,#TRUE|FALSE|list(group_names=c())|list(class_names=c()]
revertClone=NULL,#TRUE|FALSE
sort=NULL,
delay=NULL,
delayOnTouchOnly=NULL,
multiDrag=NULL,
deselectOnBody=NULL,
touchStartThreshold=NULL,
removeOnSpill=NULL,#Remove item on spill
revertOnSpill=NULL,
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
setData=NULL,
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
onDeselect=NULL,#// Called when an element is deselected
onSpill=NULL,
customGetValueFn=NULL
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
  assert_logical(deselectOnBody,null.ok = T)
  assert_number(touchStartThreshold,null.ok = T)
  assert_logical(removeOnSpill,null.ok = T)
  assert_logical(revertOnSpill,null.ok = T)
  assert_logical(disabled,null.ok = T)
  assert_number(animation,null.ok = T)
  assert_string(easing,null.ok = T)
  assert_string(handle,null.ok = TRUE)
  assert_string(filter,null.ok = TRUE)
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
  assert_valid_fn_string(setData,null.ok = T)
  assert_valid_fn_string(onChoose,null.ok = T)
  assert_valid_fn_string(onUnchoose,null.ok = T)
  assert_valid_fn_string(onStart,null.ok = T)
  assert_valid_fn_string(onEnd,null.ok = T)
  assert_valid_fn_string(onMove,null.ok = T)
  assert_valid_fn_string(onAdd,null.ok = T)
  assert_valid_fn_string(onSort,null.ok = T)
  assert_valid_fn_string(onRemove,null.ok = T)
  assert_valid_fn_string(onClone,null.ok = T)
  assert_valid_fn_string(onChange,null.ok = T)
  assert_valid_fn_string(onFilter,null.ok = T)
  assert_valid_fn_string(onUpdate,null.ok = T)
  assert_valid_fn_string(onSelect,null.ok = T)
  assert_valid_fn_string(onDeselect,null.ok = T)
  assert_valid_fn_string(onSpill,null.ok = T)
  assert_valid_fn_string(customGetValueFn,null.ok = T)

  if(is.character(pull)&&pull%starts_with%'function')
    assert_valid_fn_string(pull)
  if(is.null(setData))

  if(nnull(handle)&&!grepl(start_with('\\.'),handle))
    handle=paste0(".",handle)
  if(nnull(draggable)&&!grepl(start_with('\\.'),draggable))
    draggable=paste0(".",draggable)
  if(nnull(filter)&&!grepl(start_with('\\.'),filter))
    filter=paste0(".",filter)
  if(nnull(selectedClass)&&grepl(start_with('\\.'),selectedClass))
    selectedClass=str_remove(selectedClass,"^\\.")
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
  if(len0(tmp)){
      out='{}'
      class(out)<-c('sortable_options',class(out))
      return(out)
  }
  tmp<-tmp[sapply(tmp,nnull)]

  out<-jsonlite::toJSON(tmp, auto_unbox = TRUE, json_verbatim = TRUE)
  class(out)<-c('sortable_options',class(out))
  out

}

