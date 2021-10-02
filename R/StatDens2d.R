StatDens2d = R6Class(
  'StatDens2d',
  inherit=AoStat,
  public = list(
    initialize = function( aes=.D(x=,y=,fill=stat(level)),
                           contour = TRUE,
                           contour_var = "density",
                           n = 100,
                           h = NULL,
                           adjust = c(1, 1),
                           na.rm = FALSE,pkg='ks',...) {

      self$super_init(aes=aes)
      self$params=list(...,
                       contour = contour,
                       contour_var =   contour_var,
                       n = n,
                       h = h,
                       adjust =  adjust,
                       na.rm =na.rm)
    },
    super_init=import_fn(super_init),
    compute_layer = function(data, params=self$params,scales=NULL) {

      data <- super$compute_layer(data, params=params, scales=scales)

      # if we're not contouring we're done
      if (!isTRUE(params$contour)) return(data)
      contour_var <- params$contour_var %||% "density"
      if (!isTRUE(contour_var %in% c("density", "ndensity", "count")))
         g_stop(
          'Unsupported value for `contour_var`: {contour_var}\nSupported values are "density", "ndensity", and "count".'
        )
      data[,z:=.SD[[contour_var]]]
      contour_stat <- StatContourAO$new()


      args <- c(list(data = data, scales = scales), params)
      data<-do.call(contour_stat$compute_panel, args)
      data<-contour_stat$set_after_stat_mapping(data,scales)
      data
    },
    compute_group = function(data, scales=scales, na.rm = FALSE, h = NULL, adjust = c(1, 1),n = 100,pkg='ks', ...) {
      if (is.null(h)) {
        h <- c(MASS::bandwidth.nrd(data$x), MASS::bandwidth.nrd(data$y))
        h <- h * adjust
      }
      xlim=scales$x$dimension()
      ylim=scales$y$dimension()
      if(pkg=='ks'){

      xmin = c(min(xlim),min(ylim))
      xmax = c(max(xlim),max(ylim))

      fhat <- ks::kde(x=cbind(x=data$x,y=data$y),gridsize = n,h=h,xmin=xmin,xmax=xmax)
      dens=list(x=fhat$eval.points[[1]],y=fhat$eval.points[[2]],z=fhat$estimate)
      }else{
      dens <- MASS::kde2d(
        data$x, data$y, h = h, n = n,
        lims = c(  xlim,ylim))
      }

      nx <- nrow(data) # number of observations in this group
      g <- expand.grid(x = dens$x, y = dens$y)
      df=list(x=g$x,y=g$y)
      df$density <- as.vector(dens$z)
      df$ndensity <- df$density / max(df$density, na.rm = TRUE)
      df$count <- nx * df$density
      df$n <- nx
      df$level <- 1
      df$piece <- 1
      df
    }
  ),
  private = list(.init=FALSE),
  active = list()
)
