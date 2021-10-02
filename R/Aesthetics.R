Aesthetics = R6Class(
  'Aesthetics',
  public = list(
    mapping_expr=NULL,
    data=NULL,
    by_expr=NULL,
    grid=expr(.()),
    initialize = function(data) {
    self$data=data
    },
    default_scale_type=function(aes){
      as<-self$mapping[[aes]]
      if(is.null(as))
         return(NULL)
      default_scale_type(d_expr(self$data,as))
    },
    get_bin_breaks=function(aes){
      as<-self$mapping[[aes]]

      attr(d_expr(self$data,as),'breaks')
    },
    vadilate_mappings=function(){
      mappings=unique(c(expr_find_names(self$mapping_expr),self$facet_names))
      data_names=names(self$data)%NIN%c('PANEL')
      assert_subset(mappings,data_names)
    }
  ),
  private=list(
  .y_aes=c(
    "y",
    "ymin",
    "ymax",
    "yend",
    "yintercept",
    "ymin_final",
    "ymax_final",
    "lower",
    "middle",
    "upper",
    "y0"
  ),
  .x_aes = c(
    "x",
    "xmin",
    "xmax",
    "xend",
    "xintercept",
    "xmin_final",
    "xmax_final",
    "xlower",
    "xmiddle",
    "xupper",
    "x0"
  ),
  .all_aesthetics = c(
    'area',
    "alpha",
    "angle",
    "color",
    "fill",
    "hjust",
    "vjust",
    "label",
    "linetype",
    "radius",
    "shape",
    "size",
    "weight",
    "lower",
    "max",
    "middle",
    "min",
    "sample",
    "upper",
    "width",
    "x",
    "xend",
    "xmax",
    "xmin",
    "group",
    "xintercept",
    "y",
    "yend",
    "ymax",
    "ymin",
    "yintercept",
    "z"
  )
),
active = list(
  all_x_aes = function(value) {
    if (missing(value)) {
        return(private$.x_aes)
    }
    stop("all_x_aes is read only")

},
  all_y_aes = function(value) {
    if (missing(value)) {
        return(private$.y_aes)
    }
    stop("all_y_aes is read only")

},
  all_aes = function(value) {
    if (missing(value)) {
        return(private$.all_aesthetics)
    }
    stop("all_aes is read only")

},
  raw_aes = function(value) {
    if (missing(value)) {
      aes_names<-assert_subset(names(expr_unlist(self$mapping_expr)),private$.all_aesthetics)
      return(aes_names)
    }
    stop("aes is read only")

  },
  y_aes= function(value) {
    if (missing(value)) {
      return(self$raw_aes%IN%private$.y_aes)
    }
    stop("y_aes is read only")

  },
  x_aes= function(value) {
    if (missing(value)) {
      return(self$raw_aes%IN%private$.x_aes)
    }
    stop("x_aes is read only")

  },
  non_position_aes = function(value) {
    if (missing(value)) {
        return(self$aes%NIN%c(self$y_aes,self$x_aes,'group'))
    }
    stop("non_position_aes is read only")

  },
  aes_list = function(value) {
    if (missing(value)) {
      x<-self$x_aes
      y<-self$y_aes
      other<-self$raw_aes%NIN%c(x,y)
      out<-as.list(other)
      names(out)<-other
      out$x=x%or%NULL
      out$y=y%or%NULL

        return(drop_nulls(out))
    }
    stop("aes_list is read only")
  },
  aes = function(value) {
    if (missing(value)) {
        return(names(self$aes_list))
    }
    stop("aes is read only")

},
  mapping = function(value) {
    if (missing(value)) {
        return(expr_unlist(self$mapping_expr))
    }
    stop("mapping is read only")

},
  x_mapping = function(value) {
    if (missing(value)) {

   return(unlist(self$mapping%get%self$x_aes))
    }
    stop("x_mapping is read only")

},
  y_mapping = function(value) {
  if (missing(value)) {

    return(unlist(self$mapping%get%self$y_aes))
  }
  stop("x_mapping is read only")

},
  has_x = function(value) {
    if (missing(value)) {
        return(nlen0(self$x_aes))
    }
    stop("has_x is read only")

},
  has_y = function(value) {
  if (missing(value)) {
    return(nlen0(self$y_aes))
  }
  stop("has_x is read only")

},
  group_aes = function(value) {
    if (missing(value)) {
      ds<-self$mapping
      ds<-ds%IN%self$by_group
      out=sapply(ds,function(x)default_scale_type(d_expr(self$data,x)))
      return( names(out[out%in%c("discrete",'binned')]))
    }
    stop("group_aes is read only")

},
  position_group_aes = function(value) {
    if (missing(value)) {
        return(self$group_aes%IN%c(self$all_x_aes,self$all_y_aes))
    }
    stop("position_group_aes is read only")

},
  group_vars = function(value) {
    if (missing(value)) {
      ds<-self$mapping
      names(ds)<-lapply(ds,expr_text)
      out=sapply(ds,function(x)default_scale_type(d_expr(self$data,x)))
        return(unique(names(out[out%in%c("discrete",'binned')])))
    }
    stop("group_aes is read only")

},
  by_group = function(value) {
    if (missing(value)) {
      if(is.null(self$by_expr)){
       tmp= parse_exprs(self$group_vars)
       names(tmp)=self$group_vars
        return(expr(.(!!!tmp)))
      }
      return(self$by_expr)
    }
    stop("by_group is read only")
},
  by_names = function(value) {
    if (missing(value)) {

        return(self$group_vars)
    }
    stop("by_names is read only")

},
  is_x_identity = function(value) {
  if (missing(value)) {
     if(self$has_x){
       return(!is(d_expr(self$data,self$x_mapping[[1]]),'numeric'))
     }
     return(TRUE)
  }
  stop("flipped_axis is read only")

},
  flipped_aes = function(value) {
    if (missing(value)) {
        return(self$is_x_identity)
    }
    stop("flipped_aes is read only")

},
  grid_vars = function(value) {
    if (missing(value)) {
        return(expr_find_names(self$grid)%or%character(0))
    }
    stop("grid_vars is read only")

}
)
)
#' @export
x_aes=function(){
  tmp=Aesthetics$new(data=NULL)
  tmp$all_x_aes
}
#' @export
y_aes=function(){
  tmp=Aesthetics$new(data=NULL)
  tmp$all_y_aes
}
#' @export
all_aes=function(){
  tmp=Aesthetics$new(data=NULL)
  tmp$all_aes
}
#' @export
position_aes=function(){
  tmp=Aesthetics$new(data=NULL)
  tmp$all_aes%NIN%tmp$non_position_aes
}
#' @export
non_position_aes=function(){
  tmp=Aesthetics$new(data=NULL)
  tmp$non_position_aes
}
#' @export
d_expr=function(data,x){
  expr_eval(data[,!!x])
}
