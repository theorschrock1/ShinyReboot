
ml_dropdown=function(...,class="",is_submenu=FALSE){
  fn_description("Create a multi level drop down.")
  fn_returns( '[HTML]')

  assert_character(class,len = 1)
  assert_logical(submenu,len=1)
 if(is_submenu==F) {
   tags$div(class=glue("dropdown {class}"),
          ...)
 }else{
   tags$li(class=glue("dropdown {class}"),
            ...)
 }
}
fn_document(ml_dropdown,{
  header="Drop Down"
  ml_dropdown(class="multi-level-dropdown",
              dd_header(header,id=label2id(header),class='menu-text',carat =FALSE),
              dd_menu(id=label2id(header),class='shadow',
                      dd_item(id="option1",label="Option 1"),
                      dd_item(id="option2",label="Option 2"),
                      dd_item(id="option3",label="Option 3"))
  )
})
dd_header=function(...,id,class="",carat=TRUE,is_submenu=FALSE){
  fn_description("Create a drop down menu header.  For use inside ml_dropdown")
  fn_returns( '[HTML]')
  assert_character(id,len = 1)
  assert_character(class,len = 1)
  assert_logical(carat,len=1)
  assert_logical(submenu,len=1)
  toggle<-''
  if(carat)toggle<-'dropdown-toggle'
  if(is_submenu==F){
  tags$span(class=glue("{class} {toggle}"),href="#",id=id,`data-toggle`="dropdown",`aria-haspopup`="true",`aria-expanded`="false",...)
  }else{
    tags$a(class=glue("dropdown-item {class} {toggle}"),href="#",id=id,`data-toggle`="dropdown",`aria-haspopup`="true",`aria-expanded`="false",...)
    }
  }
fn_document(dd_header,{
  header="Drop Down"
  ml_dropdown(class="multi-level-dropdown",
              dd_header(header,id=label2id(header),class='menu-text',carat =FALSE),
              dd_menu(id=label2id(header),class='shadow',
                      dd_item(id="option1",label="Option 1"),
                      dd_item(id="option2",label="Option 2"),
                      dd_item(id="option3",label="Option 3"))
  )
})
dd_menu=function(...,id,class=""){
  fn_description("Create a drop down menu list.  For use inside ml_dropdown")
  fn_returns( '[HTML]')
  assert_character(id,len=1)
  assert_character(class,len=1)
  tags$ul(class=glue("dropdown-menu {class}"), `aria-labelledby`=id,...)
}
fn_document(dd_menu,{
  header="Drop Down"
  ml_dropdown(class="multi-level-dropdown",
              dd_header(header,id=label2id(header),class='menu-text',carat =FALSE),
              dd_menu(id=label2id(header),class='shadow',
                      dd_item(id="option1",label="Option 1"),
                      dd_item(id="option2",label="Option 2"),
                      dd_item(id="option3",label="Option 3"))
  )
})
dd_item=function(...,id,label,class=""){
  fn_description("Create a drop down menu item")
  fn_returns( '[HTML]')
  assert_character(id,len=1)
  assert_character(label,len=1)
  assert_character(class,len=1)
  tags$li(tags$a(id=id,class=glue("dropdown-item {class}"),href="#",label),...)
}
label2id=function(x){
  assert_character(x)
  fn_description("Turn a html label into an shiny input id")
  fn_returns( 'tolower(str_replace_all([character(1)],"\\s","_")')
  tolower(str_replace_all(x,"\\s+",'_'))
}

header='File'
items=list('New','Open','Save',list(l2=list(letters[1:3])))
mm_item=function(items,header,class='menu-item',carat=FALSE,submenu=FALSE){
  fn_description("Create a multi-level dropdown menu item")
  fn_returns("[HTML]")
  assert_list(items)
  assert_character(header,len = 1)
  assert_character(class,len = 1)
  assert_logical(carat,len=1)
  assert_logical(submenu,len=1)
items=map2(header,items,function(x,y){
  if(is.list(y)){
   return( mm_item(y[[1]],names(y),class='dropright sub-menu-item',carat=TRUE,submenu=TRUE))
  }
  dd_item(label=y,id=label2id(paste(x,y)),class='ao-action-button')
  })
  ml_dropdown(class=class,is_submenu=submenu,
    dd_header(header,id=tolower(header),class='menu-text',carat =carat,is_submenu=submenu),
    dd_menu(id=tolower(header),class='shadow',items)
  )
}



