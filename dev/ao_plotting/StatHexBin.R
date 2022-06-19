

StatHexBin = R6Class(
  'StatHexBin',
  inherit=AoStat,
  public = list(
    initialize= function(aes=.D(x=,y=,fill=stat(count),weight=1),
                         bins = NULL,
                         binwidth = NULL,
                         na.rm =TRUE,...
                           ){
      self$super_init(aes=aes)
      self$params=list(...,bins=bins,binwidth=binwidth,na.rm=na.rm)

    },
    super_init=import_fn(super_init),
    setup_params=function(data,params){
      params$bins<-params$bins%or%30
      params$binwidth= params$binwidth%or%hex_binwidth(bins=params$bins,x_range = range(data$x),y_range=range(data$y))
      params
    },
    compute_group=function(data,scales,binwidth = NULL, bins = 30,
                           na.rm = FALSE){

      data[,hexBin(x=x,y=y,wt=weight,binwidth = binwidth)]
    },
    finish_layer = function(data, params) {
      data[,binid:=1L:nrow(data)]
    }

  ),
  private = list(.init=FALSE),
  active = list()
)
#' @export
stat_hexbin=function(bins = NULL,
           binwidth = NULL,
           na.rm =TRUE,...){
  StatHexBin$new(bins=bins,binwidth=binwidth,na.rm =TRUE,...)
}
#
#


