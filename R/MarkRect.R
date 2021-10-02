#' @export
MarkRect <- R6::R6Class(
  "MarkRect ",
  inherit =MarkSVG,
  public = list(
    mark_template=ops(
      rect(
        x = '{xmin}',
        y = '{ymin}',
        width = '{xmax-xmin}',
        height = '{ymax-ymin}',
        fill="{fill}",
        stroke="{color}",
        stroke.width="{size}"
      )),
    aes = ops(
      xmin =,
      xmax =,
      ymin =,
      ymax =,
      fill ='#4E79A7FF',
      color ='#4E79A7FF',
      size='0'
    )
  ))


mark_rect=function(...){
MarkRect$new()$build_fn()(...)
}