items=list(File=.(one="button",two="buttom",three="button"),Edit,View,Sheet,Help)
expr_glue(div(class="menu-item",'{items}'))

mm_item(,y))
main_menu_bar=function(...,class=""){
  fn_description("Create a main menu bar [File,Edit,Code,View,etc]")
  fn_returns("[HTML]")
  assert_character(class,len=1)
  dots=list(...)
  headers=names(dots)
  items<-map2(dots,headers,function(x,y)expr_eval(mm_item(!!x,!!!y)))
  names(items)<-NULL
expr_eval(
    flexRow(class=glue('menu-bar main-menu {class}'),!!!  items))
}

fn_document(main_menu_bar,{
  main_menu_bar(File=list('New','Open','Save',list(l2=list("one","two","three",list(l3=list("one","two","three"))))),Data=.('New data source',"Paste"),View=.("Graph","Dashboard"))
})
fn_description("Create a main menu bar [File,Edit,Code,View,etc]")
fn_returns("[HTML]")

"."=function(...){
  list(...)
}
list(l2=list(letters[1:3])))
dots=list(File=list('New','Open','Save',list(l2=list(letters[1:3]))),Data=.('New data source',"Paste"),View=.("Graph","Dashboard"))
div(class='dropdown',div( class="menu-item",tags$span(class='menu-text',"{items}")
mm_item(list("one","two","three"),'l2',submenu = TRUE)
main_menu_bar(File=list('New','Open','Save',list(l2=list("one","two","three"))),Data=.('New data source',"Paste"),View=.("Graph","Dashboard"))
              mm_item(list('New','Open','Save',list(l2=list("one","two","three"))),"File")
menu_top=function(...){
  fn_description("A wrapper for a full width top menu bar")
  fn_returns("[HTML]")
  div(class="menu-wrapper",...)
}

fn_document(menu_top,{
  menu_top(
    main_menu_bar(File=list('New','Open','Save',list(l2=list("one","two","three",list(l3=list("one","two","three"))))),Data=.('New data source',"Paste"),View=.("Graph","Dashboard")),
    icon_tool_bar(
      menu_icons_buttons(inputId=c("undo","redo","save"),c("undo","redo","content-save-outline"),c("Undo","Redo","Save")),
      menu_icons_buttons(
        c("data_source_new","data_source_refresh","pause_data_updates"),
        c("database-plus","database-refresh","database-lock"),
        c("New data source","Refresh data source","Pause auto updates")),
      menu_icons_radio(inputId="sort_options",
                       c('sort_remove',
                         'sort_ascending',
                         'sort_descending'),
                       c('sort-variant-remove',
                         'sort-ascending',
                         'sort-descending'),
                       c('Clear sort',
                         'Sort ascending',
                         'Sort descending'))
    )
  )
})

icon_tool_bar=function(...,class=""){
  fn_description('Create an icon tool bar wrapper')
  fn_returns("[HTML]")
  assert_character(class,len=1)
    flexRow(class=glue('menu-bar icon-tool-bar {class}'),add_dividers(...,type="|"))
}
paste2 <- function(x, y, sep = ".") paste(x, y, sep = sep)
letters[5:8] %>% reduce(paste2)
HTML(rep(as_glue(div()),4) %>% reduce2(rep(as_glue(sep()),3),paste2))
icon_tool_bar=function(...,class=""){
  fn_description('Create an icon tool bar wrapper')
  fn_returns("[HTML]")
  assert_character(class,len=1)
  flexRow(class=glue('menu-bar icon-tool-bar {class}'),add_dividers(...,type="|"))
}

fn_document(icon_tool_bar,{
icon_tool_bar(
  icon_button_group(inputId=c("undo","redo","save"),c("undo","redo","content-save-outline"),c("Undo","Redo","Save")),
  icon_button_group(
    c("data_source_new","data_source_refresh","pause_data_updates"),
    c("database-plus","database-refresh","database-lock"),
    c("New data source","Refresh data source","Pause auto updates")),
  icon_radio_group(inputId="sort_options",
                   c('sort_remove',
                     'sort_ascending',
                     'sort_descending'),
                   c('sort-variant-remove',
                     'sort-ascending',
                     'sort-descending'),
                   c('Clear sort',
                     'Sort ascending',
                     'Sort descending'))
)
})




icon_button_group=function(inputId,icon_name,tooltip,class="",tooltip_placement='top'){
    fn_description('Create an icon button group')
    fn_returns("[HTML]")
    assert_character(inputId)
    assert_character(icon_name,len=length(inputId))
    assert_character(tooltip,len=length(inputId))
    assert_character(class)
    assert_character(tooltip_placement,len=1)
    inner = expr_glue(
      tags$button(
        id = '{inputId}',
        role = 'button',
        `data-toggle` = 'tooltip',
        title = '{tooltip}',
        class = "btn btn-sm menu-item ao-action-button",
        tags$span(class = "mdi mdi-{icon_name} menu-icons {class}")
      )
    ) %>% lapply(eval)
    div(class='btn-group-toggle',inner)
}

icon_radio_group=function(inputId,options,icon_name,tooltip,class="",tooltip_placement='top'){
  fn_description('Create an icon button group')
  fn_returns("[HTML]")
  assert_character(inputId,len=1)
  assert_character(icon_name)
  assert_character(tooltip,len=length(icon_name))
  assert_character(class)
  assert_character(tooltip_placement,len=1)
    inner =expr_glue(
                tags$label(`data-toggle`='tooltip',title='{tooltip}',class="btn btn-sm menu-item",
                        tags$input(type="radio", name="{inputId}", id="{options}"),
                                  tags$span(class='mdi mdi-{icon_name} menu-icons {class}')
                                )) %>% lapply(eval)
  div(id=inputId,class='btn-group-toggle ao-radio-button-grp',`data-toggle`='buttons',inner)
}

fn_document(icon_radio_group,{
icon_radio_group(inputId="sort_options",
                 options= c('sort_remove',
                            'sort_ascending',
                            'sort_descending'),
                 icon_name=c('sort-variant-remove',
                            'sort-ascending',
                            'sort-descending'),
                 tooltip=c('Clear sort',
                            'Sort ascending',
                            'Sort descending'))
})
fn_document(icon_button_group,{
icon_button_group(inputId=c("undo","redo","save"),
                  icon_name=c("undo","redo","content-save-outline"),
                  tooltip=c("Undo","Redo","Save"))
})


icon_tool_bar(
icon_button_group(inputId=c("undo","redo","save"),c("undo","redo","content-save-outline"),c("Undo","Redo","Save")),
sep(),
icon_button_group(
  c("data_source_new","data_source_refresh","pause_data_updates"),
  c("database-plus","database-refresh","database-lock"),
  c("New data source","Refresh data source","Pause auto updates")),
sep(),
icon_radio_group(c('sort_remove',
             'sort_ascending',
             'sort_descending'),
           c('sort-variant-remove',
                         'sort-ascending',
                         'sort-descending'),
           c('Clear sort',
             'Sort ascending',
             'Sort descending')),
sep()
)

materialIconGallery=function(){
  fn_description("View the material design icon library")
  fn_returns("[NULL]")
browseURL('https://cdn.materialdesignicons.com/5.4.55/')
}
fn_document(materialIconGallery,{
  materialIconGallery()
})


search_mdi_icons=function(pattern){
  fn_description("Search the material icon list")
  fn_returns("[character]")
  assert_character(pattern,len = 1)
me <- read_html("html/mdi.html")
allICons<-xml_find_all(me, '//i') %>% xml_attr('class')
allICons[grepl(pattern,allICons)]
}

fn_document(search_mdi_icons,{
  search_mdi_icons("database")
})

mdi_icons("database")

  view_mdi_icons('sort')
  c('sort-variant-remove',
  'sort-variant',
  'sort-reverse-variant')


fn_document(menu_top,
