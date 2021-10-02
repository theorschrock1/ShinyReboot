#' @export
discrete_grid_template <- function(x = character(),sizes=1,name=NULL) {
  assert_character(x)
  name=name%or%'grid'
  if(length(sizes)==1)
    sizes=rep(sizes,length(x))
  if(length(sizes)!=length(x))
    stop("sizes must be length 1 or length(groups))")

  g_start=paste0(name,'-start')
  g_end=paste0(name,'-end')
  starts= c(paste0(x,'-start'),g_end)
  ends= c(g_start,paste0(x,'-end'))
  siz=paste0(signif(sizes/median(sizes),5),"fr")
  weave(paste0("[",starts," ",ends,"]"),siz)%sep%" "
}


bin_grid_template <- function(breaks,lims,line_name='grp',name='y') {

  name=name%or%'grid'
  x=glue("{name}{line_name}{1:(l(breaks)-1)}")


  g_start=paste0("[",name,'-start',"]")
  g_end=paste0("[",name,'-end',"]")
  starts= c(paste0(x[1:length(x)],'-start'),"")
  ends= c("",paste0(x[1:length(x)],'-end'))
 breakAreas=paste0("[",starts," ",ends,"]")
  sizes=c(min(lims),sort(breaks),max(lims)) %>% diff()
  siz=paste0(signif(sizes/median(sizes),5),"fr")
  if(name=='y')
    return(paste( g_end, weave(rev(siz),paste0("[",starts," ",ends,"]"))%sep%" ", g_start))
  paste( g_start, weave(siz,paste0("[",starts," ",ends,"]"))%sep%" ", g_end)
}
#' @export
continuous_grid_template <- function(breaks,lims=NULL,line_size=0,grid_name=NULL,line_name=NULL) {
  assert_numeric(breaks)
  line_name=line_name%or%"line"
  name=grid_name%or%"grid"
  if(is.null(lims))
    lims=range(breaks)
  if(length(breaks)==1){
    return(glue("[{name}-start] 1fr [{name}{line_name}1-start] {line_size} [{name}{line_name}1-end] 1fr [{name}-start]"))
  }
  break_names=glue("{name}{line_name}{1:l(breaks)}")
  break_names[breaks==0]<-glue('{name}zero{line_name}')

  g_start=paste0("[",name,'-start',"]")
  g_end=paste0("[",name,'-end',"]")
  starts= paste0("[", break_names,'-start',"]")
  ends= paste0("[", break_names,'-end',"]")
  lines=paste(starts,line_size,ends)
  sizes=c(min(lims),sort(breaks),max(lims)) %>% diff()
  siz=paste0(signif(sizes/median(sizes),5),"fr")
  if(name=='y')
    siz=rev(siz)
  weave(c(g_start,lines,g_end),siz)%sep%" "
}


#' @export
continuous_grid_areas=function(breaks,grid_name=NULL,line_name=NULL){
  line_name=line_name%or%"line"
  name=grid_name%or%"grid"
  break_names=glue("{grid_name}{line_name}{1:l(breaks)}")
  break_names[breaks==0]<-glue('{grid_name}zero{line_name}')
  break_names
}

#' @export
discrete_grid_areas=function(x,group_name='grp'){
  range<-unique(x)
  domain<-paste0(group_name,seq_along(x))
  map_ordinal(x,range,domain)
}


map_facet_areas=function(x,group_name){
  index=1:length(x)
  t2<-lapply(index,function(i){
  out<-paste0(group_name,i,discrete_grid_areas(x[[i]],group_name='grp'))
  data.table(label=x[[i]],grid_area=out)
  })
  names(t2)<-names(x)
  t2
}
