MarkLine = R6::R6Class(
  'MarkLine',
  inherit=MarkSegment,
  public = list(
    aes = ops(
      x =,
      y =,
      size = '.1rem',
      color ='#4E79A7FF'
    ),
    setup_data=function(data,params,scales){
      data=super$setup_data(data,params,scales)
      data[,c('xend','yend'):=lapply(.SD,shift,type='lead'),by=group,.SDcols=c('x','y')][!is.na(xend)]
    }
  ),
  private = list(.init=FALSE),
  active = list()
)
mark_line=function(){
  MarkLine$new()
}
