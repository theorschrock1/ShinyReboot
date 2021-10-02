#' @export
  Transformer = R6Class(
  'Transformer',
  public = list(
    break_name=NULL,
    name=NULL,
    initialize = function(formatter,break_name=NULL,name=NULL) {
    private$.formatter<-assert_function(formatter)
    self$break_name=assert_string(break_name,null.ok = TRUE)%or%'grp'
    self$name=assert_string(name,null.ok = TRUE)
    },
    transform=function(x){
      abort('method not implemented')
    },
    breaks=function(x){
      abort('method not implemented')
    },
    minor_break=function(x){
      abort('method not implemented')
    },
    inverse=function(x){
      abort("method not implemented")
    },
    transform_grid_area=function(x){
      grid_areas<-paste0(self$grid_name,1:length(self$range))

      chr_approx(self$range,grid_areas)(x)
    },
    inverse_grid_area=function(x){
      chr_approx(self$transform_grid_area(self$range),self$range)(x)
    },
    formatter=function(x){
      abort("method not implemented")
    },
    get_grid_template=function(x){
      abort("method not implemented")
    },
    transform_grid_areas=function(x){
      abort("method not implemented")
    }
  ),
  private = list(
  .formatter=NULL
  ),
  active = list(
    grid_name = function(value) {
      if (missing(value)) {
        return(paste0( self$name,self$break_name))
      }
      stop("grid_name is read only")

    },
    limits = function(value) {
      if (missing(value)) {
        abort("method not implemented")
      }
      abort("method not implemented")

    }
  )
)

#' @export
PointTransformer = R6Class(
  'PointTransformer',
  inherit=Transformer,
  public = list(
    initialize = function(range=NULL,formatter=function(x)x,...) {
    self$super_init(formatter=formatter,...)
    self$range=range
    },
    super_init=import_fn(super_init),
    transform=function(x){
      chr_approx(self$range,1:length(self$range))(x)
    },
    inverse=function(x){
      chr_approx(1:length(self$range),self$range)(x)
    },
    breaks=function(range=self$limits){
     assert_numeric(range,len=2)
     seq(min(range),max(range),length.out=length(self$range))
    },

    get_grid_template=function(limits=self$limits,line_size=0,...){
      continuous_grid_template(self$transform(self$range),lims=limits,line_size=line_size,grid_name=self$name,line_name = self$break_name)
    }
  ),
  private = list(
    .init=FALSE,
    .range=NULL),
  active = list(
    is_discrete = function(value) {
      if (missing(value)) {
        return(FALSE)
      }
      stop("is_discrete is read_only")

    },
    range = function(value) {
      if (missing(value)) {
        return(private$.range$range)
      }
      private$.range=assert_class(value,'DRange')

    },
    limits = function(value) {
    if (missing(value)) {
        return(range(self$transform(self$range)))
    }
    stop("limits is read only")

}
  )
)
#' @export
point_trans=function(range=NULL){
  PointTransformer$new(range=range)
}
#' @export
BandTransformer = R6Class(
  'BandTransformer',
  inherit=Transformer,
  public = list(
    initialize = function(range=NULL,formatter=function(x)x,...) {
      self$super_init(formatter=formatter,...)
      self$range=range

    },
    super_init=import_fn(super_init),
    transform=function(x){
      twts<-cumsum(self$weights)
      wts=c(0,twts[1:l(twts)-1])
      chr_approx(self$range,wts)(x)
    },
    transform_bandwidth=function(x){
      chr_approx(self$range,self$weights)(x)
    },
    inverse=function(x){
      self$transform(self$range)
      chr_approx(self$transform(self$range),self$range)(x)
    },
    breaks=function(range=self$limits){
      c(0,cumsum(self$weights))
    },
    get_grid_template=function(){
      discrete_grid_template(self$transform_grid_area(self$range),sizes=self$weights,name=self$name)
    }
  ),
  private = list(
    .init=FALSE,
    .range=NULL),
  active = list(
    range = function(value) {
      if (missing(value)) {
        return(private$.range$range)
      }
      if(nnull(value))
        private$.range=assert_class(value,'DRange')

    },
    weights = function(value) {
    if (missing(value)) {
        return( get_weights(self$range))
    }
    stop("weights is read only")

},
    limits = function(value) {
      if (missing(value)) {
        return(c(0,sum(self$weights)))
      }
      stop("limits is read only")

    },
    is_discrete = function(value) {
      if (missing(value)) {
        return(TRUE)
      }
      stop("is_discrete is read_only")

    }

  )
)

#' @export
DiscreteTransformer = R6Class(
  'DiscreteTransformer',
  inherit=Transformer,
  public = list(
    initialize = function(range=NULL,formatter=function(x)x,...) {
      self$super_init(formatter=formatter,...)
      self$range=range

    },
    super_init=import_fn(super_init),
    transform=function(x){
     out<- chr_approx(self$range,1:length(self$range))(x)
     class(out)<-c("identity",class(out))
     out
    },
    inverse=function(x){
      chr_approx(1:length(self$range),self$range)(x)
    },
    train=function(x){
      private$.range$train(x)
    },
    reset=function(){
      private$.range$reset()
    },
    breaks=function(range=self$limits){
      assert_numeric(range,len=2)
      seq(min(range),max(range),length.out=length(self$range))
    },
    get_grid_template=function(){
      discrete_grid_template(self$transform_grid_area(self$range),sizes=get_weights(self$range),name=self$name)
    }
  ),
  private = list(
    .init=FALSE,
    .range=NULL),
  active = list(
    range = function(value) {
      if (missing(value)) {
        return(private$.range$range)
      }
      if(nnull(value))
      private$.range=assert_class(value,'DRange')

    },
    limits = function(value) {
      if (missing(value)) {
        return(range(self$transform(self$range)))
      }
      stop("limits is read only")

    },
    is_discrete = function(value) {
      if (missing(value)) {
        return(TRUE)
      }
      stop("is_discrete is read_only")

    }

  )
)

#' @export
discrete_trans=function(range=NULL){
  DiscreteTransformer$new(range=range)
}

#' @export
band_trans=function(range=NULL){
  BandTransformer$new(range=range)
}
#' @export
new_Discrete <- function(x = character(),weights=1) {
  stopifnot(is.character(x))
  stopifnot(is.numeric(weights))
  if(length(weights)==1)
    weights=rep(weights,length(x))
  if(length(weights)!=length(x))
    stop("Weight must be length 1 or length(x)")
  structure(x, class = "Discrete",weights=weights)
}
#' @export
get_weights=function(x){
  assert_class(x,"Discrete")
  attr(x,'weights')
}



new_Binned <- function(x = character(),weights=1) {
  stopifnot(is.character(x))
  stopifnot(is.numeric(weights))
  if(length(weights)==1)
    weights=rep(weights,length(x))
  if(length(weights)!=length(x))
    stop("Weight must be length 1 or length(x)")
  structure(x, class = "Discrete",weights=weights)
}
