#' @export
GridPanel = R6::R6Class(
  'GridPanel',
  public = list(
    initialize = function() {

    },
    render_panel=function(...){

      div(id=self$id,class=self$class,style=grid_css(grid.area=self$grid_area,rows=self$template_rows,cols=self$template_cols)) %>% tagAppendChildren(self$content) %>% tagAppendAttributes(...)
    },
    append_content=function(...){
      content=self$prv$.content
      append( content)<-.(...)
      self$prv$.content=content
    },
    clear_content=function(){
      self$prv$content=list()
    },
    set_grid_template=function(area,rows,cols,gap){
      self$template_rows=rows
      self$template_cols=cols
      self$grid_area =area
      self$grid_gap=gap
    }
  ),
  private = list(
    .grid_area=NULL,
    .template_rows=NULL,
    .template_cols=NULL,
    .class='grid-panel',
    .id=NULL,
    .content=NULL,
    .grid_gap=NULL
  ),
  active = list(
    content = function(value) {
    if (missing(value)) {
        return(HTML(unlist(self$prv$.content)))
    }
    stop("content is read only")

},
    grid_area = function(value) {
      if (missing(value)) {
        return(private$.grid_area)
      }
      private$.grid_area=assert_string(value)

    },
    grid_gap = function(value) {
      if (missing(value)) {
        if(is.null(private$.grid_gap))
          return()
        out=rep(0,2)
        if(self$is_y_discrete)
          out[1]<-private$.grid_gap
        if(self$is_x_discrete)
          out[2]<-private$.grid_gap
        return(out)
      }
      private$.grid_gap=assert_character(value,null.ok=TRUE)

    },
    template_rows = function(value) {
      if (missing(value)) {
        return(private$.template_rows)
      }
      private$.template_rows=assert_string(value)

    },
    template_cols = function(value) {
    if (missing(value)) {
        return(private$.template_cols)
    }
      private$.template_cols=assert_string(value)

    },
    is_x_discrete = function(value) {
      if (missing(value)) {
          return(grepl('xgrp',self$template_cols))
      }
      stop("is_x_discrete is read only")

    },
    is_y_discrete = function(value) {
      if (missing(value)) {
        return(grepl('ygrp',self$template_rows))
      }
      stop("is_y_discrete is read only")

    },
    id = function(value) {
    if (missing(value)) {
        return(private$.id)
    }
    private$.id=assert_string(value)

},
    class = function(value) {
    if (missing(value)) {
        return(private$.class)
    }

      private$.class=assert_string(value)
},
    prv = function(value) {
      if (missing(value)) {
        return(private)
      }
      private<-value

    }
  )
)

#' @export
new_grid_panel=function(){
  GridPanel$new()
}
