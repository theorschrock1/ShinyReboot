#' @export
PositionAO <-R6::R6Class("PositionAO",
                         inherit=AoProto,
                         public=list(

                           initialize=function(position){
                             super$initialize()
                             self$position=position
                           },
                           setup_params = function(data,params,scales) {
                             params
                           },
                           calc_lims=function(coord,type,data){
                             names=paste0(coord,c('min','max','pos'))
                             if(type=='discrete'){
                               bandwd<-resolution(data[[coord]],zero=FALSE)/2
                               data[, c(names):=.(.SD[[1]] - bandwd, .SD[[1]] +  bandwd,TRUE),.SDcols =  coord]
                             }
                             if(type=='continuous'){
                               data[, c(names) := .(pmin(.SD[[1]],0),pmax(.SD[[1]],0),.SD[[1]]>0), .SDcols =coord]
                               v0=paste0(coord,'0')
                               vS=paste0(coord,'lower')
                               data[,c(vS):=min(.SD),.SDcols=paste0(coord,c('min'))]
                               data[,c(v0):=pmax(unique(.SD[[vS]]),0)]
                             }
                           },
                           setup_data = function(data, params,scales,...) {
                             data[,position:=self$flex_position]
                             discrete_aes<-scales$get_pos_discrete_aes()
                             lapply(discrete_aes,function(x){
                               self$calc_lims(x,'discrete',data)
                             })

                             data

                           },
                           compute_panel = function(data, params,...) {
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
PositionTreeMap <-R6::R6Class("PositionTreeMap",
                               inherit = PositionAO,
                               public=list(
                                 aes=ops(area=),
                                 setup_data=function(data,scales,...){
                                   if(!is.numeric(data$area))
                                     g_stop("area must be continuous")
                                   data%nget%c(x_aes(),y_aes())
                                 },
                                 setup_params = function(data,scales,params) {
                                  params$groups=names(data)%grep%"GRP\\d"
                                  params
                                 },
                                 compute_panel=function(data,scales,groups){

                                  data=treemap(data,groups=groups)
                                  if(is.null(scales$x))
                                  scales$add(get_scale_default('x',data$xmax))
                                  if(is.null(scales$y))
                                  scales$add(get_scale_default('y',data$ymax))
                                  data
                                 }
                               ),
                               private=list(.init=FALSE),
                               active=list(
                                 position = function(value) {
                                   if (missing(value)) {
                                     return(private$.position)
                                   }
                                   private$.position <-
                                     assert_choice(value, c('treemap'))

                                 },
                                 flex_position = function(value) {
                                   if (missing(value)) {
                                     return('position-treemap')
                                   }
                                   stop("flex_position is read only")

                                 }
                               ))
#' @export
PositionJitterAO <-R6::R6Class("PositionJitterAO",
                         inherit = PositionAO,
                         public=list(
                           layer_params = ops(
                             jitter_vars = subset(character(0L),
                                                  choices =c('x', 'y'))),
                           params=list(jitter_vars=character(0)),
                           setup_params = function(data,scales,params) {
                           if(len0(params$jitter_vars)){
                             jitter_vars=scales$get_pos_discrete_aes()
                           if (len0(jitter_vars))
                             jitter_vars=scales$get_pos_continuous_aes()
                           }
                            params$amount<-
                              lapply(jitter_vars,function(coord) resolution(data[[coord]], zero = FALSE) * 0.4) %>%unlist()
                             params$jitter_vars=jitter_vars

                           params
                           },
                           compute_panel = function(data, scales,jitter_vars,amount) {
                            if(is.null(amount))
                              return(data)

                             data[,c(jitter_vars):=map2(.SD,amount,jitter,factor=1),.SDcols=jitter_vars]
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
                    aes=ops(x=,y=),
                    stack_vars=c('min','max'),
                    layer_params=ops(fill=TF(FALSE)),
                    params=list(fill=FALSE),
                    setup_params = function(data,params,scales) {
                    # if(nnull(data$flipped_aes)){
                    #  if(isTRUE(data$flipped_aes[1])){
                    #    params$stack_vars<-paste0('x',self$stack_vars)
                    #    params$pos_group= 'y'
                    #    params$stack_coord='x'
                    #    params$npos_groups=scales$get_npos_discrete_aes()
                    #
                    #  }else{
                    #    params$stack_vars<-paste0('y',self$stack_vars)
                    #    params$pos_group= 'x'
                    #    params$stack_coord='y'
                    #    params$npos_groups=scales$get_npos_discrete_aes()
                    #
                    #  }
                    #     return(params)
                    # }
                     position_group=scales$get_pos_discrete_aes()
                     if(is.null(position_group))
                       g_stop('stack requires x|y to be discrete')
                     stack_coord=scales$get_pos_continuous_aes()
                     if(is.null(stack_coord))
                       g_stop('stack requires x|y to be continuous')

                     params$stack_vars<-paste0(stack_coord,self$stack_vars)
                     params$pos_group= position_group
                     params$stack_coord=stack_coord
                     params$npos_groups=scales$get_npos_discrete_aes()
                     params

                    },
                    setup_data = function(data, params,scales,...) {
                      data[,position:=self$flex_position]
                      ptypes=self$position_types(scales)
                      self$calc_lims('x',ptypes$x,data)
                      self$calc_lims('y',ptypes$y,data)

                      data

                    },
                    compute_panel = function(data,scales,stack_vars,fill=FALSE,pos_group,stack_coord,npos_groups=NULL) {
                      group_aes=c(pos_group,npos_groups)
                      setkeyv(data,c(pos_group,npos_groups))

                      dnames=names(copy(data))

                      sdcols=stack_vars

                      grps=pos_group


                      nonp_grps=npos_groups
                      if(self$position=='dodge'){
                        grps=c(pos_group, nonp_grps)
                      }
                      maxv<-sdcols%grep%"max"
                      minv<-sdcols%grep%"min"
                      coord=stack_coord
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

                      setkeyv(data,c("PANEL",group_aes))
                      data<-data%get%dnames


                      if(self$position=='fill'){
                       coord=stack_coord
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
    treemap = function(value) {
      if (missing(value)) {
        return(PositionTreeMap$new(position='treemap'))
      }
      stop("identity is read only")

    },
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



