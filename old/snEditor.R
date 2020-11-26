

ml_dropdown_nav_item=function(...,id,label){
tags$li(class="nav-item dropdown",
  tags$a(class="nav-link dropdown-toggle",href="#",id=id,`data-toggle`="dropdown" ,`aria-haspopup`="true",`aria-expanded`="false",label),
  ...)
}
dd_menu=function(...,id,class=""){
    tags$ul(class=glue("dropdown-menu {class}"), `aria-labelledby`=id,...)
}
dd_submenu=function(...,class=""){
  tags$ul(class=glue("submenu dropdown-menu {class}"),...)
}
dd_item=function(...,label,toggle_submenu=FALSE,class=""){
      tags$li(tags$a(class=glue("dropdown-item {class}"),href="#",label),...)
  }

snEditor=function(id,
                  class=NULL,
                           minHeight=NULL,
                           maxHeight=NULL,
                           focus=NULL,
                           placeholder=NULL,
                           tabSize=NULL,
                           toolbar=NULL,
                           popover=NULL,
                           blockquoteBreakingLevel=NULL ,
                           styleTags=NULL,
                           fontNames=NULL,
                           fontNamesIgnoreCheck=NULL,
                           fontSizeUnits=NULL,
                           lineHeights=NULL,
                           dialogsInBody=NULL,
                           dialogsFade=NULL,
                           disableDragAndDrop=NULL,
                           shortcuts=NULL,
                           tabDisable=NULL,
                           codeviewFilter=NULL,
                           codeviewIframeFilter=NULL,
                           codeviewFilterRegex=NULL){
  require(jsonlite)
                   args<-args2list()
                  args$id=NULL
                  args$class=NULL
                  args[sapply(args,nnull)]
                j_args= toJSON(  args[sapply(args,nnull)])

tagList(tags$div(id=id,class=class),
        # tags$script(glue("$('#{id}').summernote({j_args});"))
        tags$script(src='summernote_example.js')
   )

}
$("#summernote").summernote({
  hint: {
    mentions: ['jayden', 'sam', 'alvin', 'david'],
    match: /\B@(\w*)$/,
    search: function (keyword, callback) {
      callback($.grep(this.mentions, function (item) {
        return item.indexOf(keyword) == 0;
      }));
    },
    content: function (item) {
      return '<div id="'+item+'" class="pill-item pill-measure">
  <span class="pill-label">'+item+'</span>
</div>'
    }
  }
});
pill_item("ds","ds")
