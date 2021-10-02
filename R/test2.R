brck=function(...){
  paste0('[',paste(...),']')
}
grid_css=function(...,rows=NULL,cols=NULL,areas=NULL){
  if(nnull(areas)){
    if(is.data.table(areas))
      areas=areas[,reduce(.SD,paste)]
    areas=expr_label(areas)%sep%'\n'
  }
  css(display='grid',grid.template.rows=rows,grid.template.columns=cols,grid.template.areas=areas,...)
}
responsive_breaks=function(range,targets=c(2,3,5,9,17,33,47)){
  out<-unique(lapply(targets,function(x,max_t,range){
    if(x==max_t)
      return(breaks_extended(x,only.loose=TRUE)(range))
    breaks_extended(x)(range)
  },range=range,max_t=max(targets)))
  ra<-range(last(out))
  step=unique(abs(diff(last(out)[[1]])))
  out=lapply(out,function(x)x[x%inrange%ra])

  out<-out[sapply(out,function(x)l(x)>1)]

  lengths=sapply(out,length)
  out=out[!duplicated(lengths)]
  out<-out[1:min(5,l(out))]
  names=c('axis-xs','axis-sm','axis-md','axis-lg','axis-xl')[1:l(out)]

  labs<-map2(out,names,function(x,y){
    data.table(lab=x,size=y)
  }) %>% rbindlist()
  labs<-labs[,size%sep%" ",keyby=lab]
  setkey(labs)
  labs[,diff:=(lab-shift(lab))/step]
  frt=na.omit(labs[,.N,by=.(diff,rleid(diff))])
  labs[lab==min(ra)|lab==max(ra),V1:=paste(V1,'axis-xxs')]
  labs[lab==0,V1:=paste(V1,'zero-line')]
  labs[,grid:='axis-line']
  labs[lab==0,grid:=paste('zero-line')]
  setnames(labs,c("lab",'class','fr','grid'))
  labs
}
trans_responsive_breaks=function(range,add_breaks=NULL,targets=c(2,3,5,9,17,33,47),trans){
  out<-unique(lapply(targets,function(x,max_t,range){
   trans$breaks(x=range,n=x)
  },range=range,max_t=max(targets)))
  ra=range(out[[which.max(sapply(out,function(x)abs(max(x)-min(x))))]])
  out<-unique(lapply(targets,function(x,max_t,range){
    trans$breaks(x=range,n=x)
  },range=ra,max_t=max(targets)))
  #ra<-range(last(out))

  out=lapply(out,function(x)x[x%inrange%ra])

  out<-out[sapply(out,function(x)l(x)>1)]

  lengths=sapply(out,length)
  out=out[!duplicated(lengths)]
  out<-out[1:min(5,l(out))]


  names=c('axis-xs','axis-sm','axis-md','axis-lg','axis-xl')[1:l(out)]

  labs<-map2(out,names,function(x,y){
    data.table(lab=x,size=y)
  }) %>% rbindlist()


  if(nnull(add_breaks)){
    add=data.table(lab=round(add_breaks,np),size='d-none')
    labs=rbindlist(list(labs,add[lab%nin%labs$add]))
  }
  labs[,lab:=round(lab,8)]
  np=max(n_precision(labs[lab!=0]$lab))
  labs[,lab:=round(lab,np)]
  labs<-labs[,size%sep%" ",keyby=lab]
  setkey(labs,lab)

  labs[,diff:=round((lab-shift(lab)),np)]
  labs[,diff:=diff/min(diff,na.rm = T)]
  frt=na.omit(labs[,.N,by=.(diff,rleid(diff))])
  labs[lab==min(ra)|lab==max(ra),V1:=paste(V1,'axis-xxs')]
  labs[lab==0,V1:=paste(V1,'zero-line')]
  labs[,grid:='axis-line']
  labs[lab==0,grid:=paste('zero-line')]
  setnames(labs,c("lab",'class','fr','grid'))
  labs
}


#' @export
item_css=function(row=NULL,col=NULL,area=NULL,...){
    cond1=is.null(c(row,col,area))
    cond2=nnull(c(row,col))&nnull(area)
    cond3=is.null(area)&(is.null(row)|is.null(col))
    if(any(cond1,cond2,cond3))
      g_stop('grid item must have a row and col OR area')
    if(nnull(area)){
      out<-inline_style(grid.area=area,...)
    }else{
      out<-inline_style(grid.row=row,grid.column=col,...)
    }
    out

}

