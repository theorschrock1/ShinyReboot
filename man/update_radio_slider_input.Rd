% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/update_radio_slider_input.R
\name{update_radio_slider_input}
\alias{update_radio_slider_input}
\title{Update a radio slider input.}
\usage{
update_radio_slider_input(
  ...,
  inputId,
  range = NULL,
  selected = NULL,
  label = NULL,
  session = getDefaultReactiveDomain()
)
}
\arguments{
\item{inputId}{\code{[string]}}

\item{range}{\code{[atomic]}  Defaults to \code{NULL}}

\item{selected}{\code{[choice]}  Possible values: \code{range}.  NULL is ok.  Defaults to \code{NULL}}

\item{label}{\code{[string]}  NULL is ok.  Defaults to \code{NULL}}

\item{session}{\code{[NULL]}  Defaults to \code{getDefaultReactiveDomain()}.}
}
\value{
\code{update_radio_slider_input}: \code{[invisible(NULL)]}
}
\description{
Update a radio slider input.
}
\examples{
 update_radio_slider_input(inputId = 'myid', range = LETTERS,
 label = 'new_label', selected = 'A')
}
