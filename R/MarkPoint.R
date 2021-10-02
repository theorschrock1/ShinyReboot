#' @export
MarkPoint = R6::R6Class(
  'MarkPoint',
  inherit=Mark,
  public = list(
    name='point',
    required_aes=c('x','y'),
    defaults=list(color='#4E79A7FF',shape='circle-outline',size=1),
    params=list(y='discrete',x='continuous'),
    non_missing_aes=c('top','left'),
    initialize = function(...) {
      self$super_init(...)

    },
    super_init=import_fn(super_init),
    setup_render=function(...,data,params=self$params){

      data[,bottom:=50]
      data[,left:=50]
      if(params$y!='discrete'){
        data[,bottom:=y]
      }
      if(params$x!='discrete'){
        data[,left:=x]
      }
      data
    },
    render=function(data,...){
      na<-list()


      mark_out<-'<span class="mdi mdi-{{shape}} mark-point" style="{{inline_style(bottom=self$fmt(bottom),left=self$fmt(left),color=color,font.size=paste0(size*.72,"rem"))}}" {extra}></span>'
      extra<-glue_collapse(glue('{names(na)}="{na}"')," ")%or%""
      mark_out=glue(mark_out)
      data[,marks:=glue_data(data,mark_out)]
      data
    }
  ),
  private = list(.init=FALSE),
  active = list()
)
#' @export
mark_point=function(){
  MarkPoint$new()
}


#must include x and y
#must include exactly 1 dimension
#must include exactly 1 measure
