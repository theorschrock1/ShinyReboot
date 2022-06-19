#' @export
Guide = R6::R6Class(
  'Guide',
  public = list(
    guide_info=NULL,
    label_size='auto',
    label_name='axislabel',
    initialize = function(guide_info) {
    self$guide_info=guide_info
    },
    render_guide=function(grid_areas,...){
      lapply(grid_areas,function(x){

      div(HTML(self$draw_axis_marks())) %>%
          tagAppendAttributes(style=self$grid_css(x),class=self$axis_class,...)

      })
    },
    draw_axis_marks=function(){
      c(self$draw_labels(),
        self$draw_ticks())%sep%''
    },
    draw_labels=function(){
      glue('<div class="axis-label {self$label_class}" style="{self$label_css}">{self$labels}</div>')
    },
    draw_axis_lines=function(){NULL},
    draw_ticks=function(){''},
    grid_css = function(area) {
        return(grid_css(rows=self$grid_rows,cols=self$grid_cols,grid.area=area))
    }
  ),
  private = list(
  .position=NULL
  ),
  active = list(
    axis_class = function(value) {
      if (missing(value)) {
        glue('axis {self$coord}-axis axis-{self$scale_type}')
        return(glue('{self$coord}-axis axis-{self$scale_type}'))
      }
      stop("axis_class is read only")

    },
    scale_type = function(value) {
    if (missing(value)) {
        return(abort('not implemented'))
    }
    stop("scale_type is read only")

},
    label_class = function(value) {
    if (missing(value)) {
        return(self$guide_info$label_class)
    }
    stop("axis_class is read only")

},
    labels = function(value) {
    if (missing(value)) {
        return(self$guide_info$labels)
    }
    stop("labels is read only")

    },
    label_css = function(value) {
    if (missing(value)) {
      if(self$coord%in%c('y','z'))
        return(item_css(row=self$grid_positions,col=self$label_area))
      return(item_css(col=self$grid_positions,row=self$label_area))
    }
    stop("label_areas is read only")

},
    line_css = function(value) {
      if (missing(value)) {
        if(self$coord%in%c('y','z'))
          return(item_css(row=self$grid_positions,col=self$line_area))
        return(item_css(col=self$grid_positions,row=self$line_area))
       }
     stop("line_css is read only")
    },
    break_positions = function(value) {
    if (missing(value)) {
        return(self$guide_info$break_positions)
    }
    stop("break_positions is read only")

},
    grid_positions = function(value) {
    if (missing(value)) {
        return(self$guide_info$grid_positions)
    }
    stop("grid_positions is read only")

},
    grid_limits = function(value) {
    if (missing(value)) {
        return(self$guide_info$grid_limits)
    }
    stop("grid_limits is read only")

},
    grid_template = function(value) {
    if (missing(value)) {
        return(self$guide_info$grid_template)
    }
    stop("grid_template is read only")

},
    grid_rows = function(value) {
    if (missing(value)) {
        if(self$coord%in%c('y','z'))
         return(self$guide_info$grid_template)
        return(self$axis_template)
    }
    stop("grid_rows is read only")

    },
    axis_template = function(value) {
    if (missing(value)) {
        return(abort('not impletement'))
    }
    stop("axis_template is read only")

},
    grid_cols = function(value) {
    if (missing(value)) {
      if(self$coord%in%c('x'))
        return(self$guide_info$grid_template)
      return(self$axis_template)
    }
    stop("grid_cols is read only")

},
    raw_labels = function(value) {
    if (missing(value)) {
        return(self$guide_info$raw_labels)
    }
    stop("raw_labels is read only")

},
    coord = function(value) {
    if (missing(value)) {
        return(self$guide_info$coord)
    }
    stop("coord is read only")

    },
    is_discrete = function(value) {
      if (missing(value)) {
        return(self$guide_info$is_discrete)
      }
      stop("is_discrete is read only")

    },
    position = function(value) {
      if(missing(value)){
        if(is.null(private$.position))
          self$position<-NULL
        return(private$.position)
      }
      if(self$coord=='y'){
        assert_choice(value,c('left','right'),null.ok = TRUE)
        private$.position=value%or%'left'
      }
      if(self$coord=='x'){
        assert_choice(value,c('top','bottom'),null.ok = TRUE)
        private$.position=value%or%'bottom'
      }
      if(self$coord=='z')
        private$.position=value%or%'z'

    },
    label_area = function(value) {
    if (missing(value)) {
        return(glue("{self$label_name}-start/{self$label_name}-end"))
    }
    stop("label_area is read only")

},
    line_area = function(value) {
  if (missing(value)) {
    opp='x'
    if(self$coord=='x')
      opp='y'
    str_replace(self$grid_limits,self$coord,opp)%sep%"/"
    return(glue("{self$label_name}-start/{self$label_name}-end"))
  }
  stop("label_area is read only")

}
  )
)
#' @export
ContinuousGuide = R6::R6Class(
  'continuousGuide',
  inherit=Guide,
  public = list(
    tick_size='0',
    tick_name='axistick',
    initialize = function(...) {
    self$super_init(...)
    },
    super_init=import_fn(super_init),
    draw_ticks=function(){
      glue('<div class="axis-tick {self$label_class}" style="{self$tick_css}"></div>')
    },
    draw_axis_lines=function(){
      glue('<div class="axis-line {self$label_class}" style="{self$line_css}"></div>')
    },
    formtat_labels=function(x,big.mark=",",neg_paren=self$label_neg_paren,scale=self$label_scale,suffix=self$label_suffix,prefix=self$label_prefix,...){


      if(is.null(scale)&is.null(prefix)){
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
      }
      x=x*scale
      neg<-x<0

      x<-format(x,big.mark = big.mark)
      out<-paste(prefix,str_remove(x,"\\.0+$"))

      if(self$label_neg_paren){
        out[neg]<-paste0("(",str_remove(out[neg],"-"))
      }

      out[out!="0"]<-paste0(out[out!="0"],suffix)
      if(self$label_neg_paren){
        out[neg]<-paste0(out[neg],")")
        }
      out

    }
  ),
  private = list(.init=FALSE,
                 .label_prefix=NULL,
                 .label_suffix=NULL,
                 .label_scale=NULL,
                 .label_neg_paren=NULL),
  active = list(
    axis_template = function(value) {
      if (missing(value)) {
        tmp= c(self$tick_name,self$label_name)

          #tmp=rev(tmp)
        start=paste0(tmp[1],c("-start",'-end'))
        end=paste0(tmp[2],c("-start",'-end'))
          out=c(brck(start[1]),self$tick_size,brck(start[2],end[1]),self$label_size,brck(end[2]))
          if((self$coord=='y'&self$position=='left')|(self$coord=='x'&self$position=='top'))
          out<-rev(out)
        return(out%sep%" ")
      }
      stop("axis_template is read only")

    },
    tick_area = function(value) {
    if (missing(value)) {
        return(return(glue("{self$tick_name}-start/{self$tick_name}-end")))
    }
    stop("tick_area is read only")

},
    scale_type = function(value) {
      if (missing(value)) {
        return('continuous')
      }
  stop("scale_type is read only")

},
    tick_css = function(value) {
      if (missing(value)) {
        if(self$coord%in%c('y','z'))
          return(item_css(row=self$grid_positions,col=self$tick_area))
        return(item_css(col=self$grid_positions,row=self$tick_area))
      }
      stop("tick_css is read only")

    },
    label_neg_paren = function(value) {
    if (missing(value)) {
    out=private$.label_neg_paren
      if(is.null(out)&&self$label_suffix=='$')
        return(TRUE)
      else(FALSE)
    }
      private$.label_neg_paren<-assert_logical(value,len=1)

},
    label_scale = function(value) {
      if (missing(value)) {
        x = upper(self$label_suffix)
        out = fcase(x == "%",
                    10 ^ 2,
                    x == 'K',
                    10 ^ -3,
                    x == "M",
                    10 ^ -6,
                    x == "B",
                    10 ^ -9,
                    x == "T",
                    10 ^ -12) %or% private$.label_scale
        return(out)
      }
      private$.label_scale = assert_number(value)

    },
    label_prefix = function(value) {
      if (missing(value)) {
        return(private$.label_prefix)
      }
      private$.label_prefix = assert_string(value)
    },
    label_suffix = function(value) {
      if (missing(value)) {
        return(private$.label_suffix)
      }
      private$.label_suffix = assert_string(value)
    }
  )
)
#' @export
DiscreteGuide = R6::R6Class(
  'discreteGuide',
  inherit=Guide,
  public = list(
    initialize = function(...) {
    self$super_init(...)
    },
    super_init=import_fn(super_init)
  ),
  private = list(.init=FALSE),
  active = list(
    axis_template = function(value) {
      if (missing(value)) {
        tmp= c(self$label_name)
        area=paste0(tmp,c("-start",'-end'))
        out=c(brck(area[1]),self$label_size,brck(area[2]))%sep%' '
        return( out)
      }
      stop("axis_template is read only")
    },
    scale_type = function(value) {
      if (missing(value)) {
        return('discrete')
      }
      stop("scale_type is read only")

    }
  )
)
#' @export
build_guide=function(scale){
  if(scale$is_discrete)
    return(DiscreteGuide$new(guide_info=scale$get_guide_info()))
  ContinuousGuide$new(guide_info=scale$get_guide_info())

}
