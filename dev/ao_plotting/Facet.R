Facet = R6Class(
  'Facet',
  public = list(
    data=NULL,
    direction=NULL,
    colsize='auto',
    rowsize='auto',
    initialize = function(direction) {
     self$direction=assert_choice(direction,c('row','col'))
    },
    setup_data=function(data){
      colnams<-paste0(self$direction,'header',1:ncol(data))
      colnamsP<-paste0(colnams,"P")

      setnames(data,colnams)
      data[,c(colnamsP):=map2(.SD,colnams,function(x,y){rleid(x,prefix=paste0(y,'grp'))})]
      self$data_cols=colnams

      self$grid_cols=colnamsP
      data
    },
     draw_grid_areas=function(dt,direction=self$direction){


      setkeyv(dt,self$data_cols)
      rows=nrow(dt)
      ncol=l(colnames)
      fd<-melt.data.table(dt,measure.vars = list(self$data_cols,self$grid_cols),id.vars=NULL)
      fd<-unique(fd)
      fd[,variable:=as.numeric(variable)]
      fd[,rownum:= seq_len(.N),by=variable]
      dr=direction
      fd[,class:= fifelse(rownum%%2==0,dr%p%"-even",dr%p%"odd")]

      fd[,class:=paste(class,self$class)]

      fd<-fd[value1!="."]

      inner=glue_data(fd,"<div class='{class}' style='grid-area:{value2};'><span>{value1}</span></div>")%sep%""

    },
    append_class=function(x){
      self$class<-c(self$class,x)
    },
    remove_class=function(x){
      self$class=self$class%NIN%x
    },
    draw_grid_template=function(data,direction=self$direction,position=self$position){
      self$direction=direction
      self$position=position
     setkeyv(data,self$data_cols)
      tmp=data%get%self$grid_cols
      rev_pos=position%in%c("right",'bottom')
      title=self$title_template
      if(rev_pos)
        tmp=data%get%rev(self$grid_cols)
      if(direction=='row'){
       out= c(title,tmp[,reduce(.SD,paste)])
      }else{
      out=unlist(tmp[,lapply(.SD,function(x)x%sep%" ")])
      out=if(rev_pos)
         c(out,title)
        else
          c(title,out)
      }


      out
    },
    pad_grid_template=function(template,start=0,end=0){
      if(start>0){
        if(self$is_rows){
          tmp<-rep(".",self$n_vars)%sep%' '
          template<-c(rep(tmp,start),template)
        }else{
          tmp<-rep(".",start)%sep%' '
          template<-paste(tmp,template)
        }
      }
      if(end>0){
        if(self$is_rows){
          tmp<-rep(".",self$n_vars)%sep%' '
          template<-c(template,rep(tmp,end))
        }else{
          tmp<-rep(".",end)%sep%' '
          template<-paste(template,tmp)
        }
      }
      template
    },
    make_title=function(vars=self$var_names){
      if(self$is_rows){
       return(vars)
      }
      vars%sep%" / "

    },
    draw_title=function(title=self$make_title(),grid_area=self$title_grid_areas){

      fd=data.table(value1=title,value2=grid_area)
      inner=glue_data(fd,"<div class='title {self$class}' style='grid-area:{value2};'><span>{value1}</span></div>")%sep%""
    },
    draw_facet_template=function(data=self$data,direction=self$direction,position=self$position,pad_start=0,pad_end=0){
      if(is.null(self$data))
        return(".")
      setkey(data)
      self$data=copy(data)
      data=self$setup_data(copy(data))

      template_areas = self$draw_grid_template(data = data,
                                               direction = direction,
                                               position = position)
      if(self$is_rows)
        self$pad_x=pad_start+pad_end
      if(!self$is_rows)
        self$pad_y=pad_start+pad_end
self$pad_grid_template(template_areas,pad_start,pad_end)
tmp=data.table(self$pad_grid_template(template_areas,pad_start,pad_end))
as.matrix(tmp[,tstrsplit(V1," ")])
    },
    draw_facet_group=function(...,grid_area=NULL,data,direction=self$direction,position=self$position,pad_start=0,pad_end=0){
      setkey(data)
      self$data=copy(data)
      data=self$setup_data(copy(data))

      template_areas = self$draw_grid_template(data = data,
                                       direction = direction,
                                       position = position)
      if(self$is_rows)
        self$pad_x=pad_start+pad_end
      if(!self$is_rows)
        self$pad_y=pad_start+pad_end
      template_areas = self$pad_grid_template(template_areas,pad_start,pad_end)
      style = grid_css(
        rows = self$template_rows,
        cols = self$template_cols,
        areas = template_areas,
        grid.area = grid_area
      )
      class='facet-groups '%p%self$direction%p%'-facet-groups'
      a1=self$draw_grid_areas(data)
      a2=self$draw_title()
      headers=HTML(a1%p%a2)

      div(headers,...) %>%
        tagAppendAttributes(style=style,class=class)
    },
   draw_facet_areas=function(data=self$data,direction=self$direction,position=self$position){
     if(is.null(data))
       return()
     setkey(data)
     self$data=copy(data)
     data=self$setup_data(copy(data))
     a1=self$draw_grid_areas(data)
     a2=self$draw_title()
     headers=HTML(a1%p%a2)
   }
  ),
  private = list(.data_colnames=NULL,
                 .position=NULL,
                 .grid_colnames=NULL,
                 .pad_x=0,
                 .pad_y=0,
                 .class=c('pane','sticky','d-flex'),
                 .var_names=NULL),
  active = list(
    nrows = function(value) {
    if (missing(value)) {
      if(self$is_rows)
        return(nrow(self$data))
      return(ncol(self$data))
    }
    stop("nrows is read only")

},
    ncols = function(value) {
    if (missing(value)) {
      if(self$is_rows)
        return(ncol(self$data))
      return(nrow(self$data))
    }
    stop("ncols is read only")

},
    n_groups = function(value) {
    if (missing(value)) {
        if(self$direction=='row')
          return(self$nrows)
        return(self$ncols)
      }
      stop("n_groups is read only")

   },
    n_vars = function(value) {
      if (missing(value)) {
          return(length(self$var_names))
      }
      stop("n_vars is read only")

},
    template_rows = function(value) {
    if (missing(value)) {

      if(len0(self$nrows)){
        tmp=1
      }else{
        tmp=self$nrows+1+self$pad_x
      }
      return(paste('repeat(', tmp,",",self$rowsize,")"))
    }
    stop("template_rows is read only")

    },
    template_cols = function(value) {
    if (missing(value)) {
     if(len0(self$ncols)){
       tmp=   1
      }else{
        tmp=  self$ncols+self$pad_y
      }
      return(paste('repeat(',tmp,",",self$colsize,")"))
    }
    stop("template_cols is read only")

    },
    var_names= function(value) {
      if (missing(value)) {
        return(names(self$data))
      }
      stop("var_names is read only")
    },
    data_cols= function(value) {
    if (missing(value)) {
        return(private$.data_colnames)
    }
      private$.data_colnames=value
    },
    grid_cols = function(value) {
    if (missing(value)) {
        return(private$.grid_colnames)
    }
      private$.grid_colnames=value

},
    title_grid_areas=function(value){
      if(missing(value)){
      if(self$is_rows){
        out=paste0(self$direction,'title',1:self$n_vars)
      }else{
        out=paste0( self$direction,'title')
      }
        return(out)
      }
      stop('title_grid_area is read only')
    },
    title_template = function(value) {
    if (missing(value)) {
      if(!self$is_rows)
        return(rep(self$title_grid_areas,self$n_groups)%sep%" ")
      return(self$title_grid_areas%sep%" ")
    }
    stop("title_template is read only")

},
    is_rows = function(value) {
    if (missing(value)) {
        return(self$direction=='row')
    }
    stop("is_rows is read only")

},
    class = function(value) {
    if (missing(value)) {
      out=c('header',self$direction%p%'-header',private$.class,'align-items')%sep%' '
      if(self$direction=='row'){
       out= out%p%'-start'
      }else{
       out= out%p%'-end'
      }
        return(out)
    }

    private$.class=value
},
    coord = function(value) {
    if (missing(value)) {

        return(ifelse(self$direction=='row','y','x'))
    }
    stop("coord is read only")

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
          private$.position=value%or%'top'
        }},
    pad_x = function(value) {
    if (missing(value)) {
        return(private$.pad_x)
    }
      private$.pad_x=assert_integerish(value)

    },
    pad_y = function(value) {
      if (missing(value)) {
        return(private$.pad_y)
      }
      private$.pad_y=assert_integerish(value)

      }
  )
)
