CRange <- R6::R6Class(
  "CRange",
  inherit =ContinuousRange,
  public = list(
    mul=NULL,
    add=NULL,
    zero_width=1,
    initialize = function(range=NULL) {

      super$initialize()
      self$train(range)

    }
  ),
  private = list(

                 ),
  active = list(

  )
)
