#' Create a variable pill shelf.

#' @name pill_shelf
#' @param ids  \code{[list]}
#' @param data  \code{[list]}
#' @param group_name  \code{[string]}
#' @param session  \code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.
#' @return \code{pill_shelf}: \code{[html]}
#' @examples
#'  if(interactive()){
#'  library('ggplot2')
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'
#'  bs_global_theme()
#'  ui <- fluidPage(
#'  bs_theme_dependencies(theme = bs_global_get()),
#'
#'  tags$h1("Pill Shelf"),
#'  icon_mdi('pencil'),
#'  flexCol(class='w-50 nav-card',
#'  add_editable_class(inputId='variable_rename',editable_class = 'pill-label'),
#'  uiOutput('measures'),
#'  verbatimTextOutput('res')
#'
#'  ))
#'
#'  server = function(input, output, session) {
#'
#'  output$measures<-renderUI({
#'
#'  self<-dynDT(diamonds)
#'  folder_id=self$new_variable_folder('Folder',type='measure')
#'  self$add_variable_to_folder(  self$vars[[1]]$var_id,folder_id)
#'  self$add_variable_to_folder(  self$vars[[2]]$var_id,folder_id)
#'  c(ids,data)%<-%self$measure_pills
#'
#'  pill_card(inputId ="nav_dimensions",
#'  type='column',
#'  sort_ops = sortable_options(
#'  name = 'nav_dimensions',
#'  pull = 'clone',
#'  put = FALSE,
#'  dragClass = 'drag',
#'  sort = FALSE
#'  ),
#'  pill_shelf(ids,data,group_name = "nav_dimensions"))
#'  })
#'
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }
#'

#' @export
pill_shelf <- function(ids, data, group_name, session = getDefaultReactiveDomain()) {
    # Create a variable pill shelf



    assert_list(ids)
    assert_list(data)
    assert_string(group_name)
    out <- map2(ids, data, function(x, y) {
        pill_item(id = x$id, label = x$label, icon = x$icon, type = unique(x$type), data = y,is_hierachy = x$is_hierachy )
    })
    folders <- out[names(out) != "none"]
    fnames <- str_split(names(folders), ":::")
    fpills <- map2(fnames, folders, function(x, y) pill_folder(folder_id = x[1], folder_name = x[2],
        pill_items = y, sortable_group = group_name))
    base <- out$none
    fnames = lapply(names(folders), function(x) str_split(x, ":::")[[1]][2]) %>% unlist()
    pnames <- c(ids$none$label, fnames)
    all_pills <- c(base, fpills)
    all_pills[order(pnames)]
    # Returns: \code{[html]}
}

#' @export
pill_shelf_example=function(sort_ops){
library(ggplot2)
library(sDataTable)
diamonds<-DT(diamonds)
diamonds[,Today:=Sys.Date()]
diamonds[,Yesterday:=Sys.Date()-1]
diamonds[,Now:=Sys.time()]
self<-dynDT(diamonds)
self[,`time difference`:=Today-Yesterday]
self[,`is_cut_premium`:=cut=="Premium"]
self[,`Letters`:="a"]
folder_id=self$new_variable_folder('Folder',type='measure')
self$add_variable_to_folder(  self$vars[[1]]$var_id,folder_id)
c(mids,mdata)%<-%self$measure_pills
c(ids,data)%<-%self$dimension_pills
div(class='d-flex flex-column w-50',
pill_card(inputId ="nav_dimensions",
          type='column',
          sort_ops =sort_ops,
          pill_shelf(ids,data,group_name = "nav_dimensions")),
pill_card(inputId ="nav_measures",
          type='column',
          sort_ops =sort_ops,
          pill_shelf(mids,mdata,group_name = "nav_measures")))
}
#' @export

