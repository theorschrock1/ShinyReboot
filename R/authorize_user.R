#' Authorize app access.

#' @name authorize_user
#' @param id  \code{[string]} a unique id for the module
#' @param user  \code{[string]} a user name to bypass login page. NULL is ok.  Defaults to \code{NULL}
#' @param pw  \code{[string]} a password to bypass login page. NULL is ok.  Defaults to \code{NULL}
#' @param path  \code{[file]}  path to the user database. Defaults to \code{'udb.rds'}
#' @param app_ui  \code{[function]} a function to generate the UI if login is sucsessful. NULL is ok.  Defaults to \code{NULL}
#' @return \code{authorize_user}: \code{[character(1)|FALSE]} returns the username if the log in was successful. Otherwise \code{FALSE}.
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
    app_ui = NULL,logo_path=NULL,logo_width=NULL,logo_height=NULL) {
    # Authorize app access
    assert_string(id)
    assert_string(user, null.ok = TRUE)
    assert_string(pw, null.ok = TRUE)
    assert_file(path, extension = "rds")
    assert_function(app_ui, null.ok = TRUE)
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        vals <- reactiveValues(is_invalid = FALSE, res = NULL)
        observe({
            req(udb())
            if (is.null(user) | is.null(pw)) {
            insertUI(selector = "body > div.container-fluid",
                  ui = authorize_ui(id,logo_path=logo_path,logo_width=logo_width,logo_height=logo_height), where = "beforeEnd")
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
            #print("sds")
            vals$res = udb()$enter(input$auth_email, input$auth_pw)
        })
        observeEvent(vals$res, {
            # print("sdfas")
            # print(vals$res)
            # print(!isTRUE(vals$res))
            # print(isTRUE(vals$login))
            if (!isTRUE(vals$res) && isTRUE(vals$loginUI)) {

                shinyjs::addClass(id = "auth_email", "is-invalid")
                shinyjs::addClass(id = "auth_pw", "is-invalid")
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
                shinyjs::removeClass(id = "auth_email", "is-invalid")
                shinyjs::removeClass(id = "auth_pw", "is-invalid")
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
authorize_ui <- function(id,logo_path=NULL,logo_width=NULL,logo_height=NULL) {
    #Documentation
    ns <- NS(id)
    img=NULL
   if(nnull(logo_path)){
       #assert_file(logo_path)
       assert_number(logo_width)
       assert_number(logo_height)
      img= tags$img(class = "mb-4", src =logo_path,
                alt = "", width = as.character(logo_width), height = as.character(logo_height))
   }
   inner=tagList(img,tags$h1(class = "h3 mb-3 font-weight-normal",
            "Please sign in"),
    tags$label(`for` = ns("auth_email"), class = "sr-only",
               "Email address"),
    tags$input(
        type='text',
        id = ns("auth_email"),
        class = "form-control",
        placeholder = "Username",
        required = "required",
        autofocus = "autofocus"
    ),
    tags$label(`for` =  ns("auth_pw"),
               class = "sr-only", "Password"),
    tags$input(
        type = "password",
        id = ns("auth_pw"),
        class = "form-control",
        placeholder = "Password",
        required = "required"
    ),
    div(class = "checkbox mb-3", tags$label(
        tags$input(type = "checkbox",
                   value = "remember-me"),
        "Remember me"
    ),
    div(id = "validationUP",
        class = "invalid-feedback", "Invalid username or password")
    ),
    actionButton(inputId=ns('submit'),label="Sign in",class = "btn btn-lg btn-primary btn-block",type = "submit"),
    tags$p(class = "mt-5 mb-3 text-muted",
           "2020"))

    signInTag<-tags$form(
        class = "form-signin")
    signInTag=tagAppendChild( signInTag,inner)

    #out<-attachDependencies( signInTag,html_dependency_ShinySignIn() )

 div(id=ns('signin'),class='signindiv',shinyjs::useShinyjs(),tags$link(rel='stylesheet',type='text/css',href='ShinyReboot/signin/signin.css'), signInTag)

}

