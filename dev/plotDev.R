
require(ggplot2)
require(tictoc)
data=DT(diamonds)




#ds$bin
`[.binned`<-function (x, ...)
{
  y <- NextMethod("[")
  attr(y, "breaks") <- attr(x, "breaks")
  attr(y, "width") <- attr(x, "width")
  class(y) <- oldClass(x)
  y
}
setnames(data,'color','col')
m <- ggplot(economics, aes(unemploy/pop, psavert))
m + geom_path()
# gen_dist=function(n,times){
#  unlist(lapply(1:times,function(x)rnorm(n,mean=rnorm(1,sd=5),sd=exp(rnorm(1)))))
# }
# data<-data.table(x=gen_dist(5000,10),y=gen_dist(5000,10))
#data2=data[,.(price=mean(as.numeric(price)),na.rm=TRUE),by=.(cut)]

require(ggplot2)
require(tictoc)
data=DT(diamonds)
dat=data[,.(price=mean(price,na.rm=T)),by=.(clarity,cut)]
self=AOPlot$new(data=data,.(x=sum(price),y=cut,fill=clarity))
self$by_names
mark_l
 self$add_layer(by=.(cut),
   mark = mark_poly(),
   stat = stat_none(),
   position = position('fill'),plot=FALSE)
 self$by_names
 self$add_layer(
   mark = mark_bar(),
   stat = stat_none(),
   position = position('identity'))
# self$add_layer(by=.(cut,col,clarity),
#   mark = mark_treemap(),
#   stat = stat_none(),
#   position = position('treemap'))

 gg_env()$has_flipped_aes
scales=self$scales
scales$scales

library(jsonlite)
data[,toJSON(.BY,auto_unbox = TRUE),by=.(cut,col)]

layout=self$layout
#self$color_palette='Inferno'


#tic('compute_aes')
dlist<-self$by_layer(compute_aes)
self$layers[[1]]$by_group
#self=self$layers[[1]]
position_scales=self$scales$position_scales()
lapply(dlist, scales_train_transformers, scales =position_scales)

#tic('scales_map_grid')
dlist[[1]]$y
is_discrete=function(x){
inherits(x,'identity')
}
dlist<-lapply(dlist, scales_map_grid,scales =position_scales)
#tic('scales_transform_dt')
dlist <- lapply(dlist, scales_transform_dt, scales =position_scales)
#tic('scales_train_dt:position_scales')
lapply(dlist, scales_train_dt, scales =position_scales)
# scales$get_discrete_aes()
# data = copy(dlist[[1]])
# self = self$layers[[1]]$stat
# self$finish_layer(data)
#data[,self$compute_group(data=data,scales=scales),by=PANEL]
#tic('compute_statis#tic')


pre_stat_scales_names=scales$get_scale_names()
data=dlist[[1]]
self=self$layers[[1]]$stat
dlist<-self$by_layer(compute_statistic,data=dlist)
#d
data=dlist[[1]]
#data[,.SD[1],by=group]
#self<-self$layers[[1]]
#self=self$layers[[1]]$stat
data=copy(dlist[[1]])
new_scales=scales$get_scale_names()%NIN%pre_stat_scales_names

#tic('pre_data_setup')
dlist<-self$by_layer(pre_data_setup,data=dlist)

#tic('map_position')
dlist<-self$by_layer(map_position,data=dlist)
data=copy(dlist[[1]])


#data=copy(dlist[[1]])


# self=self$layers[[1]]$position
# data=copy(dlist[[1]])
# params=self$params
#tic('reset scales')
self$scales$reset()

#tic('scales_train_dt')
stat_scales=scales$non_position_scales()
lapply(dlist, scales_train_transformers, scales =stat_scales)
dlist <- lapply(dlist, scales_transform_dt, scales =stat_scales)
lapply(dlist, scales_train_dt, scales =scales)

dlist<-lapply(dlist, scales_map_dt, scales =self$scales)
#scales$fill$scale_dt(data = dlist[[1]])
#
#
# self<-scales$fill
# self$scales$
# data=dlist[[1]]
# self=self$layers[[1]]$mark

# self=self$layers[[1]]$mark
data=copy(dlist[[1]])
# params=self$params
# #tic('by_layer:draw_layer')
#self=self$layers[[1]]$mark

dlistout<-self$by_layer(draw_layer,data=dlist)

#tic('by_layer:map_panel')
self$by_layer(map_panel,data=dlistout)

#tic('assign_grid_areas')

self$assign_grid_areas(layout=self$layout)

tmp<-self$layout$draw_layout(scales=self$scales,time=FALSE)
view_html(tmp,style_sheets=c('aoplot/aoplot.css','mdi-icons/css/materialdesignicons.css'))


etreemapify(G20, area = "gdp_mil_usd")
