#' @export
MarkSVG <- R6::R6Class(
  "MarkSVG",
  inherit =Mark,
  public = list(
    setup_data=function(data,params,scales,...){
      if(!is_empty(params$position_group)){
        lapply(params$position_group,function(x){
          pscale=scales$get_scales(x)
          pscale$rescale_by_grid(data)
        })
      }else{
        data[,xgrid:='x-start/x-end']
        data[ ,ygrid:='y-start/y-end']
      }
      data
    },
    group_template =ops(
      svg(
        class = 'h-100 w-100',
        viewBox = '0 0 100 100',
        preserveAspectRatio = 'none')
    )
  )
)
#promises::promise({MarkHex$new()$build_fn()})
# MarkSVG = R6::R6Class(
#   'MarkSVG',
#   inherit=Mark,
#   public = list(
#     name=NULL,
#     tag=NULL,
#     required_aes=c(),
#     html_mapping=list(),
#     defaults=list(),
#     default_svg_params = list(class = 'h-100 w-100',
#                       viewBox = '0 0 100 100',
#                       preserveAspectRatio = 'none'),
#     svg_params=list(),
#     params=list(y='discrete',x='continuous'),
#     initialize = function(...) {
#       self$super_init(...)
#
#     },
#     super_init=import_fn(super_init),
#     draw_svg=function(data,params=self$svg_params){
#     defaults=self$default_svg_params
#     params$class=paste(params$class,defaults$class)
#     params<-c(params,defaults[names(defaults)%nin%names(params)])
#     params$data=data
#
#      svg_gen<- mark_fn('svg',attrs =list(value='marks'))
#
#      do.call(svg_gen,params)
#     },
#     draw_marks=function(data,params=self$mark_params){
#       data=self$setup_mark(data)
#       params$data=data
#       do.call(self$render,params)
#     },
#     setup_mark=function(data){
#       data
#     },
#     draw_group = function(data,group_params=self$svg_params) {
#       data<-data[,.(marks=marks%sep%""),by=.(group,xgrid,ygrid,PANEL,position)]
#
#       grp_class=paste0(self$x_type(data),"-",self$y_type(data))
#       data[,marks:=self$draw_svg(.SD)]
#       data<-data[,.(mark_groups=marks%sep%""),by=.(xgrid,ygrid,PANEL,position)]
#       data[,gridgroups:=glue_data(data,'<div class="{position} {grp_class}" style="{item_css(row=ygrid,col=xgrid)}">{mark_groups}</div>')]
#       data
#     },
#     setup_render=function(...,data,params,scales){
#     if(!is_empty(params$position_group)){
#      pscale=scales$get_scales(params$position_group)
#      pscale$rescale_by_grid(data)
#     }else{
#        data[,xgrid:='x-start/x-end']
#        data[ ,ygrid:='y-start/y-end']
#     }
#   data
#     }
#
#   ),
#   private = list(.init=FALSE),
#   active = list()
# )

