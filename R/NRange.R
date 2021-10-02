#' @export
NRange<-R6::R6Class("NRange",
                public=list(
                  ticks=20,
                  extend_range=0,
                  axis_grid_name='axis_line',
                  graph_name='graph',
                  axis_edge_name= 'axis_edge',
                  axis_label_name='axis_label',
                  line_wd='0.05rem',
                  suffix=NULL,
                  initialize=function(extent=NULL,domain=NULL,extend_range=0,coord='x',ticks=NULL,axis_range=NULL,position=NULL){
                    self$coord=coord

                    self$axis_position=position
                    if(!is.null(domain))
                      self$domain <-domain
                    domain<-self$domain
                    if(nnull(extent)){
                      blist<-responsive_breaks(extent)
                    self$prv$.range<-range(blist$labs)
                    self$line_gaps=blist$fr
                    self$prv$.mark_classes=blist$class
                    self$gap_run_len<-blist$runlen
                    self$prv$.extent<-self$prv$.range


                    self$prv$.scale<-approxfun(self$prv$.range,domain)
                    bks<-blist$labs
                    self$ticks=l(bks)
                    self$gen_default_formatter(labels=bks)

                    if(!is.null(axis_range))
                      self$data_range<-axis_range
                    }
                  },
                  scale=function(value,domain=NULL,pad=NULL){
                    if(is.null(domain)){
                      return(self$prv$.scale(value))
                    }
                    approx(self$data_range,domain,xout=value)$y
                  },
                  range=function(value,domain=NULL,pad=NULL,from='zero',na_fill=NA,step_size=1){

                    from=match.arg(from,c("zero","locf",'nocb'))
                    zero=0
                    if(min(value)>0)zero=min(value)
                    range_func=char_approxfun(c("zero", "locf", 'nocb'),
                                              list(
                                                zero = rep(zero, l(value)),
                                                locf = shift(value,fill=na_fill),
                                                nocb = shift(value, type = 'lead',fill=na_fill)
                                              ))
                    x0=range_func(from)[[from]]

                    if(is.null(value)){
                      domain<-self$prv$.domain
                      out = data.table(
                        x_min = min(domain),
                        x0 = min(domain),
                        x1 = mean(domain),
                        x2 = max(domain),
                        x_max=max(domain)
                      )
                      out[,x_size:=abs((x1+step_size)-(x1-step_size))]
                      return(out)
                    }
                    value_add_step=value+step_size
                    value_sub_step=value-step_size

                    if(!is.null(domain)) {
                      if(hasClass(domain,"data.table"))domain=domain[,.(x0,x2)]
                    }
                    if(is.null(domain)){
                      out = DT(
                        cbind(
                          x_min = min(self$domain),
                          x0 = self$prv$.scale(x0),
                          x1 = self$prv$.scale(value),
                          x2 = self$prv$.scale(value),
                          x_max = max(self$domain)
                        )
                      )
                      out[, x_size := abs(self$prv$.scale(value_add_step) -
                                            self$prv$.scale(value_sub_step)
                      )
                      ]
                      return(out)
                    }
                    domain<-unlist(domain)
                    domain<-c(min(domain),max(domain))
                    out= DT(cbind(x_min=min(domain),
                                  x0=approx(self$data_range,domain,xout=x0)$y,
                                  x1=approx(self$data_range,domain,xout=value)$y,
                                  x2=approx(self$data_range,domain,xout=value)$y,
                                  x_max=max(domain)))

                    out[,x_size:=abs(approx(self$data_range,domain,xout=value_add_step)$y-
                                       approx(self$data_range,domain,xout=value_sub_step)$y)]
                  },
                  colorScale=function(value,domain=NULL){

                    domain<-domain%x%c("blue", "red")
                    pal<-colorRamp(domain)
                    tmp<-approx(self$data_range,c(0,1),xout=value)$y

                    glue_data(DT(pal(tmp)),"rgb({round(V1,4)},{round(V2,4)},{round(V3,4)})")
                  },
                  breaks=function(ticks=NULL,domain=NULL){

                    self$ticks<-ticks%x%self$ticks
                    value<-self$raw_labels %>% as.character() %>% as.numeric()

                    if(missing(domain)){
                      domain<-self$domain
                      return(approx(self$data_range,domain,xout=value,yleft=min(domain),yright=max(domain))$y)
                    }
                    approx(self$data_range,domain,xout=value,
                           yleft=min(domain),yright=max(domain))$y
                  },
                  formatLabels=function(x){
                    self$formatter()(x)
                  },
                  gen_default_formatter=function(labels){
                    digits<-0
                    suffix<-""
                    scale<-1

                    if(all(labels%%1000%in%c(0,500,250,750))){
                      scale<-.001
                      self$suffix<-"K"
                    }

                    if(all(labels%%1000000%in%c(0,50000,25000,75000))){
                      scale<-.000001
                      self$suffix<-"M"
                    }

                    while(any(labels*scale!=round(labels*scale,digits))){
                      digits=digits+1
                      if(digits>5)break
                    }

                    self$prv$.accuracy<-digits

                    tmp<-comma_format(accuracy = 1/(10^digits),
                                      scale=scale,
                                      suffix=suffix)

                    self$prv$.default_formatter<-tmp
                  },
                  generate_custom_formatter=function(formatter){
                    self$prv$.custom_formatter=eval(formatter)
                  },
                  remove_custom_formatter=function(){
                    self$prv$.custom_formatter=NULL
                  },
                  formatter=function(labels){
                    format_fn=self$prv$.custom_formatter
                    if(is.null(self$prv$.custom_formatter))
                      format_fn=self$prv$.default_formatter

                    format_fn(labels)
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
                  .mark_classes=NULL,
                  .domain=c(0,100),
                  .custom_labels=NULL,
                  .use_pretty_range=NULL,
                  .coord=NULL,
                  .area=NULL,
                  .line_gaps=NULL,
                  .gap_run_len=NULL
                ),
                active=list(
                  line_gaps = function(value) {
                        if (missing(value)) {
                            return(paste0(private$.line_gaps,"fr"))
                        }
                    self$prv$.line_gaps=assert_numeric(value)

                    },
                  gap_run_len = function(value) {
                      if (missing(value)) {
                          return(private$.gap_run_len)
                      }
                     private$.gap_run_len=assert_integerish(value)

                  },
                  raw_labels = function(value) {
                    if (missing(value)) {
                      if (is.null(self$prv$.custom_labels)) {
                        tmp = pretty_breaks(self$ticks)(self$data_range)
                      }
                      else{
                        tmp = self$prv$.custom_labels
                      }
                      tmp = tmp[tmp %inrange% self$data_range]
                      tmp
                    }
                    else{
                      self$prv$.custom_labels <- value
                      self$gen_default_formatter(self$prv$.custom_labels)
                    }
                  },
                  label_divs=function(value){
                    areas=self$label_areas
                    areas$rows
                    HTML(glue('<div class="axis-label {self$coord}-axis-label {self$mark_classes}" style="{item_css(row=areas$rows,col=areas$cols)}">{self$labels}</div>'))
                  },
                  tick_divs=function(value){
                    areas=self$tick_areas
                    areas$cols
                   HTML(glue('<div class="axis-tick {self$coord}-axis-tick {self$mark_classes}" style="{item_css(row=areas$rows,col=areas$cols)}"></div>'))
                  },
                  line_divs=function(value){
                    areas=self$line_areas
                    areas$rows
                    HTML(glue('<div class="axis-line {self$coord}-axis-line {self$mark_classes}" style="{item_css(row=areas$rows,col=areas$cols)}"></div>'))
                  },
                  grid_template = function(value) {
                      if (missing(value)) {

                        return(glue('{self$graph_start_css} {self$inner_template} {self$graph_end_css}'))
                      }
                      stop("grid_template is read only")

                  },
                  inner_template=function(value){
                    glue('repeat({self$gap_run_len},{self$line_wd} [{self$axis_line_name}-end] {self$line_gaps} [{self$axis_line_name}-start])')%sep%" "
                  },
                  axis_template = function(value) {
                        if (missing(value)) {
                          d=c(1,2)
                          if(self$coord=='y')
                            d=rev(d)
                            return(glue('[{self$axis_edge_name}{d[1]}] auto  [{self$axis_label_name}] auto [{self$axis_edge_name}{d[2]}]'))
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
                      labels<-self$formatter(self$raw_labels)
                      labels<-str_remove(labels,"\\.0+$")
                      labels[labels != '0'] <-
                        paste0(labels[labels != '0'], self$suffix)
                      labels
                    }
                    },
                  mark_classes=function(value){
                    if(missing(value)){

                    # lid=(1:self$ticks)-1
                    # labs=self$raw_labels
                    # classes=rep('axis-xl',self$ticks)
                    #
                    # classes[lid%%3==0]<-paste( classes[lid%%3==0],'axis-lg')
                    # classes[lid%%4==0]<-paste(classes[lid%%4==0],'axis-md')
                    # classes[lid%%4==0]<-paste(classes[lid%%4==0],'axis-sm')
                    # classes[lid==0|lid==max(lid)]<-paste(classes[lid==0|lid==max(lid)],'axis-xs')
                    # classes[labs==0]<-paste(classes[labs==0],'zero-line')
                    return(self$prv$.mark_classes)
                    }
                    stop("mark_class is read only")
                  },
                  mark_ids = function(value) {
                      if (missing(value)) {
                        out=1:self$ticks
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
                  line_areas= function(value) {
                    if (missing(value)) {
                      a1=glue('{self$axis_line_name}-start {self$mark_ids} / {self$axis_line_name}-end {self$mark_ids} ')
                      a2=grid_row(self$opp_graph_start,self$opp_graph_end)

                      out=list(rows=a2,cols=a1)

                      if(self$is_y)
                        names(out)<-rev(names(out))
return(out)
                    }
                    stop("item_areas is read only")
                  },
                  tick_areas= function(value) {
                    if (missing(value)) {
                      a1=glue('{self$axis_line_name}-start {self$mark_ids} / {self$axis_line_name}-end {self$mark_ids} ')

                      a2=glue('{self$axis_edge_name}1 / {self$axis_label_name}')

                      out=list(rows=a2,cols=a1)

                      if(self$is_y)
                        names(out)<-rev(names(out))
return(out)
                    }
                    stop("item_areas is read only")
                  },
                  data_range=function(value){
                    if(!missing(value)){
                      if(is.null(value)){
                        self$reset_data_range()
                        return()}
                      self$prv$.range<-value
                      self$prv$.scale<-approxfun(self$prv$.range,self$domain)
                    }else{
                      self$prv$.range
                    }
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
                        if(nnull(self$zero_pad)){
                          if(self$is_x)
                          return(glue('[self$graph_start] {self$zero_pad} [{self$axis_line_name}-start]'))
                          if(self$is_y)
                            return(glue('[{self$graph_start} {self$axis_line_name}-start] '))

                        }
                          return(glue('[{self$graph_start} {self$axis_line_name}-start]'))
                      }
                       return(glue('[{self$graph_start} {self$axis_line_name}-start] '))
                      stop("graph_start is read only")

                  },
                  graph_end_css = function(value) {
                    if (missing(value)) {
                      if(nnull(self$zero_pad)){
                        if(self$is_y)
                          return(glue('{self$line_wd} [{self$axis_line_name}-end] {self$zero_pad} [self$graph_end]'))

                      }
                      return(glue('{self$line_wd} [{self$graph_end} {self$axis_line_name}-end]'))
                    }

                    stop("graph_start is read only")

                  },
                  domain= function(value) {
                    if (missing(value)) {
                      if(self$coord=='y')
                         return(rev(private$.domain))
                      return(private$.domain)
                    }
                    private$.domain<-sort(assert_numeric(value,len=2))

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
                      glue('axis {self$coord}-axis axis-continuous')
                      return(glue('{self$coord}-axis axis-continuous'))
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

                  }
                )
)




