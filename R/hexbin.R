hex_bounds=function (x, binwidth)
{
  c(round_any(min(x), binwidth, floor) - 1e-06, round_any(max(x),
                                                          binwidth, ceiling) + 1e-06)
}

round_any=function (x, accuracy, f = round)
{
  if (!is.numeric(x))
    g_stop("`x` must be numeric")
  f(x/accuracy) * accuracy
}
#' @export
hexBin=function (x, y,binwidth=hex_binwidth(x_range = x,y_range=y), wt=rep(1L,length(x)),  fun = sum, fun.args = list(), drop = TRUE)
{
  if (length(binwidth) == 1) {
    binwidth <- rep(binwidth, 2)
  }
  xbnds <- hex_bounds(x, binwidth[1])
  xbins <- diff(xbnds)/binwidth[1]
  ybnds <- hex_bounds(y, binwidth[2])
  ybins <- diff(ybnds)/binwidth[2]
  z=wt
  hb <- hexbin::hexbin(x, xbnds = xbnds, xbins = xbins, y,
                       ybnds = ybnds, shape = ybins/xbins, IDs = TRUE)
  value <- do.call(tapply, c(list(quote(z), quote(hb@cID),
                                  quote(fun)), fun.args))

  out <- hexbin::hcell2xy(hb)
  #out[,value:= as.vector(value)]
  if (drop)
    out <- stats::na.omit(out)
  out$count =as.vector(value)

  out$density <- as.vector(out$count / sum(out$count, na.rm = TRUE))
  out$ndensity <- out$density / max(out$density, na.rm = TRUE)

  out$ncount <- out$count / max(out$count, na.rm = TRUE)


  out
}

hex_binwidth=function (bins = 30, x_range,y_range)
{
  c(diff(x_range)/bins, diff(y_range)/bins)
}

