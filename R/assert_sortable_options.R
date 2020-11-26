#' @export
assert_sortable_options=function(
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
  if(nnull(handle)&&!grepl(start_with('\\.'),handle))
    handle=paste0(".",handle)
  if(nnull(draggable)&&!grepl(start_with('\\.'),draggable))
    draggable=paste0(".",draggable)
  if(nnull(filter)&&!grepl(start_with('\\.'),filter))
    filter=paste0(".",filter)
  if(nnull(put)&&is.list(put)&&names(put)!='class_types')
    g_stop("put must be logical, a vector of group names, or list of classes with format `list(class_types=c('class1,'class2'))`")

}
