#' Search and view the material icon list.

#' @name view_mdi_icons
#' @param icon_names  [character]  Must have an exact length of 1.
#' @param size  [number]  Icon size in px.
#' @return \code{view_mdi_icons}: [NULL]
#' @examples

#'  view_mdi_icons('database')

#' @export
view_mdi_icons=function(icon_names,size=25){

    assert_character(icon_names,len = 1)
    icon_names<- search_mdi_icons(icon_names)
    inner<- glue("<div><span class='{icon_names} p-1 mr-3'></span>{icon_names}</div>")%sep%""

    out<- AO::sglue('<!doctype html>
<html>
  <head>
 <link rel="stylesheet" href="https://maxcdn.bootstrapcdn.com/bootstrap/4.3.1/css/bootstrap.min.css">
<link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" media="all" rel="stylesheet">
<style>
.mdi{
font-size: &&size&&px;

}
</style>
  </head>
  <body>
  <div class="dflex flex-column pl-4 pt-2">
&&inner&&
  </div>
  </body>
</html>',open="&&",close="&&")
    tempDir <- tempfile()
    dir.create(tempDir)
    htmlFile<-file.path(tempDir,"tempHtml.html")
    write(out,file.path(tempDir,"tempHtml.html"))
    viewer <- getOption("viewer")
    viewer(htmlFile)
}
