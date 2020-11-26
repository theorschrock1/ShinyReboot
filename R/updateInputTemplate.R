#' Generate a template function for updating a custom shiny input.

#' @name updateInputTemplate
#' @param inputName  [string]
#' @return \code{updateInputTemplate}: [character(1)]
#' @examples

#'  updateInputTemplate('CustomInput')

#' @export
updateInputTemplate <- function(inputName) {
    # Generate a template function for updating a custom shiny input
    assert_string(inputName)
    tmp = readLines(paste0(
        system.file(package = "ShinyReboot"),
        "/templates/updateInputTemplate.r"
    )) %sep% "\n"
    glue(tmp, .open = "&&", .close = "&&")
    # Returns: [character(1)]
}
