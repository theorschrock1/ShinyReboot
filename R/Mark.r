#' @export
Mark <- R6::R6Class("Mark",
                    inherit = AoProto,
                    public=list(
                      group_template=ops(),
                      mark_template=ops(),
                      panel_template=ops(
                        div(class = '{position}',
                            style = .(grid.row = '{ygrid}',
                                      grid.column = "{xgrid}"))),
                      get_mark_params=function(template){
                        template=template[[1]]
                        args<-call_args(template)
                        args$value=unlist(args[names(args)==''])%sep%""
                        attrs=args[names(args)!='']
                        list(
                          name=call_name(template),
                          attrs=lapply(attrs,eval))


                      },
                      draw_panel=function(data,...){
                        params=self$get_mark_params(self$panel_template)
                        params$attrs$value='{V1%sep%""}'
                        fn=do.call(mark2,params)
                        fn(data,...)
                      },
                      draw_group=function(data,...){
                        params=self$get_mark_params(self$group_template)
                        params$attrs$value='{V1%sep%""}'
                        fn=do.call(mark2,params)
                        fn(data,...)

                      },
                      draw_mark=function(data,...){
                        params=self$get_mark_params(self$mark_template)
                        fn=do.call(mark2,params)
                        fn(data,...)
                      },
                      finish_layer=function(data,scales,layout,...){
                       data
                      },
                      compute_panel = function(data, scales, ...) {
                        grp_class= self$panel_class(scales)
                        data[,.(mark=self$draw_panel(c(.BY,self$compute_group(.SD)),class=grp_class)),by=.(xgrid,ygrid,PANEL,position)]

                      },
                      compute_group = function(data, scales) {
                        data[,self$draw_group(.(V1=self$draw_mark(.SD))),by=.(group)]
                      },
                      panel_class = function(scales) {
                        p=self$position_types(scales)
                        paste0(p$x,"-",p$y)
                      }
                    )
)

#
# Mark = R6::R6Class(
#   'Mark',
#   public = list(
#     html_mapping=list(),
#     defaults=list(),
#     params=list(y='discrete',x='continuous'),
#     name='mark',
#     data=NULL,
#     tag='div',
#     mark_params=list(),
#     formats=list(),
#     initialize = function() {
#       # self$params=list(...)
#       # data=self$use_defaults(data)
#       # self$check_required_aes(data)
#       # self$params=self$setup_params(data,self$params)
#       # self$data=self$setup_data(data,self$params)
#
#     },
#     grid_map=function(data,grid_layout){
#
#       split(data[,.(mark=mark,panel)],by='panel',keep.by=FALSE)
#       #map to grid areas
#
#       map2(marks,grid_layout$panels,function(marks,panel){
#         panel %>% tagAppendChildren(HTML(marks))
#       })
#     },
#     render=function(data,...){
#       if(is.null(tag))
#          abort("Missing tag name")
#       self$use_defaults(data)
#
#       draw_mark<-mark_fn(self$tag,attrs = self$html_mapping,formats=self$formats,close=TRUE)
#      # print(data)
#       data[,marks:=draw_mark(.SD,...)]
#       data
#       },
#     draw_marks=function(data,params=self$mark_params){
#       params$data=data
#       do.call(self$render,params)
#     },
#     draw_group = function(data) {
#       data<-data[,.(mark_groups=marks%sep%""),by=.(xgrid,ygrid,PANEL,position,xpos,ypos)]
#       data[,hd:=fifelse(xpos,'h-pos','h-neg')]
#       data[,vd:=fifelse(ypos,'v-pos','v-neg')]
#       grp_class=paste0(self$x_type(data),"-",self$y_type(data))
#       data[,gridgroups:=glue_data(data,'<div class="{position} {grp_class} {hd} {vd}" style="{item_css(row=ygrid,col=xgrid,position="relative")}">{mark_groups}</div>')]
#       data
#     },
#     fmt=function(x){
#       paste0(signif(x,5),'%')
#     },
#     x_type = function(data) {
#         if(is.null(data$xgrid))
#           return()
#         if(grepl('xgrp',data$xgrid[1]))
#           return('discrete')
#         return('continuous')
#     },
#     y_type = function(data) {
#       if(is.null(data$ygrid))
#         return()
#       if(grepl('ygrp',data$ygrid[1]))
#         return('discrete')
#       return('continuous')
#
#     },
#     setup_params = function(params=self$params,flipped_aes,data,...){
#       params$x=self$x_type(data)
#       params$y=self$y_type(data)
#       params$flipped_aes=flipped_aes
#       self$params=params
#       params
#     },
#     calc_lims=function(coord,type,data){
#       names=paste0(coord,c('min','max','pos'))
#       if(type=='discrete'){
#         bandwd<-resolution(data[[coord]],zero=FALSE)/2
#         data[, c(names):=.(.SD[[1]] - bandwd, .SD[[1]] +  bandwd,TRUE),.SDcols =  coord]
#       }
#       if(type=='continuous'){
#         data[, c(names) := .(pmin(.SD[[1]],0),pmax(.SD[[1]],0),.SD[[1]]>0), .SDcols =coord]
#         v0=paste0(coord,'0')
#         vS=paste0(coord,'lower')
#         data[,c(vS):=min(.SD),.SDcols=paste0(coord,c('min'))]
#         data[,c(v0):=pmax(unique(.SD[[vS]]),0)]
#       }
#     },
#     setup_data = function(data, params){
#
#       x_type= params$x
#       y_type= params$y
#       #print(params)
#       self$calc_lims('x',x_type,data)
#       self$calc_lims('y', y_type,data)
#       self$use_defaults(data)
#       data
#     },
#     setup_html_mapping=function(mapping=self$html_mapping){
#       mapping
#     },
#     use_defaults=function(data,defaults=self$defaults){
#       missing_defaults=defaults[names(defaults)%nin%names(data)]
#       dnames<-names(missing_defaults)
#       map2(dnames,missing_defaults,function(n,d)data[,c(n):=d])
#       data
#     },
#     setup_render=function(data,params=self$params,...){
#    data
#       },
#     check_required_aes=function(data){
#       res<-all(self$required_aes%in%names(data))
#       if(!res)
#         g_stop("{self$name} requires {self$required_aes%sep%','}")
#
#     }
#   ),
#   private = list(),
#   active = list(
#
#   )
# )

