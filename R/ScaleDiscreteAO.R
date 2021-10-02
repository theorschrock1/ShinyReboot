#' @export
ScaleDiscreteAO = R6::R6Class(
  'ScaleDiscreteAO',
  inherit = ScaleAO,
  public = list(
    initialize = function(trans=discrete_trans(),range=NULL,oob=censor,na.value=NA,...) {
      self$super_init(na.value=na.value,oob=oob,...)
      private$.range=range%or%CRange$new()
      private$.trans=trans
      private$.trans$name=self$coord
      private$.trans$range=DRange$new()
      #self$train()
    },
    super_init=import_fn(super_init),
    train = function(data,aes=self$aes) {
      aes=aes%IN%names(data)
      data[ ,lapply(.SD,function(x) self$range$train(x)),.SDcols=aes]
      return(invisible(self))
    },
    transform = function(data,aes=self$aes) {
      aes=aes%IN%names(data)
      data[ ,lapply(.SD,function(x) self$trans$transform(x)),.SDcols=aes]

    },
    reset = function() {
      self$range$reset()

    },
    reset_trans=function(){
      self$trans$reset()
    },
    train_transformer=function(data,aes=self$aes){
      aes=aes%IN%names(data)
      data[ ,lapply(.SD,function(x) self$trans$train(x)),.SDcols=aes]
      return(invisible(self))
    },
    get_domain=function(){
      self$domain
    },
    get_range=function(){
     as.numeric( self$range$range)
    },
    scale = function( x, domain = self$get_domain(), range = self$get_range())   {
      rescale(as.numeric(x),to=domain,from=range)
    },
    scale_dt=function(data,aes=self$aes){
      aes=aes%IN%names(data)
      range =self$get_range()
      domain =self$get_domain()
      scale=self$scale
      data= data[ ,lapply(.SD,function(x)scale(x,domain=domain,range=range)),.SDcols=aes]


    },
    rescale_by_grid=function(data,aes=self$aes,domain=self$domain){
      aes = aes %IN% names(data)
      grid = paste0(self$coord, 'grid')
      data[, c(self$aes) := lapply(.SD, function(x)
        self$scale(as.numeric(x), domain = domain, range = range(.SD))), .SDcols =
          aes, by = grid]
    },
    get_limits=function(){
      self$trans$limits
    },
    graph_limits=function(){
      self$get_limits()
    },
    get_breaks = function(limits = self$get_limits()) {

      breaks=self$trans$breaks(self$get_limits())
      if(self$coord=='y')
        breaks=breaks[rev(order(breaks))]
      breaks
    },
    grid_breaks = function() {
      self$trans$transform_grid_area(self$trans$range)
    },
    grid_break_positions = function(breaks = self$grid_breaks()) {
      paste(paste0(breaks,'-start'),"/",paste0(breaks,'-end'))
    },
    get_grid_template=function(){
      self$trans$get_grid_template()
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
    map_grid = function(data,aes=self$aes ) {
      aes=(aes%IN%names(data))[1]
      areas= self$grid_break_positions( self$trans$transform_grid_area(data[[aes]]))
      data[,c(paste0(self$coord,'grid')):=areas]
      data
    },
    map = function( x, limits = self$get_limits()) {
      scaled <-  self$scale(x,range=limits)
      ifelse(!is.na(scaled), scaled, self$na.value)
    },
    break_positions = function(range = self$get_limits()) {
      self$map(self$get_breaks(range))
    },
    dimension = function(expand =self$expansion(), limits = self$get_limits()) {
      expand_range()
    },
    expansion=function( mul = .25, add = 0, zero_width = 1){
      list( mul = null, add = add, zero_width = zero_width)
    },
    get_labels = function(breaks = self$get_breaks()) {
      if (is.null(breaks)) {
        return(NULL)
      }

      labels<- self$trans$inverse(breaks)
     if(self$coord=='y')
        labels<- rev(labels)
     labels[!is.na(labels)]
    },
    break_info = function(limits = self$get_limits()) {
      if (self$is_empty) {
        return(numeric())
      }

      # Limits in transformed space need to be converted back to data space
      limits <- self$trans$inverse(limits)



      if (zero_range(as.numeric(limits))) {
        breaks <- limits[1]
      } else {
        break_info<-trans_responsive_breaks(limits,trans=self$trans)

        break_info[,breaks:=self$trans$transform(lab)]
        return(break_info)
      }
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
      paste0(self$coord,"-axis axis-discrete")
    }
  ),
  private = list(
    .coord=NULL,
    .domain=c(0,100),
    .init=FALSE,
    .use_zero_range=TRUE,
    .trans=NULL
  ),
  active = list(
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

    },
    is_discrete = function(value) {
    if (missing(value)) {
        return(self$trans$is_discrete)
    }
    stop("is_discrete is read only")

}
  )
)
#' @export
scale_discrete_x=function(aes,trans=discrete_trans(),range=NULL,...){
  ScaleDiscreteAO$new(coord='x',aes=aes,trans=trans,range=range,...)
}
#' @export
scale_discrete_y=function(data,aes,trans=discrete_trans(),range=NULL,...){
  ScaleDiscreteAO$new(coord='y',aes=aes,trans=trans,range=range,...)
}

