#' @export
MarkPoly = R6::R6Class(
  'MarkPoly',
  inherit=MarkSVG,
  public = list(
    mark_template = ops(
      polygon(
        points = '{line_coords(x,y)}',
        fill = '{fill[1]}',
        stroke = '{color[1]}',
        stroke.width = '{size[1]}'
      )),
    aes=ops(x=,y=,color='white',fill='#4E79A7FF', size = '0')
  ),
  private = list(.init=FALSE),
  active = list()
)
mark_poly=function(){
  MarkPoly$new()
}
#' @export
MarkContour = R6::R6Class(
  'MarkContour',
  inherit=MarkPoly,
  public = list(
    compute_group = function(data, scales) {
      data[,self$draw_group(.(V1=self$draw_mark(.SD))),by=.(subgroup,group)]
    }
  ),
  private = list(.init=FALSE),
  active = list()
)
mark_contour=function(...){
  MarkContour$new()$build_fn()(...)
}




#' @export
MarkHex = R6::R6Class(
  'MarkHex',
  inherit=MarkPoly,
  public = list(
    mark_template = ops(
      polygon(
        points = '{points}',
        fill = '{fill}',
        stroke = '{color}',
        stroke.width = '{size}'
      )),
    setup_data=function(data,...){
     data=super$setup_data(data,...)
     dx <- resolution(round(data$x,8), FALSE)
     dy <- resolution(round(data$y,8), FALSE) / sqrt(3) / 2 * 1.15

     hex <- hexbin::hexcoords(dx, dy, n = 1)
     data[,binid:=1:nrow(data)]
   setkey(data,binid)
    data[,points:=paste(signif(x+ hex$x,8),signif(y+hex$y,8),sep=',')%sep%" ",by=binid]

     data
    }
  ),
  private = list(.init=FALSE))
#' @export
mark_hex=function(...){
  MarkHex$new()$build_fn()(...)
}
  line_coords=function(x,y){
  paste(signif(x),signif(y),sep=",")%sep%" "
}


#'
#'
#'
#' #' @export
#' MarkPoly = R6::R6Class(
#'   'MarkPoly',
#'   inherit=MarkSVG,
#'   public = list(
#'     name='poly',
#'     tag='polygon',
#'     required_aes=c('x','y'),
#'     html_mapping=list(points='points',fill='fill',stroke='color',stroke.width='size'),
#'     defaults=list(color='white',fill='#4E79A7FF', size = '0'),
#'     params=list(y='discrete',x='continuous'),
#'     render=function(data,...){
#'       if(is.null(tag))
#'         abort("Missing tag name")
#'       self$use_defaults(data)
#'
#'       draw_mark<-mark_fn(self$tag,attrs = self$html_mapping,formats=self$formats,close=TRUE)
#'       # print(data)
#'       data[,marks:=draw_mark(.SD,...)]
#'     },
#'     setup_mark=function(data){
#'       data[,c(points):=paste(x,y,sep=',')]
#'
#'     }
#'   ),
#'   private = list(.init=FALSE),
#'   active = list()
#' )
#' mark_poly=function(){
#'   MarkPoly$new()
#' }
#' #' @export
#' MarkHex = R6::R6Class(
#'   'MarkHex',
#'   inherit=MarkPoly,
#'   public = list(
#'     setup_mark=function(data){
#'       dx <- resolution(round(data$x,8), FALSE)
#'       dy <- resolution(round(data$y,8), FALSE) / sqrt(3) / 2 * 1.15
#'
#'       hex <- hexbin::hexcoords(dx, dy, n = 1)
#'
#'       data[,binid:=1:nrow(data)]
#'       data[,points:=paste(signif(x+ hex$x,8),signif(y+hex$y,8),sep=',')%sep%" ",by=binid]
#'      data
#'     }
#'   ),
#'   private = list(.init=FALSE))
#' mark_hex=function(){
#'   MarkHex$new()
#' }
