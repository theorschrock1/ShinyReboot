#' Adds the content of www to shinyWidgets/
#'
#' @noRd
#'
.onLoad <- function(...) {
  shiny::addResourcePath('ShinyReboot', system.file("assets", package = "ShinyReboot"))
  shiny::addResourcePath('shinyWidgets', system.file("assets", package = "shinyWidgets"))
}
