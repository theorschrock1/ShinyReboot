#' @export
AoProto <- R6::R6Class("AoProto",
                      public=list(
                        aes=ops(),
                        layer_params=ops(),
                        extra_params=ops(),
                        params=list(),
                        initialize = function(){
                          self$aes=expr_eval(.D(!!!self$aes))
                        },
                        check_aes=function(data){
                          self$aes$check_required(data)


                          self$aes$use_defaults(data)
                          self$params$flipped_aes=self$aes$flipped_aes
                          self$params
                        },
                        setup_params = function(data, params,scales,...) {
                          params
                        },
                        setup_data = function(data, params,scales) {
                          data
                        },
                        compute_layer = function(data, params=self$params,scales=NULL) {
                          params=self$check_aes(data)
                          params<-self$setup_params(data=data,params=params,scales=scales)
                          data<-self$setup_data(data=data,params=params,scales=scales)
                          layer_params=params[names(params)%in%self$parameters()]

                          args <- c(list(data = data, scales = scales), layer_params)
                          data<-do.call(self$compute_panel, args)

                          data
                        },
                        compute_panel = function(data, scales, ...) {

                          groups=c('group',names(data)%grep%"GRP\\d+$",'xgrid','ygrid','PANEL')

                          data[,self$compute_group(.SD,scales=scales,...),keyby=c(groups)]

                        },
                        compute_group = function(data, scales) {
                          abort("Not implemented")
                        },
                        finish_layer = function(data, ...) {
                          data
                        },
                        parameters = function(extra = FALSE) {
                          # Look first in compute_panel. If it contains ... then look in compute_group

                          panel_args <- names(formals(self$compute_panel))
                          group_args <- names(formals(self$compute_group))
                          args <- if ("..." %in% panel_args) group_args else panel_args

                          # Remove arguments of defaults
                          args <- setdiff(args, names(formals(AoProto$new()$compute_group)))

                          if (extra) {
                            args <- union(args, self$extra_params)
                          }
                          args
                        },
                        build_fn=function(layer_params=self$layer_params,extra_params=self$extra_params){
                          init<-parse_expr(glue('self={class(self)[1]}$new()'))


                          args=c(layer_params,extra_params)
                          assign_params=call_args(expr({self$params=list()}))[[1]]
                          if(nlen0(args))
                            assign_params=call_args(expr({self$params=args}))[[1]]
                          body=expr({
                            !!init
                            !!assign_params
                            self
                          })
                          build_fn_expr(args=args,body=body)
                        },
                        position_types=function(scales){
                          if(is.null(scales))
                            return('no-scales')
                          x='continuous'
                          y='continuous'
                          if(scales$x$is_discrete)
                            x='discrete'
                          if(scales$y$is_discrete)
                            y='discrete'
                          list(x=x,y=y)
                        },
                        position_group_aes=function(x){
                          coords=names(x)
                          tmp=unlist(x)
                          out=coords[tmp=='discrete']
                          if(l(out)>0)
                            out=out[1]
                          out
                        }
                      ),
                      private = list(),
                      active=list()
)

