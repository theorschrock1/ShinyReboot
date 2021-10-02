#' @export
default_scale_type=function(x){
  if(is(x,'binned'))
    return("binned")
  if(is(x,'numeric')){
    return('continuous')
  }
  'discrete'
}
#' @export
scale_y=function(type,aes,...){
  assert_choice(type,c('continuous','discrete','binned'))
  switch(type,
         'binned'=scale_binned_y(aes=aes,...),
         'date'=scale_binned_y(aes=aes,...),
         'continuous'=scale_continuous_y(aes=aes,...),
         'discrete'=scale_discrete_y(aes=aes,...))
}
#' @export
scale_x=function(type,aes,...){
  assert_choice(type,c('continuous','discrete','binned'))
  switch(type,
         'binned'=scale_binned_x(aes=aes,...),
         'continuous'=scale_continuous_x(aes=aes,...),
         'discrete'=scale_discrete_x(aes=aes,...))
}
#' @export
scale_fill=function(type,...){
  assert_choice(type,c('continuous','discrete'))
  switch(type,
         'continuous'=scale_continuous_fill(aes='fill',...),
         'discrete'=scale_discrete_fill(aes='fill',...))
}
#' @export
scale_color=function(type,...){
  assert_choice(type,c('continuous','discrete'))
  switch(type,
         'continuous'=scale_continuous_fill(aes='color',...),
         'discrete'=scale_discrete_fill(aes='color',...))
}
#' @export
scale_shape=function(type,...){
  assert_choice(type,c('discrete'))
  scale_shape_discrete(aes='shape',...)
}
#' @export
non_position_scales=function(name,type,...){
 out= switch(name,
         'fill'=scale_fill(type,...),
         'color'=scale_color(type,...),
         'size'=scale_size(type,...),
         "alpha"=g_stop("{name} not implemented"),
         "angle"=g_stop("{name} not implemented"),
         "hjust"=g_stop("{name} not implemented"),
         "vjust"=g_stop("{name} not implemented"),
         "label"=NULL,
         'area'=NULL,
         "linetype"=g_stop("{name} not implemented"),
         "radius"=g_stop("{name} not implemented"),
         "shape"=scale_shape(type,...),
         "weight"=g_stop("{name} not implemented"))
 out
}
#' @export
get_scale_default=function(name,x,...){
  type=default_scale_type(x)
  out= switch(name,
              'x'=scale_x(type,x_aes(),...),
              'y'=scale_y(type,y_aes(),...),
              'fill'=scale_fill(type,...),
              'color'=scale_color(type,...),
              'size'=scale_size(type,...),
              'area'=NULL,
              "alpha"=g_stop("{name} not implemented"),
              "angle"=g_stop("{name} not implemented"),
              "hjust"=g_stop("{name} not implemented"),
              "vjust"=g_stop("{name} not implemented"),
              "label"=g_stop("{name} not implemented"),
              "linetype"=g_stop("{name} not implemented"),
              "radius"=g_stop("{name} not implemented"),
              "shape"=scale_shape(type,...),
              "weight"=g_stop("{name} not implemented"))
  out
}

