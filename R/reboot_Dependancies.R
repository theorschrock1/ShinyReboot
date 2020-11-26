#' Loads variable scripts from shiny applications.

#' @name reboot_Dependancies
#' @return \code{reboot_Dependancies}: [list] HTML
#' @export
reboot_Dependancies <- function() {
    # Loads variable scripts from shiny applications
    tagList(
        tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/popper.js/1.14.0/umd/popper.min.js",
                    integrity = "sha384-cs/chFZiN24E4KMATLdqdvsezGxaGsi4hLGOzlXwp5UZB1LY//20VyM2taTB4QvJ",
                    crossorigin = "anonymous"),
      tags$script(src = "https://cdn.jsdelivr.net/npm/sortablejs@latest/Sortable.min.js"),
        tags$script(src = "https://cdnjs.cloudflare.com/ajax/libs/split.js/1.6.0/split.min.js"),

        tags$script(src = "https://use.fontawesome.com/releases/v5.0.13/js/solid.js", integrity = "sha384-tzzSw1/Vo+0N5UhStP3bvwWPq+uvzCMfrN1fEFe+xBmv1C/AtVX5K0uZtmcHitFZ",
            crossorigin = "anonymous"),
        tags$script(src = "https://use.fontawesome.com/releases/v5.0.13/js/fontawesome.js",
            integrity = "sha384-6OIrr52G08NpOFSZdxxz1xdNSndlD4vdcf/q2myIUVO0VsqaGHJsB0RaBE01VTOY",
            crossorigin = "anonymous"),
      tags$link(href="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.css", rel="stylesheet"),
          tags$script(src="https://cdn.jsdelivr.net/npm/summernote@0.8.18/dist/summernote-bs4.min.js"),
      tags$link(href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css",media="all",rel="stylesheet")

      )
    # Returns: [list] HTML
}

