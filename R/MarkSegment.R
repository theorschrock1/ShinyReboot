#' @export
MarkSegment = R6::R6Class(
  'MarkSegment',
  inherit=MarkSVG,
  public = list(
     mark_template=ops(
      line(
        x1='{x}',x2='{xend}',y1='{y}',y2='{yend}',stroke='{color}',stroke.width='{size}')
    ),
      aes = ops(
        x =,
        y =,
        xend =,
        yend =,
        size = '.1rem',
        color ='#4E79A7FF'
      )),
  private = list(.init=FALSE),
  active = list()
)
#' @export
mark_segment=function(){
  MarkSegment$new()$build_fn()()
}
#' @export
MarkvLine = R6::R6Class(
  'MarkvLine',
  inherit=MarkSegment,
  public = list(
    mark_template=ops(
      line(
        x1='{x}',x2='{x}',y1='{y}',y2='{yend}',stroke='{color}',stroke.width='{size}')
    ),
  aes = ops(
    x =,
    y =,
    yend =,
    size = '.1rem',
    color ='#4E79A7FF'
  )),
  private = list(.init=FALSE),
  active = list()
)

#' @export
mark_vline=function(){
  MarkvLine$new()$build_fn()()
}
#' @export
MarkhLine = R6::R6Class(
  'MarkvLine',
  inherit=MarkSegment,
  public = list(
    mark_template=ops(
      line(
        x1='{x}',x2='{xend}',y1='{y}',y2='{y}',stroke='{color}',stroke.width='{size}')
    ),
    aes = ops(
      x =,
      xend =,
      y =,
      size = '.1rem',
      color ='#4E79A7FF'
    )),
  private = list(.init=FALSE),
  active = list()
)
#' @export
mark_hline=function(){
  MarkhLine$new()$build_fn()()
}
