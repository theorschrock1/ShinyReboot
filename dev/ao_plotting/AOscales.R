#' @export
AoScales<- R6::R6Class("AoScales",
                      public=list(
                      scales = NULL,
                      initialize=function(scales=NULL){
                        self$scales=scales
                      },
                      find = function(aesthetic){
                        vapply(self$scales, function(x) any(aesthetic %in% x$aes), logical(1))
                      },
                      has_scale = function(aesthetic) {
                        any(self$find(aesthetic))
                      },
                      add = function(scale,replace=FALSE) {
                        if (is.null(scale)) {
                          return()
                        }

                        prev_aes <- self$find(scale$aes)


                        if (any(prev_aes)) {
                          if(replace==FALSE){
                          if(scale$is_discrete!=self$scales[prev_aes][[1]]$is_discrete)
                            g_stop('cannot combine discrete and non discrete scales for `{self$scales[prev_aes][[1]]$aes[1]}`')
                          }

                          if(replace==TRUE){
                          self$scales <- c(self$scales[!prev_aes], list(scale))
                          }

                        }else{
                          self$scales <- c(self$scales, list(scale))
                        }


                      },
                      n = function() {
                        length(self$scales)
                      },
                      input = function() {
                        unlist(lapply(self$scales, "[[", "aesthetics"))
                      },
                      non_position_scales = function() {
                        AoScales$new(scales = self$scales[!self$find("x") & !self$find("y")])
                      },
                      position_scales = function() {
                        AoScales$new(scales = self$scales[self$find("x") | self$find("y")])
                      },
                      get_scales = function(output) {
                        scale <- self$scales[self$find(output)]
                        if (length(scale) == 0) return()
                        scale[[1]]
                      },
                      reset=function(scales=self$scales){
                      lapply(scales,function(x){
                        x$reset()
                      })
                        return(invisible(NULL))
                      },
                      subset=function(aesthetics){
                        AoScales$new(scales = self$scales[self$find(aesthetics)])
                      },
                      get_discrete_aes=function(scales=self$scales){
                        aes<-  names(AoScales$active)
                      names(aes)<-aes
                        out=drop_nulls(lapply( aes,function(x){
                          self[[x]]$is_discrete
                        }))
                        names(out)[unlist(out)==T]%or%NULL
                      },
                      get_pos_discrete_aes=function(scales=self$scales){
                        self$get_discrete_aes(scales=scales)%IN%c("x","y")%or%NULL
                      },
                      get_npos_discrete_aes=function(scales=self$scales){
                        aes<-  names(AoScales$active)%NIN%c('x','y')
                        names(aes)<-aes
                        out=drop_nulls(sapply( aes,function(x){
                          self[[x]]$is_discrete
                        }))
                        names(out)[unlist(out)==T]%or%NULL
                      },
                      get_continuous_aes=function(scales=self$scales){
                        aes<-  names(AoScales$active)
                        names(aes)<-aes
                        out=drop_nulls(sapply( aes,function(x){
                          self[[x]]$is_discrete
                        }))
                        names(out)[unlist(out)==F]%or%NULL
                      },
                      get_npos_continuous_aes=function(scales=self$scales){
                        aes<-  names(AoScales$active)%NIN%c('x','y')
                        names(aes)<-aes
                        out=drop_nulls(sapply( aes,function(x){
                          self[[x]]$is_discrete
                        }))
                        names(out)[unlist(out)==F]%or%NULL
                      },
                      get_pos_continuous_aes=function(scales=self$scales){
                        self$get_continuous_aes(scales=scales)%IN%c("x","y")%or%NULL
                      },
                      get_scale_names=function(scales=self$scales){
                        aes<-  names(AoScales$active)
                        names(aes)<-aes
                        out=aes[sapply( aes,function(x){
                         nnull(self[[x]])
                        })]
                       out
                      }
                     ),
                      private = list(),
                      active=list(
                        x = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("x"))
                          }
                          stop("x is read only")

                        },
                        y = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("y"))
                          }
                          stop("y is read only")

                        },
                        alpha = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("alpha"))
                          }
                          stop("alpha is read only")

                        },
                        angle = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("angle"))
                          }
                          stop("angle is read only")

                        },
                        color = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("color"))
                          }
                          stop("color is read only")

                        },
                        fill = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("fill"))
                          }
                          stop("fill is read only")

                        },
                        hjust = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("hjust"))
                          }
                          stop("hjust is read only")

                        },
                        vjust = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("vjust"))
                          }
                          stop("vjust is read only")

                        },
                        label = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("label"))
                          }
                          stop("label is read only")

                        },
                        linetype = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("linetype"))
                          }
                          stop("linetype is read only")

                        },
                        radius = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("radius"))
                          }
                          stop("radius is read only")

                        },
                        shape = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("shape"))
                          }
                          stop("shape is read only")

                        },
                        size = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("size"))
                          }
                          stop("size is read only")

                        },
                        weight = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("weight"))
                          }
                          stop("weight is read only")

                        },
                        max = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("max"))
                          }
                          stop("max is read only")

                        },
                        min = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("min"))
                          }
                          stop("min is read only")

                        },
                        sample = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("sample"))
                          }
                          stop("sample is read only")

                        },
                        width = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("width"))
                          }
                          stop("width is read only")

                        },
                        z = function(value) {
                          if (missing(value)) {
                            return(self$get_scales("z"))
                          }
                          stop("z is read only")

                        }
                      )
                     )

