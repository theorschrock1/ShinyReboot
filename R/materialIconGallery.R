#' View the material design icon library.

#' @name materialIconGallery
#' @return \code{materialIconGallery}: [NULL]
#' @examples

#'  materialIconGallery()

#' @export
materialIconGallery <- function() {
    # View the material design icon library

  htmlFile<-system.file('assets/mdi-icons/preview.html',package = "ShinyReboot")
  viewer <- getOption("viewer")
  viewer(htmlFile)
    # Returns: [NULL]
}
