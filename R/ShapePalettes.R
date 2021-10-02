#' @export
get_shape_palette_dt=function(){
  tmp=ShapePalettes$new()
  tmp$get_palette_table()
}
#' @export
get_shape_palette=function(pal){
  tmp=ShapePalettes$new()
  assert_choice(pal,tmp$get_palnames())
  tmp[[pal]]
}

#' @export
ShapePalettes = R6::R6Class(
  'ShapePalettes',
  public = list(
    initialize = function() {

    },
    get_palette_table=function(){
      data.table(package='ShinyReboot',palette=self$get_palnames(),length=self$get_pal_len(),type='qualitative',path=self$get_palnames())

    },
    get_palnames=function(){
      names(ShapePalettes$active)
    },
    get_pal_len=function(){

      sapply(self$get_palnames(),function(x)length(self[[x]]))
    }
  ),
  private = list(),
  active = list(
    basic_shapes8 = function(value) {
      if (missing(value)) {
        return(c("square-outline",
                 "circle-outline",
                 "diamond-outline",
                 'plus-thick',
                 'svg',
                 "four-points-star",
                 "decagram",
                 "triagle-outline"))
      }
      stop("shapes6 is read only")

    },
    basic_shapes12 = function(value) {
      if (missing(value)) {
        return(
          c(
            "square",
            "circle",
            "diamond",
            "rhombus",
            "triagle",
            "hexagram",
            "decagram",
            "hexagon",
            "pentagon",
            "octigram",
            "four-points-star",
            "svg"
          )
        )
      }
      stop("shapes12 is read only")

    },
    basic_outline_12 = function(value) {
      if (missing(value)) {
        return(
          c(
            "square-outline",
            "circle-outline",
            "diamond-outline",
            "rhombus-outline",
            "triagle-outline",
            "hexagram-outline",
            "decagram-outline",
            "hexagon-outline",
            "pentagon-outline",
            "octigram-outline",
            "four-points-star-outline",
            "plus-outline"
          )
        )
      }
      stop("shapes12 is read only")

    },
    basic_shapes_all = function(value) {
      if (missing(value)) {
        return(unique(c(self$basic_shapes8,self$basic_shapes12,self$basic_outline_12)))
      }
      stop("basic_shapes_all is read only")

    }
  )
)
