#' @export
MarkArea = R6::R6Class(
  'MarkArea',
  inherit=MarkPoly,
  public = list(
    mark_template = ops(
      polygon(
        points = '{gen_area(x,y,y0,xmin)}',
        fill = '{fill[1]}',
        stroke = '{fill[1]}',
        stroke.width = '{size[1]}',
        fill.opacity='{opacity[1]}'
      )),
    aes=ops(x=,y=,y0=,xmin=,opacity=.1,fill='#4E79A7FF', size = '.5',flippable=TRUE),
    setup_data=function(data,params,scales,...){
      if(isTRUE(data$flipped_aes))
        flip_data(data)
      data
    }
  ),
  private = list(.init=FALSE),
  active = list()
)
mark_area=function(){
  MarkArea$new()$build_fn()()
}
#' @export
gen_area=function(x,y,y0,xmin){
  paste(line_coords(rev(xmin),rev(y0)),line_coords(x,y),sep=',')
}
