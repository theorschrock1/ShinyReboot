% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/draggable_model.R
\name{draggable_model}
\alias{draggable_model}
\title{Create a draggable model.}
\usage{
draggable_model(..., inputId, left, top, width = NULL)
}
\arguments{
\item{...}{inner html}

\item{inputId}{\code{[string]}}

\item{left}{\code{[number]} Percentage from the left that the model should be shown. Must be greater than \code{0}.  Must be less than \code{100}.}

\item{top}{\code{[number]} Percentage from the top that the model should be shown. Must be greater than \code{0}.  Must be less than \code{100}.}
}
\value{
\code{draggable_model}: \code{[html]}
}
\description{
Create a draggable model.
}
\examples{
 draggable_model(inputId = 'drag', left = 10, top = 10, width = '30\%')
 draggable_model(inputId = 'drag', class = 'myModel', left = 10,
 top = 10, width = '30\%', div('someContent'))
 draggable_model(inputId = 'drag', left = 100, top = 10, width = '30px')

 if(interactive()) {
 library("shiny")
 library("ShinyReboot")
 library("bslib")
 bs_global_theme()
 ui <- fluidPage(
 bs_theme_dependencies(theme = bs_global_get()),

 tags$h1("Draggable Model"),
 draggable_model_btn(
 inputId = "show_model",
 toggleId = 'example',
 class = "btn btn-primary new-var-btn",
 "toggle modal"
 ),
 actionButton(
 inputId = "show",
 class = "btn btn-primary new-var-btn",
 label="show modal"
 ),
 actionButton(
 inputId = "hide",
 class = "btn btn-primary new-var-btn",
 label="hide modal"
 ),
 draggable_model(
 class = "card rounded-0 bg-light p-1",
 inputId = "example",
 top = 40,
 left = 20,
 div(class = 'drag-handle w-100', "Drag Me"),
 div(
 class = "d-flex mt-4",
 draggable_model_btn(
 inputId = "ok_close",
 toggleId = 'example',
 class = "btn btn-outline-dark btn-sm rounded-0 var-btn mr-1",
 'OK'
 ),
 tags$button(class = "btn btn-outline-dark btn-sm rounded-0 var-btn mr-auto",
 "Apply"),
 draggable_model_btn(
 inputId = "cancel_close",
 toggleId = 'example',
 class = "btn btn-outline-dark btn-sm rounded-0 var-btn",
 "Cancel"
 )
 )
 )
 )

 server = function(input, output, session) {
 observe({
 print(input$example)
 })
 observeEvent(input$show,{
 req(input$show)
 show_draggable_model('example')
 })
 observeEvent(input$hide,{
 req(input$hide)
 hide_draggable_model('example')
 })
 }
 shinyApp(ui = ui, server = server)
 }
}
