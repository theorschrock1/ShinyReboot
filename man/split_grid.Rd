% Generated by roxygen2: do not edit by hand
% Please edit documentation in R/split_grid.R
\name{split_grid}
\alias{split_grid}
\title{Create a grid with resizable rows or columns.}
\usage{
split_grid(
  ...,
  inputId,
  nrow,
  ncol,
  minSize = 0,
  gutterSize = 1,
  row_sizes = "auto",
  column_sizes = "auto",
  grid_assignments = NULL,
  gutter_assignments = NULL,
  gutterAttrs = NULL,
  rowGutterAttrs = NULL,
  colGutterAttrs = NULL,
  dragInterval = 1,
  columnDragInterval = NULL,
  rowDragInterval = NULL,
  columnMinSize = NULL,
  rowMinSize = NULL,
  columnMinSizes = NULL,
  rowMinSizes = NULL,
  snapOffset = 0,
  columnSnapOffset = NULL,
  rowSnapOffset = NULL,
  columnCursor = "col-resize",
  rowCursor = "row-resize",
  onDrag = NULL,
  onDragStart = NULL,
  onDragEnd = NULL
)
}
\arguments{
\item{inputId}{[character] the shiny inputId and id of the outer div. Defaults to NULL.  If null, a random id will be generated.}

\item{minSize}{[number] The minimum size in pixels for all tracks. Default: 0}

\item{gutterSize}{[numeric]  Gutter size in pixels. Defaults to 10.}

\item{row_sizes}{[character css(auto,fr,px)] length 1 or length nrows.}

\item{column_sizes}{[character css(auto,fr,px)] length 1 or length nrows.}

\item{grid_assignments}{\code{list(html=class('shiny.tag'),row=int(),col=int(),rowspan=int(NULL),colspan=int())}.}

\item{gutterAttrs}{[list] a list of html attributes to use when creating the gutters. Defaults to NULL.}

\item{rowGutterAttrs}{a list of html attributes to use when creating the gutters. Defaults to gutterAttr.}

\item{colGutterAttrs}{a list of html attributes to use when creating the gutters. Defaults to gutterAttr}

\item{dragInterval}{[numeric] Number of pixels to drag. Defaults to 1}

\item{columnDragInterval}{[numeric]  Number of pixels to drag. Defaults to 1}

\item{rowDragInterval}{[numeric]  Number of pixels to drag. Defaults to 1}

\item{columnMinSize}{[number] The minimum size in pixels for all tracks.}

\item{rowMinSize}{[number] The minimum size in pixels for all tracks.}

\item{columnMinSizes}{list(column=[number],minSize=[number]) An list by column/row index, with values set to the minimum size in pixels for the column/row at that index. Allows individual minSizes to be specified by  column/row. Note this option is plural with an s, while the two fallback options are singular.}

\item{rowMinSizes}{list(row=[number],minSize=[number]) See columnMinSizes.}

\item{snapOffset}{[numeric] Snap to minimum size offset in pixels. Defaults to 30}

\item{columnSnapOffset}{[numeric] Snap to minimum size offset in pixels. Defaults to \code{snapOffset}.}

\item{rowSnapOffset}{[numeric] Snap to minimum size offset in pixels. Defaults to \code{snapOffset}.}

\item{columnCursor}{[string] Cursor to show while dragging. Default: 'col-resize'}

\item{rowCursor}{[string] Cursor to show while dragging. Default: 'row-resize'}

\item{onDrag}{[JS Function] Callback on drag. Defaults to NULL}

\item{onDragStart}{[JS Function] Callback on drag start. Defaults to NULL}

\item{onDragEnd}{[JS Function] Callback on drag end. Defaults to NULL}

\item{grid_dims}{[int(len=2)] \code{c(nrows,ncols)]}}

\item{autoAssign}{[logical(FALSE)] Defaults to FALSE. Defaults to TRUE if grid assignments rows and cols are not present.}

\item{autoAssignbyRow}{[logical(FALSE)] should the auto_assignment fill by column or row first?}
}
\value{
\code{split_grid}: html
}
\description{
Create a grid with resizable rows or columns.
}
