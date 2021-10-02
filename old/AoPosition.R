#' @export
PositionAO <-R6::R6Class("PositionAO",
                         public=list(
                           initialize=function(position){

                             self$position=position
                           },
                           setup_params = function(data,params) {
                             params
                           },
                           setup_data = function(data, params,...) {
                             data[,position:=self$flex_position]
                             data

                           },
                           compute_layer = function(data, params) {
                             data
                           }),
                         private=list(
                           .position=NULL
                         ),
                         active=list(
                           position = function(value) {
                             if (missing(value)) {
                               return(private$.position)
                             }
                             private$.position <-
                               assert_choice(value, c('identity'))
                           },
                           flex_position = function(value) {
                             if (missing(value)) {
                               return( 'position-identity')
                             }
                             stop("flex_position is read only")

                           }
                         )


)
#' @export
PositionJitterAO <-R6::R6Class("PositionJitterAO",
                               inherit = PositionAO,
                               public=list(
                                 required_aes = c('x','y'),
                                 setup_params = function(data,params) {
                                   coord= params$position_group_aes
                                   if (nnull(coord)){
                                     params$amount = resolution(data[[coord]], zero = FALSE) * 0.4
                                     params$coord=coord
                                   }
                                   params
                                 },
                                 compute_layer = function(data, params) {
                                   if(is.null( params$amount))
                                     return(data)
                                   var=params$coord
                                   data[,c(var):=jitter(.SD[[var]],amount = params$amount)]
                                   data
                                 }),
                               private=list(.init=FALSE),
                               active=list(
                                 position = function(value) {
                                   if (missing(value)) {
                                     return(private$.position)
                                   }
                                   private$.position <-
                                     assert_choice(value, c('jitter'))

                                 },
                                 flex_position = function(value) {
                                   if (missing(value)) {
                                     return('position-identity')
                                   }
                                   stop("flex_position is read only")

                                 }
                               ))


#' @export
PositionStackAO <-R6::R6Class("PositionStackAO",
                              inherit = PositionAO,
                              public=list(
                                initialize=function(...){
                                  self$super_init(...)
                                },
                                super_init=import_fn(super_init),
                                required_aes = character(),
                                stack_vars=c('min','max'),
                                setup_params = function(data,params) {
                                  if(!params$flipped_aes){
                                    params$stack_vars<-paste0('x', self$stack_vars)
                                    params$stack_coord<-"x"
                                  }else{
                                    params$stack_vars<-paste0('y', self$stack_vars)
                                    params$stack_coord<-"y"
                                  }

                                  params
                                },
                                compute_layer = function(data, params) {
                                  setkeyv(data,params$group_aes)

                                  dnames=names(copy(data))

                                  sdcols=params$stack_vars

                                  grps=params$position_group_aes


                                  nonp_grps=params$group_aes%NIN% grps
                                  if(self$position=='dodge'){
                                    grps=params$group_aes
                                  }
                                  maxv<-sdcols%grep%"max"
                                  minv<-sdcols%grep%"min"
                                  coord=params$stack_coord
                                  pos=paste0(coord,'pos')
                                  setnames(data,c(minv,maxv),c("omin",'omax'))
                                  nonp_key=rep(1L,length(    nonp_grps))

                                  setorderv(data,c(nonp_grps,'omax'),c( nonp_key,-1L))
                                  #data[,c('pmax','pmin'):=self$compute_position(omax),by=c(grps,"PANEL")]
                                  data[,c('pmax','pmin') := .(cumsum(omax),
                                                              cumsum(shift(omax, type = 'lag', fill =
                                                                             0))), by = c(grps, "PANEL")]
                                  data[,nmax:=fifelse(omin<0,abs(omin),0)]
                                  setorderv(data,c(nonp_grps,'nmax'),c( nonp_key,-1L))
                                  #data[,c('nmax','nmin'):=self$compute_position(omin),by=c(grps,"PANEL")]
                                  data[,c('nmax','nmin'):= .(cumsum(omin),
                                                             cumsum(shift(omin, type = 'lag', fill =
                                                                            0))), by = c(grps, "PANEL")]
                                  data[,c(maxv):=fifelse(omin<0,-nmin,pmax)]
                                  data[,c(minv):=fifelse(omax>0,pmin,-nmax)]

                                  setkeyv(data,c("PANEL",params$group_aes))
                                  data<-data%get%dnames


                                  if(self$position=='fill'){
                                    coord=params$stack_coord
                                    data[,c(maxv,minv,coord):= .SD/(abs(max(.SD))+abs(min(.SD))),.SDcols=c(maxv,minv,coord),by=c(grps,"PANEL")]
                                  }
                                  data[data[[pos]],c(coord):=.SD[[maxv]]]
                                  data[!data[[pos]],c(coord):=-.SD[[minv]]]
                                  data[!data[[pos]],c(minv):=-.SD[[minv]]]
                                },
                                compute_position=function(x){
                                  tmp=data.table(max=x)
                                  tmp[,min:=shift(max,type='lag',fill=0)]

                                  tmp[,lapply(.SD,cumsum)]
                                }),
                              private=list(.init=FALSE),
                              active=list(
                                position = function(value) {
                                  if (missing(value)) {
                                    return(private$.position)
                                  }
                                  private$.position <-
                                    assert_choice(value, c('fill', 'stack', 'dodge'))

                                },
                                flex_position = function(value) {
                                  if (missing(value)) {
                                    out=switch(private$.position,
                                               'fill'='position-stack position-fill',
                                               'stack'='position-stack',
                                               'dodge'='position-dodge',
                                    )
                                    return(out)
                                  }
                                  stop("flex_position is read only")

                                }
                              ))


PositionsAO = R6Class(
  'PositionsAO',
  public = list(
    initialize = function() {

    }
  ),
  private = list(),
  active = list(
    identity = function(value) {
      if (missing(value)) {
        return(PositionAO$new(position='identity'))
      }
      stop("identity is read only")

    },
    stack = function(value) {
      if (missing(value)) {
        return(PositionStackAO$new(position='stack'))
      }
      stop("identity is read only")

    },
    dodge = function(value) {
      if (missing(value)) {
        return(PositionStackAO$new(position='dodge'))
      }
      stop("dodge is read only")

    },
    fill=function(value){
      if (missing(value)) {
        return(PositionStackAO$new(position='fill'))
      }
      stop("fill is read only")
    },
    jitter=function(value){
      if (missing(value)) {
        return(PositionJitterAO$new(position='jitter'))
      }
      stop("jitter is read only")
    }
  )
)

#' @export
position=function(type){
  position=PositionsAO$new()
  position[[type]]
}


