Layer <- R6Class(
  'Layer',
  inherit = Aesthetics,
  public = list(
    mark = NULL,
    mark_params = NULL,
    stat = NULL,
    stat_params = NULL,
    data = NULL,
    position = NULL,
    inherit.aes = FALSE,
    layout=NULL,
    scales=NULL,
    initialize = function( mapping = NULL,
                           by=NULL,
                           mark = NULL,
                           mark_params = NULL,
                           stat = NULL,
                           stat_params = NULL,
                           data = NULL,
                           position = NULL,
                            inherit.aes = FALSE,
                            layout,
                            scales,
                           grid=expr(.())) {
      self$super_init(data=data)
      self$mapping_expr=assert_call(mapping,call_name = ".")
      self$by_expr=assert_call(by,call_name = ".",null.ok = TRUE)
      self$mark = mark
      self$mark_params= mark_params
      self$stat =stat
      self$stat_params = stat_params
      self$data = data
      self$position = position
      self$inherit.aes = inherit.aes
      self$layout=layout
      self$scales=scales
      self$grid= grid
      aes=self$aes
      new_aes<-aes[!sapply(aes,self$scales$has_scale)]
      lapply(new_aes,self$add_scale)
      return(invisible(NULL))
    },
    super_init=import_fn(super_init),
    # map_position = function(data,
    #                         flipped_aes = self$flipped_aes,
    #                         group_aes = self$group_aes,
    #                         position_group_aes = self$position_group_aes) {
    #   params=list(flipped_aes = flipped_aes,
    #               group_aes = group_aes,
    #               position_group_aes = position_group_aes)
    #   params = self$position$setup_params(data=data,params=params)
    #
    #   data = self$position$setup_data(data, params)
    #   self$position$compute_layer(data, params)
    # },
    map_position = function(data) {

     data=self$position$compute_layer(data,scales=self$scales)
     self$position$finish_layer(data)
    },
    pre_data_setup=function(data,flipped_aes=self$flipped_aes){
      #params<-self$mark$setup_params(flipped_aes=flipped_aes,data=data)
      #self$mark$html_mapping=self$mark$setup_html_mapping()
      #self$mark$setup_data(data=data,params=params)
      data
    },
    draw_layer=function(data){

      data=self$mark$compute_layer(data,scales=self$scales)
     self$mark$finish_layer(data)
    },
    # draw_layer=function(data){
    #   params=list(flipped_aes=self$flipped_aes,position_group_aes = self$position_group_aes)
    #   data=self$mark$setup_render(data=data,params=params,scales=self$scales)
    #   data=self$mark$draw_marks(data=data)
    #   data=self$mark$draw_group(data=data)
    #   data
    # },
    map_panel=function(data,layout=self$layout){
      setkey(data,PANEL)
     data[,layout$map_panel(.GRP,mark%sep%''),by=.(PANEL)]
      return(invisible(self))
    },
    compute_aes=function(data=self$data){
      self$vadilate_mappings()
      J<-self$mapping_expr
      by=expr_unlist(self$by_group)
      Ju=expr_unlist(J)
      J=expr(.(!!! Ju%NIN%by))
                            bygrps=expr(.(!!!c(exprs(PANEL),Ju%IN%by,by)))
      out<-eval(expr(data[,!!J,keyby=!!bygrps]))
      setnames(out,self$by_names,glue("GRP{1:l(self$by_names)}"))
      grps=glue("GRP{1:l(self$by_names)}")
      out[,group:=.GRP,by=c(grps)]
      out
    },
    compute_statistic=function(data){
     data=self$stat$compute_layer(data=data,scales=self$scales)
     self$stat$finish_layer(data,scales=self$scales)
    },
    add_scale=function(name){
      assert_choice(name,self$all_aes)
      if(name=='x'){
        scale=scale_x(self$default_scale_type("x"),aes=self$all_x_aes)
      }else if(name=='y'){
        scale=scale_y(self$default_scale_type("y"),aes=self$all_y_aes)
      } else{
        scale=non_position_scales(name=name,self$default_scale_type(name))
      }
     self$scales$add(scale)
    }
  ),
  private = list(  .init=FALSE),
  active = list()
)

#' @export
create_layer=function( mark = NULL,
                       mark_params = NULL,
                       stat = NULL,
                       stat_params = NULL,
                       data =NULL,
                       mapping= NULL,
                       position = NULL,
                       inherit.aes = FALSE,
                       layout,
                       ...){
  Layer$new(   mark =mark,
                     mark_params =  mark_params,
                     stat =  stat ,
                     stat_params =   stat_params,
                     data = data,
                     mapping =  mapping,
                     position =  position,
                     inherit.aes =inherit.aes,
                     layout=layout,...)
}
