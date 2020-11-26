#' Create a new BS4 app from a template.

#' @name new_shiny_app
#' @param app_name  [character]  Must have an exact length of 1.
#' @param template  [character]  Must have an exact length of 1.  Defaults to 'dashboardTemplate'
#' @return \code{new_shiny_app}: NULL
#' @export
new_shiny_app <- function(app_name, template = "dashboardTemplate") {
    # Create a new BS4 app from a template
    assert_character(app_name, len = 1)
    assert_character(template, len = 1)
    if (!dir.exists(glue("~/ShinyReboot/{template}/"))) 
        g_stop("'{template}' template doesn't exist")
    if (dir.exists(app_name)) 
        g_stop("{app_name} already exists")
    dir.create(app_name)
    R.utils::copyDirectory(from = "~/ShinyReboot/{template}/", to = glue("{app_name}/"))
    R.utils::copyFile("~/ShinyReboot/{template}/app.R", glue("{app_name}/{app_name}_app.R"))
    file.rename(glue("{app_name}/app.R"), glue("{app_name}/{app_name}_app.R"))
    file.edit(glue("{app_name}/{app_name}_app.R"))
    # Returns: NULL
}
