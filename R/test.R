#' @export
 test=function(j,by){
library(ggplot2)
library(data.table)
look<-newDT(diamonds)
i_by=1:(expr_list_len(enexpr(by)))
i_j=1:(expr_list_len(enexpr(j))+max(i_by+1))

look<-look[,j,by=by]$data

by=names(look)[i_by]
j=names(look)[i_j]
fd=function(x,y){
  paste(x,y,sep="")
}
#j_names=NULL

colnam=c(by,j)


bynam=c(paste0('grp_',by))
jnam=c(paste0('grp_',j))
look[,c(bynam):=accumulate(map2(.SD,names(.SD),function(x,y)paste0(y,str_remove_all(as.character(x),"\\s"))),fd),.SDcols=by]
look[,c(jnam):=lapply(j,function(x)paste0(x,1:nrow(look)))]
look[,c(by):=lapply(.SD,as.character),.SDcols=by]
look[,c(j):=lapply(.SD,function(x)as.character(signif(x))),.SDcols=j]
fd<-melt(look,measure.vars = list(colnam,c(bynam,jnam)),id.vars=NULL)



fd<-unique(fd)
fd[,variable:=as.numeric(variable)]
fd[,class:='table-row']
fd[variable<max(variable),class:='sticky']
inner=glue_data(fd,"<div class='cell border-top {class}' style='grid-area:{value2};'>{value1}</div>")%sep%""
grid_tmp_areas<-expr_label(look[,reduce(.SD,paste),.SDcols=nam]) %sep%"\n"
print(grid_tmp_areas)
tagList(
  tags$style(HTML(paste0("#mydfgrid",'{',css(display= 'grid',
                        grid.template.columns = rep('1fr', l(colnam)),
                        grid.template.rows = 'repeat(2000,12px)',
                        grid.template.areas = grid_tmp_areas),"}"))
             ),
div(id='mydfgrid',HTML(inner)))
 }
 #' @export
 grid_headers=function(id,data,colsize,rowsize,...){
   ns=NS(id)
   #df<-get_casted_identity_groups(data)
   #mg<-get_casted_measures(data)
   cm=get_column_names(data)
   dsf<-get_identity_names(data)
   cm2<-as.data.table(t(sapply(dsf,function(x)c(rep('.',ncol(cm)-1),x))))
   tagList(build_column_header(id=id,name='colnames',class='sticky-column column-headers',data=cm,colsize=colsize ,rowsize=rowsize,...),
           build_column_header(id=id,name='rownames',class='row-headers',data=cm2,colsize=colsize ,rowsize=rowsize,...))
 }
 #' @export
 build_column_header=function(id,name,data,colsize,rowsize,...){
   ns<-NS(id)
   ncols=nrow(data)
   nrows=ncol(data)
   header<-names(data)[1:l(names(data))]
   header=header[1:l(names(data))]
   headerP=paste0(header,"P")
   data[,c(paste0(header,"P")):=map2(.SD,header,function(x,y){rleid(x,prefix=paste0(y,'grp'))})]


   fd<-melt(data,measure.vars = list(header,headerP),id.vars=NULL)
   fd<-unique(fd)
   fd[,variable:=as.numeric(variable)]
   fd[,class:='pane table-header cell']
   fd[variable>min(variable),class:='cell border-bottom sticky column-header']

   fd[value1==".",value1:=""]
   inner=glue_data(fd,"<div class='{class}' style='grid-area:{value2};'>{value1}</div>")%sep%""

   grid_tmp_areas<-expr_label(data[,sapply(.SD,paste,collapse=" "),.SDcols=paste0(header,"P")])%sep%"\n"

   style=css(display= 'grid',
             grid.template.columns = rep(colsize,ncols),
             grid.template.rows = glue('repeat({nrows},{rowsize})'),
             grid.template.areas = grid_tmp_areas)
   tagOut<-div(...,HTML(inner))
   tagOut %>% tagAppendAttributes(style=style,id=ns(name),style=css(grid.area=name))
 }
 #' @export
 grid_rows=function(id,data,colsize,rowsize,...){
   cm<-data%get%get_identity_names(data)
   colnams<-paste0('header',1:ncol(cm))
   colnamsP<-paste0(colnams,"P")
   setnames(cm,colnams)
   cm[,c(colnamsP):=map2(.SD,colnams,function(x,y){rleid(x,prefix=paste0(y,'grp'))})]
   build_grid_area(id,name='rowgroups',dt=cm,colnames=colnams,gridnames= colnamsP,type='header',rowsize=rowsize,colsize=colsize,...)
 }
 #' @export
 grid_main=function(id,data,colsize,rowsize,...){
    colnames=get_measure_names(data)
    gridnames<-paste0( colnames,"P")
    datas=data%get% colnames
    dims<-dim(datas)
    #melt(datas,measure.vars=get_casted_measures(data))

    dfs<-DT(sapply(glue('row{{1:dims[1]}}-col{1:dims[2]}'),function(x,dims)glue(x),dims=dims))
    setnames(dfs,gridnames)

    datas<-datas[,lapply(.SD,function(x)as.character(signif(x)))]
    dt<-cbind(datas,dfs)

    build_grid_area(id=id,name='main',dt=dt,colnames=colnames,gridnames=gridnames,type='cell',rowsize=rowsize,colsize=colsize,..., div(style=css(z.index=1,grid.area='col1'),class='bg-success'))
 }
 #' @export
 build_grid_area=function(id,name,dt,colnames,gridnames,type,rowsize='12px',colsize='1fr',...){
   ns<-NS(id)
   rows=nrow(dt)
   ncol=l(colnames)


   fd<-melt.data.table(dt,measure.vars = list(colnames,gridnames),id.vars=NULL)
   fd<-unique(fd)
   fd[,variable:=as.numeric(variable)]
   fd[,rownum:= seq_len(.N),by=variable]
   fd[,band:= fifelse(rownum%%2==0,"row-even",'row-odd')]
   fd[,class:=paste('cell',band)]
   if(type=='header')
      fd[variable<max(variable),class:=paste(class,'pane sticky row')]

   fd<-fd[value1!="."]

   inner=glue_data(fd,"<div class='{class}' style='grid-area:{value2};'>{value1}</div>")%sep%""

   grid_tmp_areas<-expr_label(dt[,reduce(.SD,function(x,y)paste(x,y)),.SDcols=gridnames])%sep%"\n"
   style=css(display= 'grid',
             grid.template.columns = rep(colsize,ncol),
             grid.template.rows = glue('repeat({rows},{rowsize})'),
             grid.template.areas = grid_tmp_areas)
   tagOut<-div(...,HTML(inner))
   class=NULL

   tagOut %>% tagAppendAttributes(style=style,id=ns(name),style=css(grid.area=name,class=class))
 }
 #' @export
 grid_area<-function(...,id,data,colsize='1fr',rowsize='12px'){
   tagOut=div(
     grid_headers(id=id,data,colsize = colsize,rowsize = rowsize,class='sticky column-header' ),
     grid_rows(id=id,data,colsize = colsize,rowsize = rowsize,class='sticky-row' ),
     grid_main(id=id,data,colsize = colsize,rowsize = rowsize ),
     ...)
   grid_tmp_areas=expr_label(c('rownames colnames','rowgroups main'))%sep%"\n"
   style=css(display= 'grid',
             grid.template.columns = c("80px",'1fr'),
             grid.template.rows =    c("24px",'1fr'),
             grid.template.areas = grid_tmp_areas)
   tagOut %>%
     tagAppendAttributes(style=style,id=id)
 }

 #' @export
 grid_template=function(x_range,y_range,...){

    x_range=c(0,264)
    y_range=c(0,264)
    x_labs=pretty_breaks(n=11)(x_range)
    y_labs=pretty_breaks(n=11)(y_range)
    axis_css=function(coord,name,nbreaks,zero_line=TRUE,extend=NULL){


       nb=c(rep(1,nbreaks),extend)
       start=NULL
       name_start=NULL
       # if(zero_line){
       #    start=.1
       #    name_start='[{coord}_zero-{name}]'
       # }
       #
       # axisLines<-c(start,nb)
       axisNames<-rep(c(glue('{coord}_axis_{name}-start'),glue('{coord}_axis_{name}-end')),nbreaks)
       fr<-function(x){
          as.character(glue('{x}fr'))
       }
       rem<-function(x,len=1){
          rep(as.character(glue('{x}rem')),len)
       }
       axissize<-rep(c(rem(.03),fr(1)),nbreaks)
       out<-data.table(name=  axisNames,size=  axissize)
      #if(last(out$name)=='nothing'){
      #   out<-out[-l(out$name)]
      #}
      out
    }

    x_axisLine_css=axis_css('x',name='line',l(x_labs),zero_line=FALSE)
    #x_axisLab_css=axis_css('x',name='label',l(x_labs))
    y_axisLine_css=axis_css('y',name='line',l(y_labs),zero_line=FALSE)
    #y_axisLab_css=axis_css('y',name='label',l(x_labs))

    labs<-data.table(value=c(x_labs,rev(y_labs)),class=c(rep("x_axis",l(x_labs)),rep("y_axis",l(y_labs))),type='label')
    lines<-data.table(value=rep("",l(c(x_labs,y_labs))),class=c(rep("x_axis",l(x_labs)),rep("y_axis",l(y_labs))),type='line')
    axisd<-rbindlist(list(labs,lines))
    axisd[,hclass:=paste(paste0('axis-',type),paste0(class,"-",type))]
    axisd[,rowid:=rowid(type,class)]
    axisd[,hclass:=paste(hclass,fifelse(rowid==min(rowid)|rowid==max(rowid),"axis-end","")),by=.(type,class)]
    axisd[!hclass%like%'axis-end',hclass:=paste(hclass,fifelse(rowid%%2==0,"axis-minor","axis-major")),by=.(type,class)]

    axisd[class=='x_axis',grid_columns:=paste('x_axis_line-start',rowid,"/",'x_axis_line-end',rowid)]
    axisd[type=='line'&class=='x_axis',grid_rows:=paste('graph-top',"/",'x_axis-tick')]
    axisd[type=='label'&class=='x_axis',grid_rows:=paste('x_axis-tick','/','x_axis-label')]
    axisd[class=='y_axis',grid_rows:=paste('y_axis_line-start',rowid,"/",'y_axis_line-end',rowid)]
    axisd[type=='line'&class=='y_axis',grid_columns:=paste('y_axis-tick',"/",'graph-right')]
    axisd[type=='label'&class=='y_axis',grid_columns:=paste('y_axis-label','/','y_axis-tick')]


      y_axisLine_css[1,name:=paste('graph-top',name)]
      y_axisLine_css[nrow( y_axisLine_css),name:=paste('graph-bottom',name)]
      y_axisLine_css[nrow( x_axisLine_css),size:=""]
      x_axisLine_css[1,name:=paste('graph-left',name)]
      x_axisLine_css[nrow( x_axisLine_css),name:=paste('graph-right',name)]
      x_axisLine_css[nrow( x_axisLine_css),size:=""]
     x_start=data.table(name=c('y_axis-label','y_axis-tick'),size=c('auto' ,'1px'))
     y_end=data.table(name=c('x_axis-tick','x_axis-label'),size=c('1px',"12px"))
     y_end[,out:=paste(size,paste0('[' ,name,']'))]
     y_axisLine_css[,out:=paste(paste0('[' ,name,']'),size)]
     x_axis=rbind(x_start,x_axisLine_css)
     y_axis=rbind(y_axisLine_css, y_end)
     x_axis[,out:=paste(paste0('[' ,name,']'),size)]

     col_css=x_axis$out%sep%" "
     row_css=y_axis$out%sep%" "
    inner<-HTML(glue_data(axisd,"<div class='{hclass}' style='grid-column:{grid_columns};grid-row:{grid_rows}'>{value}</div>")%sep%"")

    gridArea=function(...,rows,cols,areas=NULL){

       div(style=css(
          display='grid',
          grid.template.rows=rows,
          grid.template.columns=cols,
          grid.template.areas=areas,
    ),...)
    }
    x=paste0(sample(seq(1,100,by=.1),size=500),'%')
    y=paste0(sample(seq(1,100,by=.1),size=500),'%')
    col=sample(c("text-primary",'text-warning','text-danger','text-success'),replace=T,size=500)
    genCirle=function(i){
      icon_mdi('circle',class=col[i]) %>% tagAppendAttributes(style=css(top=y[i],left=x[i],position='absolute'))
    }

    gridArea(inner,div(style=css(grid.row='graph-top/graph-bottom',position='relative',grid.column='graph-left/graph-right'),class='border w-100 h-100', lapply(1:500, genCirle)
                       ),rows=row_css,cols=col_css,class='grid')
 }

 #' @export
 rep_css=function(n,size){
    assert_integerish(n)
    if(n==1)
       return(size)
 return(paste('repeat(', assert_integerish(n),",",assert_css_unit(size),")"))
 }
 #' @export
 gg_env=function(){
    environment(expand_limits)
 }
 #   c(
 #     'red',
 #     'blue',
 #     'yellow',
 #     'green',
 #     'black',
 #     'orange',
 #     'teal',
 #     'seal'
 #   ),
 #   c(
 #     'cut',
 #     'clarity',
 #     'color',
 #     'table',
 #     'price',
 #     'factor',
 #     'string',
 #     'ko'
 #   ),
 #   LETTERS,
 #   c("SI2", "SI1", "VS1", "VS2", "VVS2", "VVS1", "I1", "IF")
 # ))
 #
