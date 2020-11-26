
library(shiny)
library(exprTools)

reboot_Dependancies=function(){
  fn_description("Loads variable scripts from shiny applications")
  fn_returns("[list] HTML")
  tagList(
#<!-- bootstrap/4.3.1/css-->
tags$link(rel="stylesheet",href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css"),
#<!-- JQuery -->
tags$script(src="https://code.jquery.com/jquery-3.3.1.slim.min.js"),
#<!-- Bootstrap.JS -->
tags$script(src="https://stackpath.bootstrapcdn.com/bootstrap/4.1.0/js/bootstrap.min.js", integrity="sha384-uefMccjFJAIv6A+rW+L4AHf99KvxDjWSu1z9VI8SKNVmz4sk7buKt/6v9KI65qnm", crossorigin="anonymous"),
#<!--Sortable JS -->
tags$script(src="https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"),
#<!-- Split.js-->
tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/split.js/1.6.0/split.min.js"),
#<!-- Font Awesome JS -->
tags$script(src="https://use.fontawesome.com/releases/v5.0.13/js/solid.js", integrity="sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ", crossorigin="anonymous"),
tags$script( src="https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js", integrity="sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY",crossorigin="anonymous"),
#<!-- Feather JS -->
tags$script( src="https://cdnjs.cloudflare.com/ajax/libs/feather-icons/4.9.0/feather.min.js"),
#<!-- Popper.JS -->
tags$script(src="https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js",integrity="sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ", crossorigin="anonymous")
  )}

fn_document(reboot_Dependancies)
flexBox<-function(...){
  fn_description("Create a BS4 flex box")
  fn_returns("HTML")
  dots<-list(...)

  dots$class=paste('d-flex',dots$class)
  expr_eval(div(!!! dots))
}
fn_document(flexBox)
flexCol<-function(...){
  fn_description("Create a BS4 flex column")
  fn_returns("HTML")
  dots<-list(...)

  dots$class=paste('flex-column',dots$class)
  expr_eval(flexBox(!!! dots))
}
fn_document(flexCol)
flexRow<-function(...){
  fn_description("Create a BS4 flex row")
  fn_returns("HTML")
  dots<-list(...)

  dots$class=paste('flex-row',dots$class)
  expr_eval(flexBox(!!! dots))
}
fn_document(flexRow)


nav_fixed_top=function(...){
  fn_description("Create a BS4 fixed top navbar")
  fn_returns("HTML")
  dots<-list(...)

  dots$class=paste("navbar fixed-top flex-md-nowrap",dots$class)
  expr_eval(tags$nav(!!! dots))
}
fn_document(nav_fixed_top)
nav_brand=function(...){
  fn_description("Create a BS4 navbar title.  For use inside a fixed top nav")
  fn_returns("HTML")
  dots<-list(...)
  dots$class=paste('navbar-brand col-md-3 col-lg-2',dots$class)
  expr_eval(tags$a(!!! dots))
}
fn_document(nav_brand)
js_logical=function(x){
  fn_description("Convert R TRUE/FALSE to HTML/JS true/false")
  fn_returns("character")
  assert_logical(x)
  tolower(as.character(x))
}

fn_document(js_logical,{
  js_logical(c(T,F))
  js_logical(c(TRUE,FALSE))
})
feather_icon=function(name,...){
  assert_character(name,len=1)
  fn_description("Use a feather icon")
  fn_returns("html")
  tags$span(`data-feather`=name,...)
}
fn_document(feather_icon)
sidebar_left=function(...,id){
  fn_description("Create a left sidebar")
  fn_returns("html")
  assert_character(id,len=1)
  dots<-list(...)
  nav_class=paste('col-md-3 col-lg-2 sidebar collapse',dots$class)
  dots$class=NULL
  expr_eval(tags$nav(id=!!id,class=!!nav_class,!!!dots))
}
fn_document(sidebar_left)
sidebar_sticky=function(...){
  fn_description("Create a sticky sidebar. Should be used inside sidebar_left/right.")
  fn_returns("html")
  dots<-list(...)
  dots$class=paste('sidebar-sticky overflow-hidden',dots$class)
  expr_eval(div(!!!dots))
}
fn_document(sidebar_sticky)
main=function(...,class="col-md-9 ml-sm-auto col-lg-10 p-0 m-0"){
  fn_description("Create a div for main content")
  fn_returns("html")
  assert_character(class,len=1)
  tags$main(role="main", class=class,...)
}
fn_document(main)
new_shiny_app=function(app_name,template="dashboardTemplate"){
  fn_description("Create a new BS4 app from a template")
  fn_returns("NULL")
  assert_character(app_name,len=1)
  assert_character(template,len=1)
  if(!dir.exists(glue("~/ShinyReboot/{template}/")))g_stop("'{template}' template doesn't exist")
if(dir.exists(app_name))g_stop("{app_name} already exists")
dir.create(app_name)

R.utils::copyDirectory(from="~/ShinyReboot/{template}/",to=glue("{app_name}/"))
R.utils::copyFile('~/ShinyReboot/{template}/app.R',glue("{app_name}/{app_name}_app.R"))
file.rename(glue('{app_name}/app.R'),glue('{app_name}/{app_name}_app.R'))
file.edit(glue('{app_name}/{app_name}_app.R'))
}
fn_document(new_shiny_app)

nav_toggler=function(...,class=NULL,data_target, expanded=FALSE,icon="navbar-toggler-icon"){
  fn_description("Create a navbar toggler button")
  fn_returns("NULL")
  assert_character(class,len=1)
  assert_character(data_target,len=1)
  assert_logical(expanded,len=1)
  assert_character(icon,len=1)
  if(!grepl(start_with("#"),data_target))g_stop("data_target '{data_target}' must begin with a #. Use '#{data_target}")
  class=paste("navbar-toggler position-absolute",class)

  tags$button(class=class,
              type="button",
              `data-toggle`="collapse",
              `data-target`=data_target,
              `aria-controls`=str_remove(data_target,start_with("#")),
              `aria-expanded`=js_logical(expanded),
              `aria-label`="Toggle navigation",
              tags$span(class=icon),...)}
fn_document(nav_toggler)
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


package_document()



