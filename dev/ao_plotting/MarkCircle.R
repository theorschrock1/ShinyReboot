MarkCircle = R6::R6Class(
  'MarkCirle',
  inherit=MarkSegment,
  public = list(
    mark_template=ops(
      line(
        x1='{x}',x2='{x}',y1='{y}',y2='{y}',stroke='{color}',stroke.width='{size}',stroke.linecap='round')
    ),
  aes = ops(
    x =,
    y =,
    size = '.1rem',
    color ='#4E79A7FF'
  )
),
private = list(.init=FALSE),
active = list()
)
#' @export
mark_circle=function(){
  MarkCircle$new()
}

#' @export
mark_circle=function(){
  MarkCircle$new()
}
