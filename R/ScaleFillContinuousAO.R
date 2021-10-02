#' @export
ScaleFillContinuousAO <-R6::R6Class(
  'ScaleFillContinuousAO',
  inherit=ScaleContinuousAO,
  public = list(
    default_palettes='Blues',
    initialize = function(...) {
      self$super_init(...)
    },
    super_init=import_fn(super_init),
    get_palette=function(pal=self$palette){
      if(is.null(self$palette)){
        pal=self$default_palettes
      }
      pal
    },
    get_trans_range=function(){
      scale$trans$transform(scale$trans$range)
    },
    get_colors=function(pal=self$get_palette()){
      if(nnull(self$manual_colors))
        return(self$manual_colors)
      palpath<-self$palettes[pal]$path
      as.character(paletteer_c(palpath,n=10,self$pal_direction))
    },
    reset_color_mapping=function(){
      self$manual_colors=NULL
    },
    set_color_mapping=function(colors,break_points=NULL){
      self$manual_colors=colors
      self$break_points=break_points
    },
    get_domain=function(){
      self$get_colors()
    },
    get_range=function(){
      self$break_points
    },
    scale = function( x, domain =   self$get_domain(),range= self$get_range() )   {

        return(map_color_continuous(x,range=range,domain=domain))
    }
  ),
  private = list(.init=FALSE,
                 .palette=NULL,
                 .manual_colors=NULL,
                 .break_points=NULL,
                 .reverse_pal=FALSE),
  active = list(
    break_points = function(value) {
    if (missing(value)) {
        return(private$.break_points%or%c(0,.5,1))
    }
      private$.break_points= assert_numeric(value,lower=0,upper=1,min.len = 2,null.ok = TRUE)

},
    manual_colors = function(value) {
      if (missing(value)) {
        return()
      }
      private$.manual_colors<-assert_character(value,null.ok = TRUE)

    },
    palettes = function(value) {
  if (missing(value)) {
    palnames = as.data.table(paletteer::palettes_c_names)
    out = palnames[palnames$package %in%c("grDevices",'viridis' ), ]
    out[,path:=paste0(package, "::",palette)]
    setkey(out,palette)
    return(out)
  }
  stop("palettes is read only")

},
    palette = function(value) {
      if (missing(value)) {
        return(private$.palette)
      }
      private$.palette<-
        assert_choice(value,self$palettes$palette)

    },
    pal_direction = function(value) {
    if (missing(value)) {
      if(self$reverse_pal)
        return(1L)
      return(-1L)
    }
    stop("pal_direction is read only")

},
    reverse_pal = function(value) {
    if (missing(value)) {
        return(private$.reverse_pal)
    }
      private$.reverse_pal=assert_logical(value,len=1)

}
  )
)
#' @export
scale_continuous_fill=function(aes,trans=identity_trans(),range=NULL,...){
 ScaleFillContinuousAO$new(coord='z',aes=aes,trans=trans,range=range,...)
}
scale_continuous_color=function(aes,trans=identity_trans(),range=NULL,...){
  ScaleFillContinuousAO$new(coord='z',aes=aes,trans=trans,range=range,...)
}
