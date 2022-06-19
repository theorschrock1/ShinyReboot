#' @export
AoStat <- R6::R6Class("AoStat",
          inherit = AoProto,
          public=list(
                set_after_stat_mapping=function(data,scales=NULL,replace=FALSE){
                  self$aes$map_after_stat(data=data,scales=scales,replace=replace)
                 data
                },
                finish_layer = function(data,scales,params=list(),...) {
                  data<-self$set_after_stat_mapping(data=data,scales=scales)
                  data
                },
                compute_panel = function(data, scales, ...) {

                  groups=c('group',names(data)%grep%"GRP\\d+$",'xgrid','ygrid','PANEL')

                  out<-data[,self$compute_group(.SD,scales=scales,...),keyby=c(groups)]
                  extravars<-c(scales$get_discrete_aes()%NIN%names(out))
                  if(nlen0(extravars)){
                  extra=data[,lapply(.SD,unique),keyby=c(groups),.SDcols=  extravars]
                  out=out[extra]
                  }
                  out
                }
                ))
#' @export
StatNone <- R6::R6Class("StatNone",
                      inherit = AoStat,
                      public=list(
                        finish_layer = function(data,scales,...) {

                          data
                        },
                        compute_panel=function(data,scales,...){
                          data
                        }
                      ))

#' @export
stat_none=function(){
StatNone$new()$build_fn()()
}
