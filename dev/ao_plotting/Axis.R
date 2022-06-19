#' @export
Axis<-R6::R6Class("Axis",
                    public=list(
                      axis_grid_name='grp',
                      graph_name='graph',
                      axis_edge_name= 'axis_edge',
                      axis_label_name='axis_label',
                      bin_wd='1fr',
                      gutter_wd='.05rem',
                      initialize=function(scale,position=NULL){
                        self$coord=coord

                        self$axis_position=position
                        self$prv$.scale=scale
                        self$prv$.range=scale$range


                      },
                      reset_data_range=function(){
                        self$prv$.range<-  self$prv$.extent
                        self$prv$.scale<-approxfun(self$prv$.range,self$domain)
                      },
                      axis_containter=function(...){
                        div(...) %>%
                          tagAppendAttributes(class = self$axis_class, style =
                                                self$axis_css)
                      }
                    ),
                    private=list(
                      .default_formatter=NULL,
                      .custom_formatter=NULL,
                      .range=NULL,
                      .extent=NULL,
                      .scale=NULL,
                      .accuracy=NULL,
                      .domain=c(0,100),
                      .custom_labels=NULL,
                      .use_pretty_range=NULL,
                      .coord=NULL,
                      .area=NULL
                    ),
                    active=list(
                      label_divs=function(value){
                        areas=self$label_areas
                        areas$rows
                        HTML(glue('<div class="axis-label {self$coord}-axis-label  {self$mark_classes}" style="{item_css(row=areas$rows,col=areas$cols)}">{self$labels}</div>'))
                      },
                      grid_template = function(value) {
                        if (missing(value)) {

                          return(glue('{self$graph_start_css} repeat({self$n_groups-1},{self$bin_wd} [{self$axis_line_name}-end] {self$gutter_wd} [{self$axis_line_name}-start]) {self$graph_end_css}'))
                        }
                        stop("grid_template is read only")

                      },
                      axis_template = function(value) {
                        if (missing(value)) {
                          d=c(1,2)
                          if(self$coord=='y')
                            d=rev(d)
                          return(glue('[{self$axis_edge_name}{d[1]}] auto [{self$axis_edge_name}{d[2]}]'))
                        }

                        stop("axis_rows is read only")

                      },
                      axis_position = function(value) {
                        if (missing(value)) {
                          return(paste0('axis_',self$prv$.area))
                        }
                        if(self$coord=='y'){
                          assert_choice(value,c('left','right'),null.ok = TRUE)
                          self$prv$.area=value%or%'left'
                        }
                        if(self$coord=='x'){
                          assert_choice(value,c('top','bottom'),null.ok = TRUE)
                          self$prv$.area=value%or%'bottom'
                        }


                      },
                      labels=function(value){
                        if(missing(value)){
                          self$prv$.extent
                        }
                      },
                      mark_ids = function(value) {
                        if (missing(value)) {
                          out=1:l(self$labels)
                          if(self$is_y)
                            out<-rev(out)
                          return(out)
                        }
                        stop("mark_ids is read only")

                      },
                      axis_line_name = function(value) {
                        if (missing(value)) {
                          return(paste0(self$coord,"_",self$axis_grid_name))
                        }
                        stop("axis_line_name is read only")

                      },
                      label_areas= function(value) {
                        if (missing(value)) {
                          a1=glue('{self$axis_line_name}-start {self$mark_ids} / {self$axis_line_name}-end {self$mark_ids} ')

                          a2=glue('{self$axis_label_name} / {self$axis_edge_name}2')
                          out=list(rows=a2,cols=a1)

                          if(self$is_y)
                            names(out)<-rev(names(out))
                          return(out)
                        }
                        stop("item_areas is read only")
                      },
                      prv = function(value) {
                        if (missing(value)) {
                          return(private)
                        }
                        private<-value

                      },
                      opp_graph_start = function(value) {
                        if (missing(value)) {
                          if(self$is_y){
                            return(glue('{self$graph_name}-left'))
                          }
                          if(self$is_x){
                            return(glue('{self$graph_name}-top'))
                          }
                        }
                        stop("opp_graph_start is read only")

                      },
                      opp_graph_end = function(value) {

                        if (missing(value)) {
                          if(self$is_y){
                            return(glue('{self$graph_name}-right'))
                          }
                          if(self$is_x){
                            return(glue('{self$graph_name}-bottom'))
                          }
                        }
                        stop("opp_graph_end is read only")

                      },
                      graph_start = function(value) {
                        if (missing(value)) {
                          if(self$is_x){
                            return(glue('{self$graph_name}-left'))
                          }
                          if(self$is_y){
                            return(glue('{self$graph_name}-top'))
                          }
                        }
                        stop("graph_start is read only")

                      },
                      graph_end = function(value) {

                        if (missing(value)) {
                          if(self$is_x){
                            return(glue('{self$graph_name}-right'))
                          }
                          if(self$is_y){
                            return(glue('{self$graph_name}-bottom'))
                          }
                        }
                        stop("graph_start is read only")

                      },
                      graph_start_css = function(value) {
                        if (missing(value)) {

                          return(glue('[{self$graph_start} {self$axis_line_name}-start]'))
                        }
                        return(glue('[{self$graph_start} {self$axis_line_name}-start] '))
                        stop("graph_start is read only")

                      },
                      graph_end_css = function(value) {
                        if (missing(value)) {

                          return(glue('{self$bin_wd} [{self$graph_end} {self$axis_line_name}-end]'))
                        }

                        stop("graph_start is read only")

                      },
                      domain= function(value) {
                        if (missing(value)) {
                          if(self$coord=='x')
                            return(rev(private$.domain))
                          return(private$.domain)
                        }
                        private$.domain<-value

                      },
                      coord = function(value) {
                        if (missing(value)) {
                          return( private$.coord)
                        }
                        private$.coord<-
                          assert_choice(value,c('x','y','color','size'))

                      },
                      axis_class = function(value) {
                        if (missing(value)) {
                          glue('axis {self$coord}-axis axis-{scale_type}')
                          return(glue('{self$coord}-axis axis-{scale_type}'))
                        }
                        stop("axis_class is read only")

                      },
                      is_x = function(value) {
                        if (missing(value)) {
                          return(self$coord=='x')
                        }
                        stop("is_x is read only")

                      },
                      is_y = function(value) {
                        if (missing(value)) {
                          return(self$coord=='y')
                        }
                        stop("is_y is read only")

                      },
                      is_color = function(value) {
                        if (missing(value)) {
                          return(self$coord=='color')
                        }
                        stop("is_color is read only")

                      },
                      is_size = function(value) {
                        if (missing(value)) {
                          return(self$coord=='size')
                        }
                        stop("is_size is read only")

                      },
                      axis_css = function(value) {
                        if (missing(value)) {

                          if(self$is_x){
                            return(grid_css(
                              rows = self$axis_template,
                              cols = self$grid_template,
                              grid.area=self$axis_position
                            ))
                          }
                          if(self$is_y){
                            return(grid_css(
                              cols = self$axis_template,
                              rows = self$grid_template,
                              grid.area=self$axis_position
                            ))
                          }
                        }
                        stop("axis_css is read only")

                      },
                      range = function(value) {
                        if (missing(value)) {
                          return(private$.range)
                        }
                        stop("range is read only")

                      },
                      scale = function(value) {
                        if (missing(value)) {
                          return(private$.scale)
                        }
                        stop("scale is read only")

                      }
                    )
)
