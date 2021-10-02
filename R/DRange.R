DRange <- R6::R6Class(
  "DRange",
  public = list(
    initialize = function(range=NULL,weights=NULL) {
      private$.range=DiscreteRange$new()
      if(nnull(range))
         self$train(range,weights=weights)


    },
    train=function(x,weights=1,...){
      weights=weights%or%1
      assert_numeric(weights,lower = 0)
     tmp=data.table(range=x)
     tmp[,wts:=weights]
     if(nnull(self$prv$.wts))
         tmp<-rbindlist(list(self$prv$.wts,tmp))
     setkey(tmp,range)
     self$prv$.wts<-unique(tmp)
     self$prv$.range$train(x,...)
    },
    reset=function(){
      private$.wts=NULL
      private$.range$reset()
    }
  ),
  private = list(
    .wts=NULL,
    .range=NULL),
  active = list(
    range = function(value) {
    if (missing(value)) {
      rng=self$prv$.range$range
      return(new_Discrete(self$prv$.range$range,weights = self$prv$.wts[rng]$wts))
    }
    stop("range is read only")

},
    prv = function(value) {
      if (missing(value)) {
        return(private)
      }
      private<-value

    }
  )
)
