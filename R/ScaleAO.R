ScaleAO = R6Class(
  'ScaleAO',
  public = list(
    position = "left",

    aes=NULL,
    oob=NULL,
    na.value=NULL,
    initialize = function(aes,coord='x',oob=censor,na.value=NA,breaks=NULL) {
    self$aes=aes
    self$coord=coord
    self$oob=oob
    self$na.value= na.value
    },
    train = function(x) {
      abort("Not implemented")
    },
    reset = function() {
      self$range$reset()
    },
    transform = function( x) {
      abort("Not implemented")
    },

    scale = function( x, limits = self$get_limits(), range = self$dimensions()) {
      abort("Not implemented")
    },
    get_breaks = function( limits = self$get_limits()) {
      abort("Not implemented")
    },
    break_positions = function(range = self$get_limits()) {
      self$map(self$get_breaks(range))
    },
    grid_breaks = function(range = self$get_limits()) {
      abort("Not implemented")
    },
    grid_break_positions = function(grid_breaks = self$grid_breaks()) {
      paste(paste0(grid_breaks,'-start'),"/",paste0(grid_breaks,'-end'))
    },
    grid_limits = function() {
      c(paste0(self$coord,'-start'),paste0(self$coord,'-end'))
    },
    get_axis_template=function(){
      self$get_grid_template()
    },
    get_panel_template=function(){
      self$get_grid_template()
    },
    dimension = function() {
       self$graph_limits()
    },
    expansion=function(){

    },
    get_labels = function(breaks = self$get_breaks()) {
      abort("Not implemented")
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
    get_label_classes=function(){NULL},
    get_guide_info=function(){
     drop_nulls(list(
          coord=self$coord,
          is_discrete=self$is_discrete,
          labels=self$get_labels(),
          break_positions=self$break_positions(),
          grid_positions=self$grid_break_positions(),
          grid_limits=self$grid_limits(),
          grid_template=self$get_axis_template(),
          label_class=self$get_label_classes()
          ))

    }
  ),
  private = list(
    .coord=NULL,
    .domain=NULL,
    .range=NULL
  ),
  active = list(
    is_empty = function(value) {
    if (missing(value)) {
     return( is.null(self$range$range))
    }
    stop("is_empty is read only")
},
    domain= function(value) {
      if (missing(value)) {
        if(self$coord=='y')
          return(rev(private$.domain))
        return(private$.domain)
      }
      private$.domain<-value

    },
    is_discrete = function(value) {
      if (missing(value)) {
          return(    stop("is_discrete not impletemented"))
      }
      stop("is_discrete not impletemented")

},
    coord = function(value) {
      if (missing(value)) {
        return( private$.coord)
      }
      private$.coord<-
        assert_choice(value,c('x','y','z'))

    },
    range = function(value) {
      if (missing(value)) {
        return(private$.range)
      }
      stop("range is read only")

    },
    limits = function(value) {
    if (missing(value)) {
      abort("Not implemented")
    }
      abort("Not implemented")

}
  )
)
