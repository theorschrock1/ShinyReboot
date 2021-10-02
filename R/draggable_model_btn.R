#' Create a button to show or hide a draggable model.

#' @name draggable_model_btn
#' @param ...
#' @param inputId  \code{[string]}
#' @param toggleId  \code{[string]}
#' @param outerTag  \code{[string]}  Defaults to \code{'button'}
#' @return \code{draggable_model_btn}: \code{[html]}
#' @examples
#'  draggable_model_btn(inputId = 'drag_btn', toggleId = 'drag',
#'  'Show')
#'  draggable_model_btn(inputId = 'drag_btn', toggleId = 'drag',
#'  'Show', outerTag = 'div')
#'  if(interactive()) {
#'  library("shiny")
#'  library("ShinyReboot")
#'  library("bslib")
#'  bs_global_theme()
#'  ui <- fluidPage(
#'  bs_theme_dependencies(theme = bs_global_get()),
#'
#'  tags$h1("Draggable Model"),
#'  draggable_model_btn(
#'  inputId = "show_model",
#'  toggleId = 'example',
#'  class = "btn btn-primary new-var-btn",
#'  "Launch demo modal"
#'  ),
#'  draggable_model(
#'  class = "card rounded-0 bg-light p-1",
#'  inputId = "example",
#'  top = 40,
#'  left = 20,
#'  div(class = 'drag-handle w-100', "Drag Me"),
#'  div(
#'  class = "d-flex mt-4",
#'  draggable_model_btn(
#'  inputId = "ok_close",
#'  toggleId = 'example',
#'  class = "btn btn-outline-dark btn-sm rounded-0 var-btn mr-1",
#'  'OK'
#'  ),
#'  tags$button(class = "btn btn-outline-dark btn-sm rounded-0 var-btn mr-auto",
#'  "Apply"),
#'  draggable_model_btn(
#'  inputId = "cancel_close",
#'  toggleId = 'example',
#'  class = "btn btn-outline-dark btn-sm rounded-0 var-btn",
#'  "Cancel"
#'  )
#'  )
#'  )
#'  )
#'
#'  server = function(input, output, session) {
#'  observe({
#'  print(input$example)
#'  })
#'  }
#'  shinyApp(ui = ui, server = server)
#'  }
#' @export
draggable_model_btn <- function(..., inputId, toggleId, outerTag = "button") {
    # Create a button to show or hide a draggable model
    assert_string(inputId)
    assert_string(toggleId)
    assert_string(outerTag)
    restoreInput(inputId, default = NULL)
    dots = list(...)
    tag <- expr(tags$button(!!!dots))
    tag[[1]][[3]] <- sym(outerTag)
    tag <- eval(tag) %>% tagAppendAttributes(id = inputId, class = "toggle-draggable-model", `data-toggle-model` = toggleId)
    as_shiny_button(tag)
    # Returns: \code{[html]}
}
