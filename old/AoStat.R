#' @export
AoStat <- R6::R6Class("AoStat",
                      public=list(
                        retransform = TRUE,
                        aes=opts(),
                        stat_params=opts(),
                        extra_param=opts(),
                        params=list(),
                        initialize = function(...){
                          self$aes=expr_eval(.D(!!!self$aes))
                        },
                        check_aes=function(data){
                          self$aes$check_required(data)
                        },
                        set_after_stat_mapping=function(data,scales=NULL,replace=FALSE){
                          self$aes$map_after_stat(data=data,scales=scales,replace=replace)
                          data
                        },
                        setup_params = function(data, params) {
                          params
                        },
                        setup_data = function(data, params) {
                          data= self$aes$use_defaults(data)
                          data
                        },
                        compute_layer = function(data, params=self$params,scales=NULL) {
                          self$check_aes(data)
                          params<-self$setup_params(data,params)
                          data<-self$setup_data(data,params)
                          stat_params=params[self$parameters()]
                          args <- c(list(data = data, scales = scales), stat_params)
                          data<-do.call(self$compute_panel, args)

                          data<-self$set_after_stat_mapping(data,scales)
                          data
                        },
                        compute_panel = function(data, scales, ...) {
                          data[,self$compute_group(.SD,scales=scales,...),by=.(group,xgrid,ygrid,PANEL)]
                        },
                        compute_group = function(data, scales) {
                          abort("Not implemented")
                        },
                        finish_layer = function(data, params) {
                          data
                        },
                        parameters = function(extra = FALSE) {
                          # Look first in compute_panel. If it contains ... then look in compute_group

                          panel_args <- names(formals(self$compute_panel))
                          group_args <- names(formals(self$compute_group))
                          args <- if ("..." %in% panel_args) group_args else panel_args

                          # Remove arguments of defaults
                          args <- setdiff(args, names(formals(AoStat$new()$compute_group)))

                          if (extra) {
                            args <- union(args, self$extra_params)
                          }
                          args
                        },
                        build_stat_fn=function(stat_params=self$stat_params,extra_params=self$extra_params){
                          init<-parse_expr(glue('self={class(self)[1]}$new()'))

                          body=expr({
                            !!init
                            self$params=args
                            self
                          })
                          args=c(stat_params,extra_params)
                          build_fn_expr(args=args,body=body)
                        }
                      ),
                      private = list(),
                      active=list(

                      )
)
#' @export
StatNone = R6::R6Class(
  'StatNone',
  inherit=AoStat,
  public = list(
    compute_panel = function(data,params=NULL,scales=NULL,...) {
      data
    }
  ),
  private = list(.init=FALSE),
  active = list()
)
#' @export
stat_none=function(){
  StatNone$new()
}
