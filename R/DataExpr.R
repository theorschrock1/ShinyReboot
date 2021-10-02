#' @export
DataExpr = R6Class(
  'DataExpr',
  public = list(
    items=list(),
    flipped_aes =FALSE,
    initialize = function(...) {
     data_vars <- enexprs(...)

     assert_names( names(data_vars))
     x=names(data_vars)
    if(any(duplicated(x)))
      g_stop('duplicated name(s) found `{x[duplicated(x)]%sep%","}` in data expr')
      if(any(names(data_vars)%in%"flippable")){
        self$flippable<-data_vars$flippable
      data_vars=data_vars%nget%'flippable'
      }

     self$items=data_vars
    },
    check_required=function(data,names=self$required){
      if(self$flippable){

      assert(
      check_names(names(data),must.include = names),
      check_names(switch_orintation(names(data)),must.include = names)
      )
      self$flipped_aes = !isTRUE(check_names(names(data), must.include = names))
      }else{
      assert_names(names(data),must.include = names)
      }
    },
    use_defaults=function(data,defaults=self$defaults){
     defaults<-defaults%nget%names(data)
     if(nlen0(defaults)){
     eval(expr(data[,`:=`(!!!defaults)]))
     }
     data
    },
    map_after_stat=function(data,scales=NULL,stat_vars=self$svars,replace=FALSE){
      if(!is_empty(stat_vars)){
     self$check_required(data,names=stat_vars)
     data[,c(names(stat_vars)):=.SD,.SDcols=stat_vars]
      if(!is_empty(scales)){
       lapply(names(stat_vars),function(x){
       scales$add(get_scale_default(x,data[[x]]),replace=replace)
       })
      }}
      data
      }
  ),
  private = list(
    .flippable=FALSE
  ),
  active = list(
    required = function(value) {
    if (missing(value)) {
      if(len0(self$items))
        return(character())
      return(names(self$items)[sapply(self$items,required_var)])
    }
    stop("required is read only")

},
    defaults = function(value) {
    if (missing(value)) {
      if(is_empty(self$items))
        return(self$items)
     req=flip_names(self$required,self$flipped_aes)

     items=self$items
     items<-flip_data(self$items,self$flipped_aes)
      out=items[names(items)%nin%c(self$snames,req)]
      return(out)
    }
    stop("defaults is read only")

},
    flippable=function(value){
      if(missing(value)){
        return(private$.flippable)
      }
      private$.flippable=assert_logical(value,len=1)
    },
    snames = function(value) {
    if (missing(value)) {
        out=drop_nulls(lapply(flip_data(self$items,self$flipped_aes),find_names_in_expr)[self$is_stat])

                return( names(out))
    }
    stop("snames is read only")

},
    svars = function(value) {
    if (missing(value)) {
        return(unlist(drop_nulls(lapply(flip_data(self$items,self$flipped_aes),find_names_in_expr)[self$is_stat])))
    }
    stop("svars is read only")

},
    is_stat = function(value) {
  if (missing(value)) {
    return(sapply(flip_data(self$items,self$flipped_aes),is_call,name='stat'))
  }
  stop("is_stat is read only")

}
  )
)
#' @export
.D=function(...){
 DataExpr$new(...)
}

required_var=function(x){
  type=expr_type(x)
  if(type!='symbol')
    return(FALSE)
  out=find_names_in_expr(x)
  if(is.null(out))
    return(FALSE)
  if(len0(out))
    return(TRUE)
  FALSE
  }

