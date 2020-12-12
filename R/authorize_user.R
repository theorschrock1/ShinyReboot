#' Authorize app access.

#' @name authorize_user
#' @param id  \code{[string]}
#' @param user  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param pw  \code{[string]}  NULL is ok.  Defaults to \code{NULL}
#' @param path  \code{[file]}  Defaults to \code{'udb.rds'}
#' @param app_ui  \code{[function]}  NULL is ok.  Defaults to \code{NULL}
#' @return \code{authorize_user}: \code{[character(1)]}
#' @examples

#'  if (interactive()) {
#'  library(shiny)
#'  library(ShinyReboot)
#'  library(bslib)
#'  bslib::bs_global_theme()
#'  ui <- fluidPage(tags$head(bslib::bs_theme_dependencies(theme = bs_global_get())),
#'  titlePanel('authorize module example'), uiOutput('loggedin'))
#'  server <- function(input, output, session) {
#'  out <- authorize_user(id = 'mod_id')
#'  output$loggedin <- renderUI({
#'  req(out())
#'  fluidRow(h3(glue('Logged in as {out()}')))
#'  })
#'  }
#'  shinyApp(ui, server)
#'  }
#' @export
authorize_user <- function(id, user = NULL, pw = NULL, path = "udb.rds", 
    app_ui = NULL) {
    # Authorize app access
    assert_string(id)
    assert_string(user, null.ok = TRUE)
    assert_string(pw, null.ok = TRUE)
    assert_file(path, extension = ".rds")
    assert_function(app_ui, null.ok = TRUE)
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        vals <- reactiveValues(is_invalid = FALSE, res = NULL)
        observe({
            req(udb())
            if (is.null(user) | is.null(pw)) {
                insertUI(selector = "body > div.container-fluid", 
                  ui = authorize_ui(id), where = "beforeEnd")
                vals$loginUI = TRUE
            } else {
                res = udb()$enter(user, pw)
                if (!isTRUE(res)) {
                  g_stop("Incorrect username or password")
                }
                vals$res = res
            }
        })
        udb <- reactive({
            readRDS(path)
        })
        observeEvent(input$submit, {
            req(input$auth_email)
            req(input$auth_pw)
            print("sds")
            vals$res = udb()$enter(input$auth_email, input$auth_pw)
        })
        observeEvent(vals$res, {
            req(vals$res)
            if (!isTRUE(vals$res) && isTRUE(vals$login)) {
                addClass(id = "auth_email", "is-invalid")
                addClass(id = "auth_pw", "is-invalid")
                vals$is_invalid = TRUE
            }
            if (isTRUE(vals$res)) {
                removeUI(paste0("#", ns("signin")))
                if (!is.null(app_ui)) 
                  insertUI(selector = "body > div.container-fluid", 
                    ui = app_ui(), where = "beforeEnd")
            }
        })
        observe({
            req(vals$loginUI)
            if (input$auth_pw == "" && vals$is_invalid) {
                removeClass(id = "auth_email", "is-invalid")
                removeClass(id = "auth_pw", "is-invalid")
                vals$is_invalid = FALSE
            }
        })
        user_name = reactive({
            if (isTRUE(vals$loginUI)) 
                return(input$auth_email)
            user
        })
        out = eventReactive(vals$res, {
            if (isTRUE(vals$res)) {
                return(input$auth_email %or% user)
            }
            FALSE
        })
        return(reactive(out()))
    })
    # Returns: \code{[character(1)]}
}