# Train scale from a data table
#' @export
scales_train_dt <- function(scales, dt, drop = FALSE) {
  if (is_empty(dt) || length(scales$scales) == 0) return()

  lapply(scales$scales, function(scale) scale$train(data=dt))
}



# Map values from a data.frame. Returns data.frame
#' @export
scales_map_dt <- function(scales, dt) {
  if (is_empty(dt) || length(scales$scales) == 0) return(dt)

  mapped <-lapply(scales$scales, function(scale) scale$scale_dt(data = dt))


  out=reduce(mapped,cbind)
  cbind(out,dt%nget%names(out))
}
#' @export
scales_map_grid <- function(scales, dt) {
  if (is_empty(dt) || length(scales$scales) == 0) return(dt)

  lapply(scales$scales, function(scale) scale$map_grid(data = dt))
  dt
}

# Transform values to cardinal representation
#' @export
scales_transform_dt <- function(scales, dt) {
  if (is_empty(dt) || length(scales$scales) == 0) return(dt)

  transformed <- lapply(scales$scales, function(s) s$transform(dt))

  out=reduce(transformed,cbind)
  cbind(out,dt%nget%names(out))
}
# Transform values to cardinal representation
#' @export
scales_train_transformers <- function(scales, dt) {
  if (is_empty(dt) || length(scales$scales) == 0) return()

  lapply(scales$scales, function(s) s$train_transformer(dt))
  return(invisible())
}
# @param aesthetics A list of aesthetic-variable mappings. The name of each
#   item is the aesthetic, and the value of each item is the variable in data.
scales_add_defaults <- function(scales, data, aesthetics, env) {
  if (is.null(aesthetics)) return()
  names(aesthetics) <- unlist(lapply(names(aesthetics), aes_to_scale))

  new_aesthetics <- setdiff(names(aesthetics), scales$input())
  # No new aesthetics, so no new scales to add
  if (is.null(new_aesthetics)) return()

  datacols <- lapply(aesthetics[new_aesthetics], eval_tidy, data = data)
  datacols <- compact(datacols)

  for (aes in names(datacols)) {
    scales$add(find_scale(aes, datacols[[aes]], env))
  }

}

# Add missing but required scales.
# @param aesthetics A character vector of aesthetics. Typically c("x", "y").
scales_add_missing <- function(plot, aesthetics, env) {

  # Keep only aesthetics that aren't already in plot$scales
  aesthetics <- setdiff(aesthetics, plot$scales$input())

  for (aes in aesthetics) {
    scale_name <- paste("scale", aes, "continuous", sep = "_")

    scale_f <- find_global(scale_name, env, mode = "function")
    plot$scales$add(scale_f())
  }
}

