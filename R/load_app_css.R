#' Load all CSS files in the www directory.

#' @name load_app_css
#' @param app_name  [character]  NULL is ok.  Must have an exact length of 1.  Defaults to NULL
#' @return \code{load_app_css}: html
#' @export
load_app_css <- function() {
    # Load all CSS files in the www directory

    css <- list.files('www/',pattern = "\\.css")
    # if (!is_null(app_name)) {
    #     css <- list.files(glue("{app_name}/www/"), pattern = "\\.css")
    # }

  HTML(glue('<link href="{css}" rel="stylesheet"/>')%>% glue_collapse("\n"))


    # Returns: html
}
#' @export
load_app_js <-function(){

    js<- list.files('www/',pattern = "\\.js")
    # if (!is_null(app_name)) {
    #     css <- list.files(glue("{app_name}/www/"), pattern = "\\.css")
    # }

    HTML(glue('<script src="{js}"></script>')%>% glue_collapse("\n"))
}
#' @export
load_app_js2 <-function(){

 list.files("assets/js")
  # if (!is_null(app_name)) {
  #     css <- list.files(glue("{app_name}/www/"), pattern = "\\.css")
  # }

}
