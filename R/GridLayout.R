#' @export
GridLayout = R6::R6Class(
  'GridLayout',
  public = list(
    panels=list(),
    axis=list(),
    facet=list(),
    facet_data=NULL,
    initialize = function(facet_data,rownames=NULL,colnames=NULL) {
      if('PANEL'%nin%names(facet_data))
        stop('Failed to initialze layout. PANEL id must be in facet_data')

      self$facet$row=Facet$new(direction ='row')
      self$facet$col=Facet$new(direction ='col')
      if(nnull(rownames))
        self$facet$row$data=unique(data[,..rownames])
      if(nnull(colnames))
            self$facet$col$data=unique(data[,..colnames])
      facet_data[, self$add_panel(.GRP), keyby =PANEL]
      self$facet_data=data
    },
    add_panel=function(name){
    self$panels[[name]]<-new_grid_panel()
    return(name)
    },
    map_panel=function(name,...){
      self$panels[[name]]$append_content(...)
    },
    get_panel_dims=function(){
      list(rows=self$facet$row$n_groups%or%1,
      cols=self$facet$col$n_groups%or%1) %>% unlist()
    },
    get_template_areas=function(){
      c(rows,cols)%<-%self$get_panel_dims()
      pad_top=self$facet$col$n_vars

     y= matrix(c(rep(".",pad_top),'yaxistitle',glue('yaxis{1:(rows)}'),".","."))

     main=matrix(c(glue('panel{1:(rows*cols)}'),glue('xaxis{1:cols}'),rep('xaxistitle',cols)),ncol=cols,nrow=rows+2,byrow = T)
     col_facet=self$facet$col$draw_facet_template()
     main<-rbind( self$facet$col$draw_facet_template(),main)

     tmp<-cbind(y,main)
     facet_y=self$facet$row$draw_facet_template(position='right',pad_start=self$facet$col$n_vars,pad_end=2)
   data.table(cbind(tmp,facet_y))

    },
    get_template_rows=function(){
      c(rows,cols)%<-%self$get_panel_dims()

    c(self$facet$col$template_rows,rep_css(rows,'1fr'),rep_css(2,'auto'))
    },
    get_template_cols=function(){
      c(rows,cols)%<-%self$get_panel_dims()

      c(rep_css(1,'auto'),rep_css(cols,'1fr'),self$facet$row$template_cols)
    },
    map_grid_areas=function(template_rows,template_cols){
      name=1:length(self$panels)
      map(name,function(name,template_rows,template_cols){
      area=paste0('panel',name)
      self$panels[[name]]$set_grid_template(area=area,rows=template_rows,cols=template_cols,gap=self$group_gap)
      },template_rows=template_rows,template_cols=template_cols)
    },
    draw_layout=function(...,scales,time=FALSE,log=FALSE){
      tic('   render panels')
      inner=lapply(self$panels,function(x)x$render_panel())
       toc(quiet=!time,log=log)
      tic('   render guide')
      axis<-self$render_guides(scales,time=time,log=log)
       toc(quiet=!time,log=log)
      tic('   draw_facet_areas')
      facetx=self$facet$row$draw_facet_areas()
      facety=self$facet$col$draw_facet_areas()
       toc(quiet=!time,log=log)
      class<-'ao-plot y-continuous'
      if(scales$get_scales('y')$is_discrete)
        class<-'ao-plot y-discrete'
      div(...,axis,inner,facetx,facety) %>% tagAppendAttributes(class=class,style=self$grid_css)
    },
    render_guides=function(scales,time=FALSE,log=FALSE){
      tic("      build guide")
      self$build_axis(scales)
      toc(quiet=!time,log=log)
      tic("      render_guide")
      out=c(self$axis[['x']]$render_guide(self$x_axis_areas),
        self$axis[['y']]$render_guide(self$y_axis_areas))
      toc(quiet=!time,log=log)
      out
    },
    build_axis=function(scales){

      self$axis[['x']]<-build_guide(scales$get_scales("x"))
      self$axis[['y']]<-build_guide(scales$get_scales("y"))
    },
    print_grid_css=function(){
    print(as_glue(unlist(str_split(self$grid_css,';'))%p%";"))
    }
  ),
  private = list(  .init=FALSE,
                   .template_areas=NULL,
                   .panel_gap=NULL,
                   .row_gap=NULL,
                   .col_gap=NULL,
                   .x_axis_areas=NULL,
                   .y_axis_areas=NULL,
                   .template_columns=NULL,
                   .template_rows=NULL,
                   .group_gap=NULL),
  active=list(
    template_areas = function(value) {
      if (missing(value)) {

        return(self$get_template_areas())
      }
     stop('template_areas is read only')

    },
    template_rows = function(value) {
      if (missing(value)) {

        return(self$get_template_rows())
      }
      stop('template_rows is read only')


    },
    template_columns=function(value){
      if(missing(value)){
        return(self$get_template_cols())
      }
      stop('template_columns is read only')
    },
    x_axis_areas = function(value) {
      if (missing(value)) {
        c(rows,cols)%<-%self$get_panel_dims()
        return( glue('xaxis{1:(cols)}'))
      }
      stop('x_axis_areas is read only')

    },
    y_axis_areas = function(value) {
      if (missing(value)) {
        c(rows,cols)%<-%self$get_panel_dims()
        return( glue('yaxis{1:(rows)}'))
      }
      stop('y_axis_areas is read only')

    },
    panel_gap = function(value) {
    if (missing(value)) {
      if(is.null(c(self$row_gap,self$col_gap)))
        return(rep(private$.panel_gap%or%0,2))
      if(is.null(self$row_gap))
        return(c(private$.panel_gap%or%0,self$col_gap))
      if(is.null(self$col_gap))
        return(c(self$row_gap,private$.panel_gap%or%0))
      c(self$row_gap,self$col_gap)
    }
      self$row_gap=NULL
      self$col_gap=NULL
      private$.panel_gap=assert_css_unit(value)


},
    group_gap = function(value) {
    if (missing(value)) {
        return(private$.group_gap)
    }
      private$.group_gap=assert_css_unit(value)

},
    row_gap = function(value) {
    if (missing(value)) {
        return(private$.row_gap)
    }
      private$.row_gap=assert_css_unit(value)
},
    col_gap = function(value) {
    if (missing(value)) {
        return(private$.col_gap)
    }
      private$.col_gap=assert_css_unit(value)
},
    grid_css = function(value) {
    if (missing(value)) {
        return(grid_css(areas=self$template_areas,cols=self$template_columns,rows=self$template_rows,grid.gap=self$panel_gap))
    }
    stop("grid_css is read only")

}

  )
)
#' @export
new_grid_layout=function(...){
  GridLayout$new(...)
}

