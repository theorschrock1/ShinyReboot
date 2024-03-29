% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/dropdown_btn_group.R
\name{dropdown_btn_group}
\alias{dropdown_btn_group}
\title{Create an dropdown button group.}
\usage{
dropdown_btn_group(
  ...,
  inputIds,
  labels,
  state = "",
  types,
  class = "",
  check_icon = "check-bold"
)
}
\arguments{
\item{inputIds}{[character]}

\item{labels}{[character]  Must have an exact length of length.  Must have an exact length of inputIds.}

\item{state}{[character]  Defaults to ''}

\item{types}{[character]  Must have an exact length of or equal to one of the following: [1,length(inputIds)].}

\item{class}{[character]  Defaults to ''}

\item{check_icon}{[character]  Must have an exact length of 1.  Defaults to 'check-bold'}
}
\value{
\code{dropdown_btn_group}: [HTML]
}
\description{
Create an dropdown button group.
}
\examples{
 dropdown_btn_group(inputIds = c('copy', 'duplicate', 'edit'),
 labels = c('Copy', 'Duplicate', 'Edit'), types = c('action',
 'action', 'model'))
}