pill_shelf_sortable_ops=function(group_name,pullId='pill_shelf_item_pulled',putId='pill_shelf_item_put'){
    ns<-session_ns()
    pullId<- ns(pullId)
    putId<-ns(putId)
    sortable_options(
        name = group_name,
        pull = 'function(to,from){
       // console.log($(to.el));
    if($(to.el).hasClass("put-clone")){
        return "clone";
    }
    return true
}',
        delay=0,

        put = group_name,
        filter='folder-wrapper',
        dragClass = 'drag',
        multiDrag=TRUE,
        selectedClass='pill-selected',
        deselectOnBody = FALSE,
        sort = FALSE,

        revertOnSpill=TRUE,
        multiDragKey = 'CTRL',
        onEnd = cglue('function(evt){let elid=$(evt.item).data("id");let toid=$(evt.from).data("folder_id");Shiny.setInputValue("&&pullId&&",{data_id:elid,from:toid});}'),
        onChoose="function(evt){
          items=[];

           var $el=$(evt.item);
           var sort=$el.parents('.sortable-div').get(0)
           var sortid=sort.id
           $el.data('parent',sortid);
       }",
        onSelect="function(evt){
          var items=[];
          if(evt.items.length==0){
              items[0]=evt.item;
          }else{
              items=evt.items;
          }
         items.map(function(){
         var $el=$(this);
           var sort=$el.parents('.sortable-div').get(0);
           var sortid=sort.id
           $el.data('parent',sortid);
           });
       }",

        onAdd = cglue('function(evt){
        //console.log("add");
        let elid=$(evt.item).data("id");let fromid=$(evt.to).data("folder_id");Shiny.setInputValue("&&putId&&",{data_id:elid,to:fromid});}'
        ))
}
pill_item



function(id, label,type = "measure",data=list(),icon='numeric',is_hierachy=FALSE) {
  # Create pill items
  assert_character(id)
  assert_character(label, len=length(id))
  assert_list(data)
  assert_choice(type,c("measure",'dimension'))
  order=ifelse(type=='measure',2,1)

  assert_any(type, check_character(len = 1), check_character(len = length(id)))
  class=glue("pill-item pill-{type} order-{order}")
  data_attributes<-"`data-null`=NULL"
  if('id'%nin%names(data)){
    data$id=id
  }
  hierachy_class<-chr_approx(c(TRUE,FALSE), c(" hierachy collapsed",""))(is_hierachy)
  # print(data)
  if(length(data)>0){
    # input_type=sapply(data,function(x){
    #     if(length(x)!=length(id))
    #         g_stop("length of data attributes not equal to length of ids")
    #     if(is.logical(x))return("checkbox")
    #     if(is.character(x))return('radio')
    #     if(is.numeric(x))return('action')
    #     g_stop('data attributes must be logical,numeric, or character')
    # })
    data_init=lapply(data,function(x){
      if(is.logical(x))x<-js_logical(x)
      if(is.numeric(x))x<-as.character(x)
      x[is.na(x)]<-"NA"
      glue("'{x}'")
    })

    data_names<-glue('`data-{names(data)}`')
    data_names[data_names=='`data-radio_id`']<-'`data-id`'

    data_attributes=map2(data_names,data_init,function(x,y)paste0(x,"=",y)) %>%
      reduce(function(x,y){paste(x,y,sep=',')})
  }
  out <- expr_glue(tags$div(id="{id}",
                            `data-name`='{label}',
                            {data_attributes},
                            class='d-flex flex-row {class} align-items-center{hierachy_class}',
                            div(class='pill-data-icon flex-nowrap',span(class='data-calculation',"="),icon_mdi('{icon}')),
                            div(class='pill-area d-flex flex-fill',
                                div(class='modify-hierachy expand',icon_mdi('plus-box-outline')),div(class='modify-hierachy collapse',icon_mdi('minus-box-outline')),tags$div("{label}",class="pill-label flex-fill",`data-id`="{id}"),div(icon_mdi('menu-down',class='icon-right dropdown-handle float-right')))
  )
  ) %>% exprs_eval()

  out
  # Returns: [html]
}
