#' @export
StatDens= R6Class(
  'StatDens',
  inherit=AoStat,
  public = list(
    aes=ops(x = , y = stat(density), fill = NA, weight =1,flippable=TRUE),
    layer_params = ops(
      adjust = num(1),
      kernel = choice(
        "gaussian",
        choices = c(
          "gaussian",
          "epanechnikov",
          "rectangular",
          "triangular",
          "biweight",
          "cosine",
          "optcosine"
        )
      ),
      n = int(512),
      trim = TF(FALSE),
      na.rm = TF(FALSE)),
setup_params = function(data, params,scales) {
  pos=scales$get_pos_continuous_aes()
  if(length(pos)!=1){
    abort("stat_density() requires x|y to be a continuous variable")
  }

  params
},
setup_data = function(data, params,scales){
  if('xgrid'%nin%names(data))
    data[,xgrid:='x-start / x-end']
  if('ygrid'%nin%names(data))
    data[,ygrid:='y-start / y-end']
  data
},
compute_group = function(data, scales, adjust = 1, kernel = "gaussian",
                         n = 512, trim = FALSE, na.rm = FALSE,flipped_aes=FALSE) {
  bw = "nrd0"
  data <- flip_data(as.list(data), flipped_aes)
  if (trim|is.null(scales)) {
    range <- range(data$x, na.rm = TRUE)
  } else {
    range <- scales[[flipped_coord('x',flipped_aes)]]$dimension()
  }

  density <- self$compute_density(data$x, data$weight, from = range[1],
                             to = range[2], bw = bw, adjust = adjust, kernel = kernel, n = n)
  density[,flipped_aes:= flipped_aes]
  flip_data(density, flipped_aes)
  density
},
compute_density =function(x, w, from, to, bw = "nrd0", adjust = 1,
                            kernel = "gaussian", n = 512) {
  nx <- length(x)
  if (is.null(w)) {
    w <- rep(1 / nx, nx)
  } else {
    w <- w / sum(w)
  }

  # if less than 2 points return data frame of NAs and a warning
  if (nx < 2) {
    warn("Groups with fewer than two data points have been dropped.")
    return(as.data.table(list(
      x = NA_real_,
      density = NA_real_,
      scaled = NA_real_,
      ndensity = NA_real_,
      count = NA_real_,
      n = NA_integer_
    ), n = 1))
  }

  dens <- stats::density(x, weights = w, bw = bw, adjust = adjust,
                         kernel = kernel, n = n, from = from, to = to)

  as.data.table(list(
    x = dens$x,
    density = dens$y,
    scaled =  dens$y / max(dens$y, na.rm = TRUE),
    ndensity = dens$y / max(dens$y, na.rm = TRUE),
    count =   dens$y * nx,
    n = nx
  ))
}
))
#' @export
stat_dens=StatDens$new()$build_fn()

