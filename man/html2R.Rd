% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/html2R.R
\name{html2R}
\alias{html2R}
\title{Generate R code from raw html.}
\usage{
html2R(
  x,
  try_parsing = TRUE,
  silent_eval = TRUE,
  from_clip = FALSE,
  write_to_clipboard = is_interactive()
)
}
\arguments{
\item{x}{[character]  Must have an exact length of 1.}

\item{try_parsing}{[logical]  Must have an exact length of 1.  Defaults to TRUE}

\item{silent_eval}{[logical]  Try evaluating the R code? Must have an exact length of 1.  Defaults to TRUE}
}
\value{
\code{html2R}: R code
}
\description{
Generate R code from raw html.
}
\examples{
 x = '<div class=\'btn-group\' role=\'group\' aria-label=\'Basic example\'>\n    <button type=\'button\' class=\'btn btn-secondary\'>Left</button>\n      <button type=\'button\' class=\'btn btn-secondary\'>Middle</button>\n        <button type=\'button\' class=\'btn btn-secondary\'>Right</button>\n          </div>'
 html2R(x)
}
