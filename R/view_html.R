#' @export
view_html<-function(html,dir=path(getwd(),'inst','assets'),style_sheets=NULL,scripts=NULL){
  links=''
  js=''
  tempDir <- tempfile()
  dir.create(tempDir)
  if(nnull(style_sheets)){
   # from<-glue("{dir}/{style_sheets}")
   from= unlist(lapply(str_split(style_sheets,"/"),first))
   from<-glue("{dir}/{from}")
    file.copy(from, tempDir,recursive = TRUE )
    links= glue('<link rel="stylesheet" href="{style_sheets}">')%sep%""
  }
  if(nnull(scripts)){
    from= unlist(lapply(str_split(scripts,"/"),first))
    from<-glue("{dir}/{from}")
    file.copy(from, tempDir,recursive = TRUE )
    js= glue('<script type="text/javascript" scr="{scripts}">')%sep%""
  }
  inner=as.character(html)%sep%""
  out<- cglue('<!doctype html>
<html>
  <head>
 <link rel="stylesheet" href="https://stackpath.bootstrapcdn.com/bootstrap/4.1.3/css/bootstrap.min.css" integrity="sha384-MCw98/SFnGE8fJT3GXwEOngsV7Zt27NXFoaoApmYm81iuXoPkFOJwJ8ERdknLPMO" crossorigin="anonymous">
&&js&&
&&links&&
  </head>
  <body>
&&inner&&
  </body>
</html>')

  htmlFile<-file.path(tempDir,"tempHtml.html")
  write(out,file.path(tempDir,"tempHtml.html"))

  viewer <- getOption("viewer")
  viewer(htmlFile)
}
