AOPlot = R6Class(
  'AOPlot',
  inherit = Aesthetics,
  public = list(
    data=NULL,
    scales=NULL,
    layers=list(),
    layout=NULL,
    grid=NULL,
    grid_formula=NULL,
    facet=FALSE,
    axis=list(),
    initialize = function(data,mapping=NULL,grid=NULL) {

    self$super_init(data=data)
    self$mapping_expr=enexpr(mapping)

    grid<-assert_formula(grid,null.ok = TRUE)

    facet=TRUE
    dat=build_panel_id(data,grid)
    self$data=dat$plot_data
    if(is.null(grid)){
        grid=PANEL~.
        facet=FALSE

    }
    self$grid_formula=grid
    self$grid=expr(.(!!!syms(f_nms(grid))))
    layout = new_grid_layout(facet_data = dat$facet_data,
                             rownames = self$facet_rownames,
                             colnames = self$facet_colnames)



    self$facet=facet
    self$layout=layout
     sx=NULL
     if(self$has_x){
       default=self$default_scale_type("x")
       sx=scale_x(default,aes=self$all_x_aes,breaks=self$get_bin_breaks('x'))
     }
     sy=NULL
     if(self$has_y){
       default=self$default_scale_type("y")
       sy=scale_y(default,aes=self$all_y_aes,breaks=self$get_bin_breaks('y'))
     }
     np_scales=lapply(self$non_position_aes,function(x)non_position_scales(name=x,self$default_scale_type(x)))
     self$scales=AoScales$new(drop_nulls(c(list(sx,sy),np_scales)))
     self$vadilate_mappings()
    ##x_aes
    },
    super_init=import_fn(super_init),
    add_layer=function(mapping=NULL,
                       by=NULL,
                       mark = NULL,
                       mark_params = NULL,
                       stat = NULL,
                       stat_params = NULL,
                       data = self$data,
                       position = NULL,
                       inherit.aes = FALSE,plot=TRUE,time=FALSE){
      mapping<-enexpr(mapping)
      by_expr<-enexpr(by)
      if(is.null(mapping)){
        mapping=self$mapping_expr
      }else if(nnull(self$mapping_expr)){
       defaults<-expr_unlist(self$mapping_expr)
       layer_mapping=expr_unlist(mapping)
       new_mapping=c(
         defaults[names(defaults)%nin%names(layer_mapping)], layer_mapping)

       mapping<-expr(.(!!!new_mapping))

       }
     append(self$layers)<-
       create_layer(
        mark = mark,
        by=by_expr,
        mark_params =  mark_params,
        stat =  stat ,
        stat_params =   stat_params,
        data = data,
        mapping =  mapping,
        position =  position,
        inherit.aes = inherit.aes,
        layout=self$layout,
        scales=self$scales,
        grid=self$grid
      )
if(plot)
      self$plot(class='w-100 h-100 p-2',time=time,log=!time)
    },

    map_layer_data=function(){
      if(is_empty(self$layers))
        return(self$layers)
      lapply(self$layers,function(x)x$compute_aes())
    },
    by_layer=function(fn,data=NULL,...){
      tmp=expr(x$fn)

      tmp[[3]]<-enexpr(fn)
      body=expr({
        args$data=data

        do.call(!!tmp,drop_nulls(args))
      })

      fn<-new_function(args=pairlist2(x=,data=NULL,args=list()),body=body)
     if(nnull(data))
      return(map2(self$layers,data,fn,args=list(...)))

     lapply(self$layers,fn,args=list(...))

    },
    assign_grid_areas=function(layout=self$layout){
      xscale=self$scales$get_scales("x")
      yscale=self$scales$get_scales("y")
      grid_formula=self$grid_formula

      layout$map_grid_areas(template_rows=yscale$get_panel_template(),template_cols=xscale$get_panel_template())
      # if(!self$facet){
      #   layout$template_columns="auto 1fr"
      #   layout$template_rows="1fr auto"
      #   layout$template_areas=c("yaxis1 panel1",'. xaxis1')
      #   layout$y_axis_areas=glue('yaxis1')
      #   layout$x_axis_areas=glue('xaxis1')
      #   return()
      # }
      #
      # tmp<-unique(expr_eval(self$data[,.(variable=paste0('panel',PANEL)),by=!!self$by]))
      #
      # if(len0(f_rhs_nms(by_formula))){
      #   layout$template_columns="auto 1fr auto"
      #   layout$template_rows=glue("repeat({nrow(tmp)},1fr) auto")
      #   layout$template_areas=paste(c(glue('yaxis{1:nrow(tmp)}'),'.'),c(tmp$variable,'xaxis1'),c(glue('ygroup{1:nrow(tmp)}'),'.'))
      #   layout$y_axis_areas=glue('yaxis{1:nrow(tmp)}')
      #   layout$x_axis_areas='xaxis1'
      #   # y_facet=f_lhs_nms(by_formula)
      #   # tmp[,..y_facet]
      #   return()
      # }
      # tmp<-dcast(tmp,self$by_formula,value.var = 'variable')
      # lapply(f_lhs_nms(self$by_formula),function(x)tmp[,c(x):=NULL])
      # yaxis=list(c(glue('yaxis{1:nrow(tmp)}')))
      # xaxis=c('.',glue('xaxis{1:ncol(tmp)}'),".")%sep%" "
      # xgroup=c('.',glue('xgroup{1:ncol(tmp)}'),".")%sep%" "
      # layout$y_axis_areas=glue('yaxis{1:nrow(tmp)}')
      # layout$x_axis_areas=glue('xaxis{1:ncol(tmp)}')
      #  tmp$ygroup=glue('ygroup{1:nrow(tmp)}')
      #
      #  out<-reduce(c(  yaxis,as.list(tmp)),paste)
      #  layout$template_columns=glue("auto repeat({length(layout$x_axis_areas)},1fr) auto")
      #  layout$template_rows=glue("repeat({nrow(tmp)},1fr) auto")
      #  layout$template_areas<-c(xgroup,out,   xaxis)


    },
    plot=function(...,time=FALSE,log=TRUE){
      require(tictoc)
      tic.clearlog()
      tic('total')
  scales=self$scales
  layout=self$layout
  tic('reset scales')
  self$scales$reset()
  toc(quiet=!time,log=log)
  tic('compute_aes')
  dlist<-self$by_layer(compute_aes)
  toc(quiet=!time,log=log)
  position_scales=self$scales$position_scales()
  tic('scales_train_transformers')
  lapply(dlist, scales_train_transformers, scales = position_scales)
  toc(quiet=!time,log=log)
  tic('scales_map_grid')

  dlist<-lapply(dlist, scales_map_grid,scales =position_scales)
  toc(quiet=!time,log=log)
  tic('scales_transform_dt')
  dlist <- lapply(dlist, scales_transform_dt, scales = position_scales)
  toc(quiet=!time,log=log)
  tic('scales_train_dt:position_scales')
  lapply(dlist, scales_train_dt, scales =position_scales)
  toc(quiet=!time,log=log)
  tic('compute_statistic')
  pre_stat_scales_names=scales$get_scale_names()
  dlist<-self$by_layer(compute_statistic,data=dlist)
  toc(quiet=!time,log=log)
  tic('pre_data_setup')
  dlist<-self$by_layer(pre_data_setup,data=dlist)
  toc(quiet=!time,log=log)
  tic('map_position')
  dlist<-self$by_layer(map_position,data=dlist)
  toc(quiet=!time,log=log)
  tic('reset scales')
  self$scales$reset()
  toc(quiet=!time,log=log)
  tic('scales_train_dt')
  new_scales=scales$get_scale_names()%NIN%pre_stat_scales_names
  stat_scales=scales$non_position_scales()
  lapply(dlist, scales_train_transformers, scales =stat_scales)
  dlist <- lapply(dlist, scales_transform_dt, scales =stat_scales)
  lapply(dlist, scales_train_dt, scales =self$scales)


  toc(quiet=!time,log=log)
  tic('scales_map_dt')
  dlist<-lapply(dlist, scales_map_dt, scales =self$scales)
  toc(quiet=!time,log=log)
  tic('by_layer:draw_layer')
  dlistout<-self$by_layer(draw_layer,data=dlist)
  toc(quiet=!time,log=log)
  tic('by_layer:map_panel')
  self$by_layer(map_panel,data=dlistout)
  toc(quiet=!time,log=log)
  tic('assign_grid_areas')

  self$assign_grid_areas(layout=self$layout)
  toc(quiet=!time,log=log)
  tic('draw_layout')
  tmp<-self$layout$draw_layout(scales=self$scales,time=time)
  toc(quiet=!time,log=log)
  tic('view')
  view_html(tmp,style_sheets=c('aoplot/aoplot.css','mdi-icons/css/materialdesignicons.css'))
  toc(quiet=!time,log=log)
  toc(quiet=!time,log=log)
  out=tic.log(format =FALSE)
  out=rbindlist(lapply(out,as.data.table))
  out[,time:=toc-tic]

  return( out[,.(.N,sum(time)),by=msg][])
},
    plot2=function(...){

      self$scales$reset()
      dlist<-self$by_layer(compute_aes)
      lapply(dlist, scales_train_transformers, scales =self$scales)
      dlist<-self$by_layer(compute_statistic,data=dlist)
      position_scales=self$scales$position_scales()
      dlist<-lapply(dlist, scales_map_grid,scales =position_scales)

      dlist <- lapply(dlist, scales_transform_dt, scales =self$scales)
      dlist<-self$by_layer(pre_data_setup,data=dlist)

      dlist<-self$by_layer(map_position,data=dlist)

      lapply(dlist, scales_train_dt, scales =self$scales)
      dlist<-lapply(dlist, scales_map_dt, scales =self$scales)

      dlistout<-self$by_layer(draw_layer,data=dlist)
      self$by_layer(map_panel,data=dlistout)


      self$assign_grid_areas(layout=self$layout)
      tmp<-self$layout$draw_layout(scales=self$scales)
      view_html(tmp,style_sheets=c('aoplot/aoplot.css','mdi-icons/css/materialdesignicons.css'))
      return(invisible( dlist))
    }
  ),
  private = list(.init=FALSE,
                 .fill_pal=NULL),
  active=list(
    facet_names = function(value) {
    if (missing(value)) {
        return(c( self$facet_colnames,self$facet_rownames))
    }
    stop("facet_names is read only")

    },
    facet_colnames = function(value) {
    if (missing(value)) {
        return(f_rhs_nms(self$grid_formula)%or%NULL)
    }
    stop("facet_colnames is read only")

},
    facet_rownames = function(value) {
    if (missing(value)) {
      lhs=f_lhs_nms(self$grid_formula)
      if(len0(lhs))
        return()
      if(lhs=='PANEL')
        lhs=NULL
        return(lhs%or%NULL)
    }
    stop("facet_rownames is read only")

},
    color_palette = function(value) {
    if (missing(value)) {
        return(  private$.fill_pal)
    }
      tmp=self$scales$get_scales('fill')
      tmp2=self$scales$get_scales('color')
      if(nnull(tmp))
        tmp$palette=value
      if(nnull(tmp2))
        tmp2$palette=value
      if(nnull(tmp)|nnull(tmp2))
        self$plot()

    private$.fill_pal=value
    }
  )
)


#' @export
build_panel_id=function(data,by=NULL){
  if(is.null(by)){
    data[,PANEL:=1]
  return(list(plot_data=data,facet_data=data.table(PANEL=1)))
  }
  rowg=f_lhs_nms(by)%or%NULL
  colg=f_rhs_nms(by)%or%NULL

  by_names=c(rowg,colg)


  tmp=data[,..by_names]
  setkeyv(tmp,by_names)
  tmp=unique(tmp,by=key(tmp))
  setkeyv(data,rowg)
  tmp[,rowGRP:=.GRP,by=rowg]
  setkeyv(tmp,colg)
  tmp[,colGRP:=.GRP,by=colg]
  tmp[,PANEL:=seq_along(colGRP)]
  setkeyv(data,by_names)
  tmp[,rowGRP:=NULL]
  tmp[,colGRP:=NULL]
  setkeyv(tmp,by_names)
  list(plot_data=data[tmp],facet_data=tmp)
}
