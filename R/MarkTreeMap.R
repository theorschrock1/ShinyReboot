#' @export
MarkTreeMap = R6::R6Class(
  'MarkTreeMap',
  inherit=MarkBar,
  public = list(
    mark_template = ops(div(
       '{V1}',
      style = .(
        top = '{ymin*100}%',
        left = '{xmin*100}%',
        height = '{abs(ymax-ymin)*100}%',
        width ='{abs(xmax-xmin)*100}%',
        background.color = '{fill}')
      )
    ),
    panel_template=ops(
      div(class = '{position}',
          style = .(grid.row = '{ygrid}',
                    grid.column = "{xgrid}"))),
  draw_subgroup=function(data,...){
    sdcols=c("xmin",'xmax','ymin','ymax')

    xrange=range(c(data$xmin,data$xmax))
    yrange=range(c(data$ymin,data$ymax))
    dx=data[,lapply(.SD,function(x)rescale(x,from=xrange)),.SDcols=c("xmin",'xmax')]

    dy=data[,lapply(.SD,function(x)rescale(x,from=yrange)),.SDcols=c("ymin",'ymax')]

    gdat<-cbind(dx,dy,data[,.(fill,V1)])
    data[,.(V1=self$draw_mark(gdat,style=.(position='absolute'),class='border border-light'),xmin=min(xmin),xmax=max(xmax),ymin=min(ymin),ymax=max(ymax),fill='transparent')]
  },
  draw_group=function(data, groups) {

    if (length(groups) == 0)
      return(data)

    current_group=groups[1]

    self$draw_subgroup(data[,  self$draw_group(.SD,groups=groups[-1]),by=c(current_group)])
  },
  setup_data=function(data,scales,params,...){

      data[,xgrid:='x-start / x-end']
      data[,ygrid:=paste('y-start / y-end')]
      data[,V1:=""]
      data[,c('ymin','ymax'):=.(100-ymin,100-ymax)]
      data
  },
  setup_params=function(data,scales,params,...){
     params$groups=names(data)%grep%"GRP\\d"
     params
  },
  compute_group=function(data,scales,groups){
    self$draw_group(data,groups)
  },
  compute_panel = function(data, scales, ...) {
    grp_class= self$panel_class(scales)
    data[,position:='position-treemap']
    data[,.(mark=self$draw_panel(c(.BY,self$compute_group(data=.SD,scales=scales,...)),class=grp_class,style=.(position='relative'))),by=.(xgrid,ygrid,PANEL,position)]

  }
  ))
#' @export
mark_treemap=function(){
  MarkTreeMap$new()$build_fn()()
}
