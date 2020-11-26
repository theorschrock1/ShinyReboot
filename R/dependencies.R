#' @export
html_dependency_setShinyInput <- function() {
  htmltools::htmlDependency(
    name = "setShinyInput",
    version = packageVersion("ShinyReboot"),
    src = "assets/setShinyInput",
    package = "ShinyReboot",
    script = "setShinyInput.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_picker_page_btn <- function() {
  htmlDependency(
    name = "select_picker_pagination",
    version = packageVersion("ShinyReboot"),
    src =  "assets/select_picker_pagination",
    package = "ShinyReboot",
    script = "select_picker_pagination.js",
    all_files =FALSE
  )
}

#' @export
html_dependency_split_JS <- function() {
  htmlDependency(
    name = "split.js",
    version = '1.6.0',
    src =  "assets/split.js/dist/",
    package = "ShinyReboot",
    script = c("split.js",'splitBinding.js'),
    all_files =FALSE
  )
}
#' @export
html_dependency_sortable_JS <- function() {
  htmlDependency(
    name = "sortable.js",
    version = '1.12.0',
    src =  "assets/sortablejs/dist/",
    package = "ShinyReboot",
    script = c("sortable.umd.js",'sortableBinding.js'),
    all_files =FALSE
  )
}

#' @export
spectrum_colorpicker_depends=function(){
  deps = htmlDependency("spectrum-colorpicker2", "2.0", c(href = "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2"),
                        script = "dist/spectrum.min.js", stylesheet = "dist/spectrum.min.css")
}
#' @export
mdi_depends=function(){
  htmltools::htmlDependency(
    name = "mdi-icons",
    version = packageVersion("ShinyReboot"),
    src = "assets/mdi-icons",
    package = "ShinyReboot",
    stylesheet = c("css/materialdesignicons.min.css","css/mdi.css"),
    all_files =FALSE
  )
}

#' @export
bootstrap_select_depends=function(){
  htmltools::htmlDependency("bootstrap-select", "1.13.14", c(href = "https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14"),
                            script = "dist/js/bootstrap-select.min.js",
                            stylesheet = "dist/css/bootstrap-select.min.css")
}
