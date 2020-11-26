
splitCol(gutterSize = 5,
         onDragEnd="df",
  div(),div())


edots=exprs( onDragEnd="df",div(),div())
dots=.( onDragEnd="df",div(),div())
hasHTMLclass=function(x,class){
  fn_description("Test is a shiny tag as a specific html class")
  fn_returns("Logical(1)")
  assert_class(x,"shiny.tag")
  assert_character(class)
  class=unlist(str_split(class,"\\s+"))
  classes<-unlist(str_split(tagGetAttribute(x,'class'),"\\s+"))
  all(class%in%classes)
}
fn_document(hasHTMLclass,{
  x=div(class="class1 active show")
  hasHTMLclass(x,"active")
  hasHTMLclass(x,c("active","show"))
  hasHTMLclass(x,c("active","class2"))
  hasHTMLclass(x,c("class1 show"))
})
package_document()

html_id=function(x){
  fn_description("Get or set the id of a shiny tag")
  fn_returns("character(1)")
  assert_class(x,"shiny.tag")
  x$attribs$id
}
fn_document(html_id,{
 x<-div()
 html_id(x)
 html_id(x)<-'ds'
 html_id(x)
 })
`html_id<-`<-function(x,value){
  assert_class(x,"shiny.tag")
  x$attribs$id<-value
 invisible(x)
}
html_class=function(x){
  fn_description("Get or set the class of a shiny tag")
  fn_returns("character(1)")
  assert_class(x,"shiny.tag")
  x$attribs$class
}

fn_document(html_class,{
  x<-div()
  html_class(x)
  html_class(x)<-'new_class'
  html_class(x)
})
`html_class<-`<-function(x,value){
  assert_class(x,"shiny.tag")
  x$attribs$class<-value
  invisible(x)
}

append_class=function(x,class){
  fn_description("Append the class of a shiny tag")
  fn_returns("shiny tag")
  assert_class(x,"shiny.tag")
 tagAppendAttributes(x,class=class)
}
fn_document(append_class,{
  x<-div(class="class1")
  append_class(x)<-'new_class'
  x
})
`append_class<-`<-function(x,value){
  append_class(x,value)
}
remove_class=function(x,class){
  fn_description("Remove the class of a shiny tag")
  fn_returns("shiny tag")
  assert_class(x,"shiny.tag")
  assert_character(class)
  class=unlist(str_split(class,"\\s+"))
  classes<-unlist(str_split(tagGetAttribute(x,'class'),"\\s+"))

 x$attribs$class= classes%NIN%class%sep%" "
 x
}
`remove_class<-`<-function(x,value){
  remove_class(x,value)
}
fn_document(remove_class,{
  x<-div(class="class1 class2 active show")
  remove_class(x)<-'active'
  x
  remove_class(x)<-'class1 active'
  x
  x<-div(class="class1 class2 active show")
  remove_class(x)<-c('class1', 'active')
  x
})
package_document()
html2R=function(x,try_parsing=TRUE){
  assert_character(x,len=1)
  assert_logical(try_parsing,len=1)
  fn_description("Generate R code from raw html")
  fn_returns("R code")
  tags_names<-paste0('<',names(tags))%sep%"|"
  x=str_extract_all(x,'\\<.*?\\>') %>% unlist()
  x
  x<-str_replace_all(x,tags_names%preceding%"[\\s>]","\\(") %>% unlist()
  x<-str_replace_all(x,"\""%preceding%("\\s"%nfollowed_by%"\\>"),",")
  x<-str_replace_all(x,'\\<\\/\\w+\\>',")") %>% unlist()
  x[grepl(start_with('<input|<img|<hr>|<link|<br>|<link'),x)]<-
    str_replace_all(x[grepl(start_with('<input|<img|<hr>|<link|<br>|<link'),x)],">",'\\)')

  x[grepl(ends_with('/>'),x)]<-
    str_replace_all(x[grepl(ends_with('/>'),x)],"\\/>",'\\)')
  #x<-str_replace_all(x,ends_with("\\>"),",")
  x=x%sep%""
  x


  x<-str_replace_all(x,"<"%nfollowed_by%"div","<tags$")
  x=str_replace_all(x,'\\s+'," ")
  x=str_replace_all(x,'\\s=',"=")
  x=str_replace_all(x,'=\\s',"=")
  x=str_replace_all(x,"><",",")
  x=str_replace_all(x,">\\)",")")
  x=str_replace_all(x,"\\)<","),")
  x=str_replace_all(x,">",")")
  x=x %>% str_remove_all("<") %>% glue()

  x=str_replace_all(x,'\\s+'," ")
  x=str_replace_all(x,'\\s=',"=")
  x=str_replace_all(x,'=\\s',"=")
  x=str_replace_all(x,'for=',"`for`=")
  hyphen=""
  while(!is.na(hyphen)){
    hyphen<-str_extract(x,"\\w+-\\w+=")
    if(!is.na(hyphen)){
      x=str_replace(x,"\\w+-[[[:alpha:]]\\-]+=","{hyphen}")
      hyphen=paste0('`',str_remove(hyphen,"="),'`=')
      x<-glue(x)
    }
  }
  x=str_replace_all(x,'\\)'%followed_by%'\\w',"),")

  if(try_parsing==FALSE)return(glue(out))
  out=try(parse_expr(x),silent=TRUE)
  if(!is_error(out))return(out)
  parse_expr(glue("tagList({x})"))
}


fn_document(html2R,{
  x='<div class="btn-group" role="group" aria-label="Basic example">
    <button type="button" class="btn btn-secondary">Left</button>
      <button type="button" class="btn btn-secondary">Middle</button>
        <button type="button" class="btn btn-secondary">Right</button>
          </div>'
html2R(x)
  })
