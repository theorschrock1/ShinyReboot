#' @export
MarkBar = R6::R6Class(
  'MarkBar',
  inherit=Mark,
  public = list(
    aes = ops(
      xmin = ,
      xmax = ,
      ymin = ,
      ymax = ,
      fill = '#4E79A7FF',
      label=""
    ),
    mark_template = ops(div(
      '<span class="chart-label bar-label" style="--char:{(1+str_length(label))*.8}rem;">{label}</span>',
      style = .(
        width = "{width}%",
        height = '{height}%',
        background.color = '{fill}'
      )
    )),
    panel_template=ops(
      div(class = '{position} {hd} {vd}',
          style = .(grid.row = '{ygrid}',
                    grid.column = "{xgrid}"))),
    compute_panel= function(data,scales,...) {
      data[,hd:=fifelse(xpos,'h-pos','h-neg')]
      data[,vd:=fifelse(ypos,'v-pos','v-neg')]
      grp_class= self$panel_class(scales)
      data[,.(mark=self$draw_panel(c(.BY,self$compute_group(.SD)),class=grp_class)),by=.(xgrid,ygrid,PANEL,position,hd,vd)]
    },
    compute_group = function(data, scales) {
      data[,.(V1=self$draw_mark(.SD,class='mark-bar')),by=.(group)]
    },
    setup_data=function(data,scales,params,...){
       cont_aes=scales$get_continuous_aes()
      if('x'%in%cont_aes){
        data[,xgrid:=fifelse(xpos,
                             paste(xgrid_intercept,"/",'x-end'),
                             paste('x-start',"/",xgrid_intercept))]

        data[(xpos),xmax:=rescale(xmax,to=c(0,100),from=range(c(x0,100)))]
        data[(xpos),xmin:=rescale(xmin,to=c(0,100),from=range(c(x0,100)))]
        data[!(xpos),xmax:=rescale(xmax,to=c(0,100),from=range(c(0,x0)))]
        data[!(xpos),xmin:=rescale(xmin,to=c(0,100),from=range(c(0,x0)))]
        # data[(xpos),xmax:=rescale(xmax,to=c(0,100),from=range(c(xmin,xmax)))]
        #data[!(xpos),width:=rescale(width,,to=c(0,100)from=range(c(xmin,xmax)))]
        data[,width:=abs(xmax-xmin)]
      }else{
        data[,width:=100]
      }
      if('y'%in%cont_aes){
        data[,ygrid:=fifelse(ypos,
                             paste('y-start',"/",ygrid_intercept),
                             paste(ygrid_intercept,"/",'y-end'))]

        data[(ypos),ymax:=rescale(ymax,to=c(0,100),from=range(c(y0,0)))]
        data[(ypos),ymin:=rescale(ymin,to=c(0,100),from=range(c(y0,0)))]
        data[!(ypos),ymax:=rescale(ymax,to=c(0,100),from=range(c(100,y0)))]
        data[!(ypos),ymin:=rescale(ymin,to=c(0,100),from=range(c(100,y0)))]
        data[,height:=abs(ymax-ymin)]
      }else{
        data[,height:=100]
      }
       data
    }

  ),
  private = list(.init=FALSE),
  active = list(

  )
)
#' @export
mark_bar=function(){
  MarkBar$new()
}


#must include x and y
#must include exactly 1 dimension
#must include exactly 1 measure

#'
#'
#' MarkBar = R6::R6Class(
#'   'MarkBar',
#'   inherit=Mark,
#'   public = list(
#'     name='rect',
#'     required_aes=c("x","y"),
#'     defaults=list(fill='#4E79A7FF'),
#'     non_missing_aes=c('xmin','xmax','ymin','ymax'),
#'     params=list(y='discrete',x='continuous'),
#'     initialize = function(...) {
#'     self$super_init(...)
#'     },
#'     super_init=import_fn(super_init),
#'     render=function(data,...){
#'       na<-list()
#'
#'       bar_out='<div style="{{inline_style(width=self$fmt(width),height=self$fmt(height),background.color=fill)}}" {extra}></div>'
#'
#'       extra<-glue_collapse(glue('{names(na)}="{na}"')," ")%or%""
#'       bar_out=glue(bar_out)
#'       data[,marks:=glue_data(data,bar_out)]
#'       data
#'     },
#'     setup_render=function(data,flipped_aes,...){
#'
#'       if(self$x_type(data)=='continuous'){
#'         data[,xgrid:=fifelse(xpos,
#'                              paste(xgrid_intercept,"/",'x-end'),
#'                              paste('x-start',"/",xgrid_intercept))]
#'
#'         data[(xpos),xmax:=rescale(xmax,to=c(0,100),from=range(c(x0,100)))]
#'         data[(xpos),xmin:=rescale(xmin,to=c(0,100),from=range(c(x0,100)))]
#'         data[!(xpos),xmax:=rescale(xmax,to=c(0,100),from=range(c(0,x0)))]
#'         data[!(xpos),xmin:=rescale(xmin,to=c(0,100),from=range(c(0,x0)))]
#'         # data[(xpos),xmax:=rescale(xmax,to=c(0,100),from=range(c(xmin,xmax)))]
#'         #data[!(xpos),width:=rescale(width,,to=c(0,100)from=range(c(xmin,xmax)))]
#'         data[,width:=abs(xmax-xmin)]
#'       }else{
#'         data[,width:=100]
#'         }
#'       if(self$y_type(data)=='continuous'){
#'     data[,ygrid:=fifelse(ypos,
#'                          paste('y-start',"/",ygrid_intercept),
#'                          paste(ygrid_intercept,"/",'y-end'))]
#'
#'     data[(ypos),ymax:=rescale(ymax,to=c(0,100),from=range(c(y0,0)))]
#'     data[(ypos),ymin:=rescale(ymin,to=c(0,100),from=range(c(y0,0)))]
#'     data[!(ypos),ymax:=rescale(ymax,to=c(0,100),from=range(c(100,y0)))]
#'     data[!(ypos),ymin:=rescale(ymin,to=c(0,100),from=range(c(100,y0)))]
#'     data[,height:=abs(ymax-ymin)]
#'       }else{
#'         data[,height:=100]
#'   }
#'         self$use_defaults(data)
#'     }
#'
#'   ),
#'   private = list(.init=FALSE),
#'   active = list(
#'
#'   )
#' )
#'
#' mark_bar=function(){
#'   MarkBar$new()
#' }
#'
#'
#' #must include x and y
#' #must include exactly 1 dimension
#' #must include exactly 1 measure
