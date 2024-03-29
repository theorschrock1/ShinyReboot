% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/ao_color_picker.R
\name{ao_color_picker}
\alias{ao_color_picker}
\title{create html color picker.}
\usage{
ao_color_picker(..., inputId, color = "#0A5ED3", opacity = 0)
}
\arguments{
\item{inputId}{\code{[string]}}

\item{color}{\code{[choice]}  Possible values: \code{unique(c(black(), dgreys(), white(), lgreys(), oranges(), purples(), yellows(), l_purples(),l_greens(), pinks(), d_greens(), reds(), l_blues(), browns(), blues(), bgreys()))}.  Defaults to \code{'#0A5ED3'}}

\item{opacity}{\code{[number]}  Must be greater than \code{0}.  Must be less than \code{1}.  Defaults to \code{0}}
}
\value{
\code{ao_color_picker}: \code{[html]}
}
\description{
create html color picker.
}