grid_row=function(start,end){
  paste(start,"/",end)
}
grid_col=function(start,end){
  paste(start,"/",end)
}
grid_area=function(row_start,col_start,row_end,col_end){
  collapse(row_start,col_start,row_end,col_end,sep=' / ')
}
inline_style=function(...){
  dots<-drop_nulls(assert_named(list(...)))
  names(dots)<-str_replace_all(names(dots),"\\.",'-')

  dots=map2(dots,names(dots),function(x,y){
    paste0(y,':',x,';')
  }) %>% reduce(paste0)
}
#' @export
discrete_axis=function(d_range,side='bottom',...){
  if(side%in%c('top','bottom')){
    axis='x'
  }else{
    axis='y'
  }
  labs=data.table(labs=d_range)

  labs[,rid:=.I]
  labs[,c('n_start','n_end'):=list(paste0('grp',.I,'-start'),
                                   paste0('grp',.I,'-end'))]
  start='graph-left'
  end='graph-right'
  if(axis=='y'){
    start='graph-top'
    end='graph-bottom'
  }

  labs[,c('size_start','size_end'):=list('1fr','.05rem')]
  labs[,gutter_start:=n_end]
  labs[,gutter_end:=shift(n_start,type='lead')]
  gutters=na.omit(labs[,.(labs='',n_start=gutter_start,n_end=gutter_end,class='gutter')])
  divs=rbind(labs[,.(labs=labs,n_start=n_start,n_end=n_end,class='axis-label')],gutters)
  divs[,c('a_start','a_end'):=.('axis_edge1','axis_edge2')]
  labs[.N,n_end:=paste(n_end,end)]
  labs[1,n_start:=paste(start,n_start)]
  ml=melt(labs,measure.vars = list(c('n_start','n_end'),c('size_start','size_end')))
  setkey(ml,rid,variable)
  setnames(ml,'variable','var1')
  ml[,rid:=.I]
  ml[nrow(ml),value2:=NA]

  ml[,value1:=brck(value1)]
  ml2=melt(ml,measure.vars=c('value1','value2'))
  setkey(ml2,rid,variable)
  #grid_css_out=na.omit(ml2$value)
  grid_css1=na.omit(ml2$value)%sep%" "
  grid_css2='[axis-edge1] auto [axis-edge2]'

  if(axis=='x'){
    divs[,grid_column:=paste0(n_start,'/',n_end)]
    divs[,grid_row:=paste0(a_start,'/',a_end)]
    grid_columns=grid_css1
    grid_rows=grid_css2
  }else{
    divs[,grid_column:=paste0(a_start,'/',a_end)]
    divs[,grid_row:=paste0(n_start,'/',n_end)]
    grid_rows=grid_css1
    grid_columns=grid_css2

  }

  divs[,style:=inline_style(grid.row=grid_row,grid.column=grid_column)]
  inner<-HTML(glue_data(divs,'<div class="{class}" data-name="{labs}" style="{style}">{labs}</div>'))
  list(div=div(class=glue('axis {axis}-axis'),style=grid_css(rows=grid_rows,cols=grid_columns,grid.area=glue('axis_{side}')),inner,...),grid=grid_css1,lines=NULL)
}
#' @export
continuous_axis=function(d_range,zero_min=TRUE,side='bottom',...){
  if(zero_min)
     d_range=c(0,d_range)
  d_range=sort(d_range)

  if(side%in%c('top','bottom')){
    axis='x'
  }else{
    axis='y'
  }
  labs=pretty_breaks(n=20)(d_range)
  labs=data.table(labs=labs)


  labs[,rid:=.I]
  labs[,lid:=rid-1]
  labs[,c('n_start','n_end'):=list(paste0(axis,'_axis_line',.I,'-start'),
                                   paste0(axis,'_axis_line',.I,'-end'))]
  start='graph-left'
  end='graph-right'
  if(axis=='y'){
    start='graph-top'
    end='graph-bottom'
  }
labs[,data_value:=labs]
  labs[,c('size_start','size_end'):=list('.05rem','1fr')]
  ticks=na.omit(labs[,.(lid=lid,labs='',data_value=data_value,n_start=n_start,n_end=n_start,class='axis-tick')])
  if(axis=='x'&&side=='top'|axis=='y'&&side=='left'){
    labs[,c('a_start','a_end'):=.('axis_edge1','axis_label')]
    ticks[,c('a_start','a_end','class'):=.('axis_label','axis_edge2','axis-tick')]
  }else{
    labs[,c('a_start','a_end'):=.('axis_label','axis_edge1')]
    ticks[,c('a_start','a_end','class'):=.('axis_edge2','axis_label','axis-tick')]
  }


  divs=rbindlist(.(labs[,.(lid=lid,labs=labs,n_start=n_start,n_end=n_end,class='axis-label',a_start=a_start,a_end=a_end)],ticks),fill=T)

  #labs[.N,n_end:=paste(n_end,end)]
  #labs[1,n_start:=paste(start,n_start)]

  ml=melt(labs,measure.vars = list(c('n_start','n_end'),c('size_start','size_end')))
  setkey(ml,rid,variable)
  setnames(ml,'variable','var1')
  ml[,rid:=.I]
  ml[nrow(ml),value2:=NA]


  ml2=melt(ml,measure.vars=c('value1','value2'))
  setkey(ml2,rid,variable)
  first= ifelse(axis=='x',start,end)
  last=ifelse(axis=='x',end,start)
  if(min(ml2$labs)==0){
   ml2=rbindlist(.(data.table(
      variable=c('value1','value2'),
      value=c(first,'0.25fr')),ml2),fill=TRUE)
  }else{
  ml2[rid==1&variable =='value1',value:=paste( first,value)]
  }

   ml2<-ml2[!is.na(value)]
   ml2[labs=='0'&&variable=='value1',value:=paste(value,'zero-line')]
   ml2[variable=='value1'&data_value==0]
   ml2[variable=='value1'&data_value==0&value%like%'start',value:=paste(value,'zero_line-start')]
   ml2[variable=='value1'&data_value==0&value%like%'end',value:=paste(value,'zero_line-end')]
   ml2[.N,value:=paste(last,value)]
  if(axis=='y'){
    ml2<-ml2[rev(1:nrow(ml2))]
  }
  ml2[variable=='value1',value:=brck(value)]
  grid_css1=na.omit(ml2$value)%sep%" "

  if(axis=='x'){
    divs[,grid_column:=paste0(n_start,'/',n_end)]
    divs[,grid_row:=paste0(a_start,'/',a_end)]

    grid_columns=grid_css1
    grid_rows='[axis_edge1] auto  [axis_label] auto [axis_edge2]'
  }else{

    divs[,grid_column:=paste0(a_start,'/',a_end)]
    divs[,grid_row:=paste0(n_start,'/',n_end)]
    grid_rows=grid_css1
    grid_columns='[axis_edge2] .1rem [axis_label]  auto [axis_edge1]'
  }
  divs[,hclass:='axis-xl']

  divs[lid%%2==0,hclass:=paste(hclass,'axis-lg')]
  divs[lid%%3==0,hclass:=paste(hclass,'axis-md')]
  divs[lid%%4==0,hclass:=paste(hclass,'axis-sm')]
  divs[,hclass:=str_trim(paste(fifelse(lid==min(lid)|lid==max(lid),"axis-xs",''),hclass))]
  divs[,class:=paste(class,'axis-continuous',paste0(axis,'-axis'),hclass)]
  lines<-divs[class%like%'axis-tick']
  lines[,class:=str_replace(class,'tick','line')]
  lines[data_value==0,class:=paste(class,'zero-line')]
  if(axis=='x'){
    lines[,grid_row:='graph-top/graph-bottom']
    lines[,grid_column:= paste0(n_start,'/',n_end)]

  }else{
    lines[,grid_column:='graph-left/graph-right']
    lines[,grid_row:=paste0(n_start,'/',n_end)]
  }


  divs[,style:=inline_style(grid.row=grid_row,grid.column=grid_column)]
  lines[,style:=inline_style(grid.row=grid_row,grid.column=grid_column)]
  inner<-HTML(glue_data(divs,'<div class="{class}" style="{style}" data-value="{data_value}">{labs}</div>'))
  lines_out<-HTML(glue_data( lines,'<div class="{class}" style="{style}" data-value="{data_value}"></div>'))

  list(div=div(class=glue('axis {axis}-axis'),style=grid_css(rows=grid_rows,cols=grid_columns,grid.area=glue('axis_{side}')),inner,...),grid=grid_css1,lines=lines_out)
}
#' @export
graph_template=function(x_range,y_range,...){
 # x_range=unique(diamonds$cut)
  # y_range=c(0,235)
  areas<-c('. axis_top .',
                      'axis_left graph axis_right',
                      '. axis_bottom .')
  rows='auto 1fr auto'
  cols='auto 1fr auto'
  xfn=SRange
  yfn=SRange
  if(is.numeric(x_range)){
    xfn=NRange
  }
  if(is.numeric(y_range)){
    yfn=NRange
  }
  x_ax<-xfn$new(x_range,coord='x')
  y_ax<-yfn$new(y_range,coord='y')
  y_grid<-y_ax$grid_template
  x_grid<-x_ax$grid_template
  y_lines<-y_ax$line_divs
  x_lines<-x_ax$line_divs
  x_axis<-x_ax$axis_containter(x_ax$label_divs,x_ax$tick_divs)
  y_axis<-y_ax$axis_containter(y_ax$label_divs,y_ax$tick_divs)
  div(class = 'grid',
      style=grid_css(
        rows = rows,
        cols = cols,
        areas = areas
      ),
      x_axis,
      y_axis,
      div(class='w-100 h-100 graph area',
          style = grid_css(rows = y_grid,
                           cols = x_grid,
                           grid.area = 'graph',position='relative'),x_lines,y_lines,...))

}
