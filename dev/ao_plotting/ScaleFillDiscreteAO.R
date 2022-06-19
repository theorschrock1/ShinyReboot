#' @export
ScaleFillDiscreteAO = R6::R6Class(
  'ScaleFillDiscreteAO',
  inherit=ScaleOrdinal,
  public = list(
    default_palettes=list(Tableau_10=10,Tableau_20=20),
    initialize = function(...) {
    self$super_init(...)
    },
    super_init=import_fn(super_init),
    get_domain=function(pal=self$get_palette()){
      if(nnull(self$manual_domain))
        return(self$manual_domain)
      palpath<-self$palettes[pal]$path
      as.character(paletteer_d(palpath))
    },
    get_range=function(){
      self$get_labels()
    },
    scale = function( x, domain =   self$get_domain(), range =self$get_range() )   {
        range=as.numeric(self$trans$transform(range))

          if(l(range)>l(domain)){
          return(map_color_continuous(x,domain=domain))
          }

       map_ordinal(x,domain=domain,range=range)


    }
  ),
  private = list(.init=FALSE),
  active = list(
    palettes = function(value) {
    if (missing(value)) {
      palnames = as.data.table(paletteer::palettes_d_names)
      pt = palnames[palnames$package %in% "ggthemes" &type%in%c('qualitative','sequential'), ]
      pt2=palnames[length>20&type%in%c('qualitative'), ]
      setkey(pt2,length)
      pt2=unique(pt2,by=key(pt2))
      out=rbindlist(list(pt,pt2))
      out[,path:=paste0(package, "::",palette)]
      setkey(out,palette)
        return(out)
    }
    stop("palettes is read only")

}
  )
)
#' @export
scale_discrete_fill=function(aes,trans=discrete_trans(),range=NULL,...){
  ScaleFillDiscreteAO$new(coord='z',aes=aes,trans=trans,range=range,...)
}
scale_discrete_color=function(aes,trans=discrete_trans(),range=NULL,...){
  ScaleFillDiscreteAO$new(coord='z',aes=aes,trans=trans,range=range,...)
}
