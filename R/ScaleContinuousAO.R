#' @export
ScaleContinuousAO = R6::R6Class(
  'ScaleContinuousAO',
  inherit = ScaleAO,
  public = list(
    mul=0,
    add=0,
    zero_width=1,
    initialize = function(aes,trans=identity_trans(),range=NULL,oob=censor,na.value=NA_real_,...) {
      self$super_init(aes=aes,na.value=na.value,oob=oob,...)
      private$.range=range%or%CRange$new()
      private$.trans=trans
      #self$train()
    },
    super_init=import_fn(super_init),
    reset = function() {
      self$range$reset()
      private$.break_info=NULL
      private$.last_lims=NULL
    },
    train = function(data,aes=self$aes) {
      aes=aes%IN%names(data)
      data[ ,lapply(.SD,function(x) self$range$train(x)),.SDcols=aes]
      return(invisible(self))
    },
    transform = function(data,aes=self$aes) {
      aes=aes%IN%names(data)
      data<-data[ ,lapply(.SD,function(x) self$trans$transform(x)),.SDcols=aes]

    },
    train_transformer=function(x){
      return(invisible(NULL))
    },
    map_grid = function(data,aes=self$coord) {
      area=c(paste0(aes,'-start'), paste0(aes,'-end'))%sep%" / "
      data[,c(paste0(aes,'grid')):= area]
      data
    },
    get_grid_intercept=function(range=self$graph_limits()){
      if(min(range)<=0&max(range)>=0){
     out='zeroline-start'
      }else if(max(range)<0){
        out=   '-end'
      }else{
        out=   '-start'
      }
     self$coord%p%out
    },
    get_domain=function(){
      self$domain
    },
    get_range=function(){
      self$graph_limits()
    },
    scale = function( x, domain = self$get_domain(), range = self$get_range()) {
      rescale(as.numeric(x),to=domain,from=range)
    },
    scale_dt=function(data,aes=self$aes){
      aes=aes%IN%names(data)
      range = self$get_range()
      domain = self$get_domain()
      scale=self$scale
     data= data[ ,lapply(.SD,function(x) scale(x,domain=domain,range=range)),.SDcols=aes]
      data[,c(paste0(self$coord,'grid_intercept')):=self$get_grid_intercept()]
    },
    get_limits=function(mul=self$mul,add=self$add,zero_width=self$zero_width,use_zero_range=self$use_zero_range){
      if(self$use_zero_range){
        range=self$range$range
      }else{
        range=range(c(0,self$range$range ))
      }
      expand_range(
        range = range,
        mul=mul,
        add=add,
        zero_width= zero_width
      )
    },
    get_breaks = function(limits = self$get_limits()) {
      tmp=self$break_info(limits = limits)
      breaks<-self$break_info(limits = limits)$breaks

      breaks
    },
    get_breaks_minor = function(n = 2, b = self$break_positions(), limits = self$get_limits()) {
      if (zero_range(as.numeric(limits))) {
        return()
      }




        if (is.null(b)) {
          breaks <- NULL
        } else {
          b <- self$trans$minor_breaks(b, limits, n)
        }


      # Any minor breaks outside the dimensions need to be thrown away
      discard(breaks, limits)
    },
    zero_range = function(value) {
      if (missing(value)) {
        return(range(c(0,self$range)))
      }
      stop("zero_range is read only")

    },
    axis_range = function(value) {
      if (missing(value)) {
        return(range(self$break_info$labs))
      }
      stop("axis_range is read only")

    },
    axis_breaks = function(value) {
      if (missing(value)) {
        return(range(self$break_info$labs))
      }
      stop("axis_breaks is read only")

    },
    get_grid_template=function(breaks=self$get_breaks(),limits=self$graph_limits()){
      continuous_grid_template(breaks,lims=limits,line_size=0,grid_name=self$coord,line_name = 'line')
    },
    map = function( x, limits = self$graph_limits()) {
      scaled <- self$scale(self$oob(x, limits))
      ifelse(!is.na(scaled), scaled, self$na.value)
    },
    break_positions = function(range = self$get_limits()) {
      self$map(self$get_breaks(range))
    },
    grid_breaks = function(range = self$get_limits()) {


      continuous_grid_areas(self$get_breaks(range),grid_name=self$coord,line_name = 'line')

    },
    grid_break_positions = function(breaks = self$grid_breaks()) {
     paste(paste0(breaks,'-start'),"/",paste0(breaks,'-end'))
    },
    graph_limits = function(breaks= self$get_breaks(), limits = self$get_limits()) {
      grange<-range(c(breaks,limits))
      mrange=min(grange)

    erange<- expand_range(grange, mul = self$mul)
    # if (mrange == 0)
    #   return(c(0, max(erange)))
    erange
    },
    expansion=function( mul = .25, add = 0, zero_width = 1){
     list( mul = null, add = add, zero_width = zero_width)
    },
    get_labels = function(breaks = self$get_breaks()) {
      if (is.null(breaks)) {
        return(NULL)
      }

      breaks <- self$trans$inverse(breaks)

      labels <- self$labels(x=breaks)


      if (length(labels) != length(breaks)) {
        abort("Breaks and labels are different lengths")
      }


      labels
    },
    break_info = function(limits = self$get_limits()) {

      tic('scales continuous: break info')
      if(!is.null(private$.last_lims)&&limits==private$.last_lims){      toc(log=TRUE,quiet=TRUE)
        return(private$.break_info)
      }
      if (self$is_empty) {
        return(numeric())
      }

      limits <- self$trans$inverse(limits)



      if (zero_range(as.numeric(limits))) {
        breaks <- limits[1]
      } else {

        break_info<-trans_responsive_breaks(limits,trans=self$trans)

        break_info[,breaks:=self$trans$transform(lab)]
        if(self$coord=='y')
          setorder(break_info,-breaks)

        private$.last_lims=limits
        private$.break_info=break_info
        toc(log=TRUE,quiet=TRUE)
        return(break_info)

      }
    },
    labels=function(x,big.mark=",",...){
      digits<-0
      suffix<-""
      scale<-1


     pv<- n_precision(x)
     if(l(pv%IN%-3)>1){
        scale<-.001
        suffix<-"K"
      }

      if(l(pv%IN%-6)>1){
        scale<-.000001
        suffix<-"M"
      }

      x=x*scale

      round(x,max(n_precision(x)))
      out=comma_format()(x)
      x<-format(x,big.mark = ',')
      out<-str_remove(x,"\\.0+$")

      out[out!="0"]<-paste0(out[out!="0"],suffix)
      out

    },
    axis_order = function(self) {
      ord <- c("primary", "secondary")
      if (self$position %in% c("right", "bottom")) {
        ord <- rev(ord)
      }
      ord
    },
    make_title = function(title) {
      title
    },
    make_sec_title = function(title) {
      title
    },
    get_label_classes=function(){
     paste(paste0(self$coord,"-axis axis-continuous"),self$break_info()$class)
    }
  ),
  private = list(
    .coord=NULL,
    .domain=c(0,100),
    .init=FALSE,
    .use_zero_range=TRUE,
    .default_formatter=NULL,
    .trans=NULL,
    .last_lims=NULL,
    .break_info=NULL
  ),
  active = list(
    is_discrete = function(value) {
      if (missing(value)) {
        return(FALSE)
      }
      stop("is_discrete is read_only")

    },
    limits = function(value) {
      if (missing(value)) {
       self$tranform(self$range$range)
      }
     stop('limits is read only')

    },
    use_zero_range = function(value) {
      if (missing(value)) {
        return(private$.use_zero_range)
      }
      private$.use_zero_range=assert_logical(value)

    },
    trans = function(value) {
    if (missing(value)) {
        return( private$.trans)
    }
    stop("trans is read only")

}
  )
)

#' @export
scale_continuous_x=function(aes,trans=identity_trans(),range=NULL,...){
  ScaleContinuousAO$new(coord='x',aes=aes,trans=trans,range=range,...)
}
#' @export
scale_continuous_y=function(aes,trans=identity_trans(),range=NULL,...){
  ScaleContinuousAO$new(coord='y',aes=aes,trans=trans,range=range,...)
}
