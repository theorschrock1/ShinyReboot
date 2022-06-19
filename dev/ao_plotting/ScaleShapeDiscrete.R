#' @export
ScaleShapeDiscrete = R6::R6Class(
  'ScaleShapeDiscrete',
  inherit=ScaleOrdinal,
  public = list(
    default_palettes=list(basic_shapes8=8,basic_outline12=12),
    initialize = function(...) {
      self$super_init(...)
    },
    super_init=import_fn(super_init),
    get_domain=function(pal=self$get_palette()){
      if(nnull(self$manual_domain))
        return(self$manual_domain)
      palpath<-self$palettes[pal]$path
      get_shape_palette(palpath)[1:max(self$get_limits())]
    }
  ),
  private = list(.init=FALSE),
  active = list(
    palettes = function(value) {
      if (missing(value)) {
        out<-get_shape_palette_dt()
        setkey(out,palette)
        return(out)
      }
      stop("palettes is read only")

    }
  )
)
#' @export
scale_shape_discrete=function(aes,trans=discrete_trans(),range=NULL,...){
  ScaleShapeDiscrete$new(coord='z',aes=aes,trans=trans,range=range,...)
}
