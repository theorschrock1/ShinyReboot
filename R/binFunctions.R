bin_break_bins=function (x_range, bins = 30, center = NULL, boundary = NULL,
          closed = c("right", "left"))
{
  if (length(x_range) != 2)
    abort("`x_range` must have two elements")
  bins <- as.integer(bins)
  if (bins < 1) {
    abort("Need at least one bin.")
  }
  else if (zero_range(x_range)) {
    width <- 0.1
  }
  else if (bins == 1) {
    width <- diff(x_range)
    boundary <- x_range[1]
  }
  else {
    width <- (x_range[2] - x_range[1])/(bins - 1)
  }
  bin_breaks_width(x_range, width, boundary = boundary, center = center,
                   closed = closed)
}
bin_breaks=function (breaks, closed = c("right", "left"))
{
  bins(breaks, closed)
}
bin_breaks_width=function (x_range, width = NULL, center = NULL, boundary = NULL,
          closed = c("right", "left"))
{
  if (length(x_range) != 2)
    abort("`x_range` must have two elements")
  if (!(is.numeric(width) && length(width) == 1))
    abort("`width` must be a numeric scalar")
  if (width <= 0) {
    abort("`binwidth` must be positive")
  }
  if (!is.null(boundary) && !is.null(center)) {
    abort("Only one of 'boundary' and 'center' may be specified.")
  }
else if (is.null(boundary)) {
  if (is.null(center)) {
    boundary <- width/2
  }
  else {
    boundary <- center - width/2
  }
}
x_range <- as.numeric(x_range)
width <- as.numeric(width)
boundary <- as.numeric(boundary)
shift <- floor((x_range[1] - boundary)/width)
origin <- boundary + shift * width
max_x <- x_range[2] + (1 - 1e-08) * width
breaks <- seq(origin, max_x, width)
if (length(breaks) == 1) {
  breaks <- c(breaks, breaks + width)
}
else if (length(breaks) > 1e+06) {
  abort("The number of histogram bins must be less than 1,000,000.\nDid you make `binwidth` too small?")
}
bin_breaks(breaks, closed = closed)
}

bins=function (breaks, closed = c("right", "left"), fuzz = 1e-08 * stats::median(diff(breaks)))
{
  if (!is.numeric(breaks))
    abort("`breaks` must be a numeric vector")
  closed <- match.arg(closed)
  breaks <- sort(breaks)
  if (closed == "right") {
    fuzzes <- c(-fuzz, rep.int(fuzz, length(breaks) - 1))
  }
  else {
    fuzzes <- c(rep.int(-fuzz, length(breaks) - 1), fuzz)
  }
  structure(list(breaks = breaks, fuzzy = breaks + fuzzes,
                 right_closed = closed == "right"), class = "ggplot2_bins")
}
#' @export
bin=function(x,n=pmin(30,floor(sqrt(l(x))))){

  newBinned(x)
}
#' @export
newBinned <- function(x = numeric(),n=pmin(30,floor(sqrt(l(x))))) {
  b=labeling::extended(min(x),max(x), 30,
                             only.loose = TRUE, w = c(0.01, 0.7, 0.7, 0.01))
  mids=frollmean(b,n=2)[-1]
  breaks=b[1:l( mids)]
  out=approx(breaks,mids,method = 'constant',xout=x,yright = last(mids))$y
  structure( out, class = "binned",breaks=b,width=min(diff( b)))
}
#' @export
is_binned=function(x){
 is(x,'binned')

}
#' @export
unique.binned=function(x){
  out<-unique.default(x)
  attributes(out)<-attributes(x)
  out
}
#' @export
`[.binned`<-function (x, ...)
{
  y <- NextMethod("[")
  attr(y, "breaks") <- attr(x, "breaks")
  attr(y, "width") <- attr(x, "width")
  class(y) <- oldClass(x)
  y
}
#' @export
range.binned=function(x,...){
 range(attr(x, "breaks") )
}

#' @export
extend_breaks=function(breaks,range){
  maxr=max(range)
  minr=min(range)
  width=resolution(breaks,zero = F)
  end=NULL
  start=NULL
  if(max(range)>max(breaks))
    end= seq(max(breaks),maxr,by=width)
  if(min(range)<min(breaks))
    start= seq(min(breaks),minr,by=-width)
  unique(sort(c(start,
                breaks,
                end)))

}
