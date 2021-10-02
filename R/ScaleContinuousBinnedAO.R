ScaleContinuousBinnedAO = R6Class(
  'ScaleContinuousBinnedAO',
  inherit=ScaleContinuousAO,
  public = list(
    bin_breaks=NULL,
    initialize = function(...,breaks) {
    self$super_init(...)
    self$bin_breaks=breaks
    },
    super_init=import_fn(super_init),
    map_grid = function(data,aes=self$coord) {

      limits<-self$grid_limits()
      binareas=self$get_bin_areas()
      domain=self$get_bin_grid_positions(  binareas)
      leftout=paste(limits[1], binareas[1])
      rightout=paste0(binareas[length(binareas)],'-end/',limits[2])
      breaks=self$get_bin_breaks()
     out= map_bin(data[[aes[1]]],breaks=breaks,domain =   domain, leftout, rightout)
      data[,c(paste0(aes,'grid')):=  out]
      data
    },
    get_bin_breaks=function(breaks=self$bin_breaks){
      self$bin_breaks
    },
    get_binned_template=function(breaks=self$get_bin_breaks(),limits=self$graph_limits()){

      bin_grid_template(breaks,lims=limits,name=self$coord,line_name = 'grp')
    },
    get_panel_template=function(){
      self$get_binned_template()
    },
    get_bin_areas=function(breaks=self$get_bin_breaks()){
      breaks=paste0(self$coord,'grp',1:(l(breaks)-1))
    },
    get_bin_grid_positions=function(breaks=self$get_bin_areas()){

      paste(paste0(breaks,'-start'),"/",paste0(breaks,'-end'))
    }
  ),
  private = list(.init=FALSE),
  active = list()
)


#' @export
scale_binned_x=function(aes,trans=identity_trans(),breaks,range=NULL,...){
  ScaleContinuousBinnedAO$new(coord='x',aes=aes,trans=trans,range=range,breaks=breaks,...)
}
#' @export
scale_binned_y=function(aes,trans=identity_trans(),breaks,range=NULL,...){
  ScaleContinuousBinnedAO$new(coord='y',aes=aes,trans=trans,range=range,breaks=breaks,...)
}

