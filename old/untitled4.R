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
package_document()


newCSS=function(name,app=NULL,open=TRUE){
  if(is.null(app)){
   path= glue("www/{name}.css")
  }else{

    path= glue("{app}/www/{name}.css")
  }
  if(file.exists(  path))g_stop('file path "{path}" exists')
  header=c(glue('/*{name} CSS*/'),'\n',glue('/*tags$link(href="{name}.css" ,rel="stylesheet")*/'))
  write(header,path)
  if(open)file.edit(path)
}


newCSS("MultiLevel_DropDown",app="dashboardTemplate")
tags$link(href="{name}.css" ,rel="stylesheet")
newCSS("pill_card","new_app")

pill_card=function(...,inputId,name=NULL,icon,type='column',sortable=TRUE){
  fn_description("Create a pill card div")
  fn_returns("[htmlTag(div)]")
  header=NULL
  assert_character(inputId,len=1)
  assert_character(name,null.ok = TRUE)

    assert_character(icon,len=1)
  assert_choice(type,choices=c("row","column"))
  assert_logical(sortable,len=1)
  if(!is.null(name)){
  header=div(class='handle',
      icon_mdi(icon),
      name)
  }
  if(sortable){
  return(div(class=glue('pill-card-{type}'),
      header,
      sortable_div(inputId=inputId,class=glue('d-flex flex-{type} flex-fill flex-wrap bg-transparent shelf'),...)))
  }
    div(class=glue('pill-card-{type}'),
        header,
        div(class=glue('d-flex flex-{type} flex-fill flex-wrap bg-transparent shelf'),...))

}
fn_document(pill_card,{
  pill_card(
    pill_item(id=c("sales","transactions","traffic","basket size"),
              label=c("sales","transactions","traffic","basket size")),inputId="one",name="Chart",icon="test")
})

pill_item=function(id,label,type='measure'){
  fn_description("Create pill items")
  fn_returns("[html]")
  assert_character(id)
  assert_character(label,l(id))

  assert_any(type,
  check_character(len=1),
  check_character(len=length(id))
  )
 out<-expr_glue('tags$div(id="{id}",class=glue("pill-item pill-{type}"),
       tags$span("{label}",class="pill-label"),
       icon("angle-down",class="ghost-icon"))') %>% exprs_eval()
 out
}

fn_document(pill_item,{
  pill_card(
    pill_item(id=c("sales","transactions","traffic","basket size"),
              label=c("sales","transactions","traffic","basket size")),inputId="one",name="Chart",icon="test")
})


names=c("sales","transactions","traffic","basket size")
pill_card(
pill_item(id=c("sales","transactions","traffic","basket size"),
          label=c("sales","transactions","traffic","basket size")),inputId="one",name="Chart",icon="test")


icon_mdi()
pill_car

package_document()
