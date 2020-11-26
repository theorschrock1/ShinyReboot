#' Create a new shiny input dependency.

#' @name newShinyInputBinding
#' @param name  [string]
#' @return \code{newShinyInputBinding}: NULL
#' @export
newShinyInputBinding <- function(name) {
    # Create a new shiny input dependency
    assert_string(name)
    if (dir.exists(glue("assests/{name}")))
        g_stop("html dependency `{name}` exists")
    dir.create("inst/assets/{name}")
    tmp <- readLines(paste0(system.file(package = "ShinyReboot"),"/templates/shinyInputTemplate.js")) %sep% "\n"
    write(glue(tmp, .open = "&&", .close = "&&"), glue("inst/assets/{name}/{name}Binding.js"))
    write("", glue("inst/assets/{name}/{name}.css"))
    fn <- new_function(args = NULL, body = expr({
        htmlDependency(name = !!name, version = packageVersion(!!current_pkg()),
            src = !!glue("assets/{name}"), package = !!current_pkg(), stylesheet = !!glue("{name}.css"),
            script = !!glue("{name}Binding.js"), all_files = FALSE)
    }))
    out = expr(!!sym(glue("{name}_depends")) <- !!fn)
    if (file.exists("R/dependencies.r")) {
        depends <- readLines("R/dependencies.r")
        writeLines(c(depends, "\n", "#' @export", exprs_deparse(list(out))[[1]]),
            "R/dependencies.r")
    }
    if (!file.exists("R/dependencies.r")) {
        writeLines(c("#' @export", exprs_deparse(list(out))[[1]]), "R/dependencies.r")
    }
    g_print("JS and css templates written to assets/{name}/")
    g_print("Dependency written to R/dependencies.R")
    file.edit(glue('inst/assets/{name}/{name}Binding.js'))
    # Returns: NULL
}
