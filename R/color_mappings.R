#' @export
fmatch=function(x,y){
  x_range<-x
  y_range<-y
  function(x){
    y_range[fastmatch::fmatch(x,x_range)]
  }
}

#' @export
map_ordinal=function(x,range,domain){
  #discrete input / discrete output
  fmatch(x=range,y=domain)(x)
}

#' @export
map_color_continuous=function(x,range=c(0,1),domain){
  #continuous input / continuous output
  assert_numeric(range,lower=0,upper=1,min.len = 2)
  pal<-colorRamp(domain)
  rescaler=seq(0,1,length.out=length(range))
  xout<-approx(x=  rescaler,y=range,xout=rescale(x))$y

  return(rgb(pal(xout), maxColorValue=255))
}
#map_color_continuous(x=0:10,domain=c('red','green','blue'))
#move center
#map_continuous(x=0:10,range=c(0,.8,1),domain=c('red','green','blue'))

#' @export
map_quantile=function(x,domain){
  #continuous input / discrete output
  ln=length(domain)+1
  drange=seq(0, 1,length.out=ln)
  x2=approx(range(x),y=c(0,1),xout=x)$y
  signs="<="
  formula= glue('x2{signs}{drange[-1]},"{domain}"')%sep%','
  glue('fcase({formula})') %>% parse_expr() %>% eval()
}

#' @export
map_threshold=function(x,breaks,domain){
  #continuous input / discrete output
  assert_length(breaks,length(domain)-1)
  domain=c(domain,last(domain))
  yright=max(breaks)
  yleft=min(breaks)-resolution(breaks)
  x2=approx(breaks,breaks,method = 'constant',xout=x,yright = yright,yleft=yleft)$y
  map_ordinal(  x2,range=c(yleft,breaks),domain)
}
#map_threshold(x=0:10,breaks=c(3,8),domain=c('red','green','blue'))
#
# map_threshold(x=-10:10,breaks=c(0),domain=c('start','zeroline'))
# map_threshold(x=-10:10,breaks=c(0),domain=c('end','zeroline'))
# look=data.table(xmin=c(-5:-1,rep(0,5)),xmax=c(rep(0,5),1:5))
# look[,gridmax:=map_threshold(x=-xmax,breaks=c(0),domain=c('end','zeroline'))]
# look[,gridmin:=map_threshold(x=xmin,breaks=c(0),domain=c('start','zeroline'))]

#' @export
map_bin=function(x,breaks,domain,leftout,rightout){
domain=c(leftout,domain,rightout)
map_threshold(x,breaks,domain)
}
