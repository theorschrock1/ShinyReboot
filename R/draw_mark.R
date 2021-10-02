# line<-mark(name='line',.(x1='x',x2="xend",y1="y",y2="yend",value='label',style=.(top='gg'))
# data=data.table(x=1,xend=2,y=1,yend=2,label='df')
# line(data,class='line',style=.(top='10%'))


#' @export
mark_fn=function(name,attrs,formats=list(),close=TRUE){
  assert_string(name)
  assert_list(attrs)
  assert_list(formats)

  assert_logical(close,len=1)


  attrstmp=attrs
  attrstmp<-c(attrstmp[names(attrs)!='style'],attrs$style)
  assert_subset(names(formats),names( attrstmp))
  attrstmp[names(formats)]=lapply(names(formats),function(x){
   c( attrstmp[[x]],formats[[x]])
  })
    style=attrstmp[names(attrs$style)]
   attrs=attrstmp[names(attrs)!='style']

 expr_eval(mark(!!!attrs,name=!!name,close=!!close,style=!!style))
}

#' @export
mark=function(...,name,close=TRUE,style=NULL){
  dots=list(...)
  glue_vars<-names( dots)
  glue_attrs=glue_vars%NIN%'value'
  glue_value=glue_vars%IN%'value'
  value<-make_value(dots[glue_value])
  tag_open= make_tag(name)
  gvars<-make_glue_vars(dots[glue_attrs])
  style_vars<-names(style)%or%NULL
  g_style_vars=NULL
  stylefn=function(style=NULL){
    NULL
  }
  if (length(style_vars) > 0) {
    g_style_vars=make_style_vars(style)
  }
  tag_close=''
  if(nlen0(glue_value))
    close=TRUE
  if(close==TRUE)
    tag_close<-close_tag(name)
  vnames=unlist(str_extract_all(c(gvars,value),any_inside('\\{','\\}')))
  stylefn=function(style=NULL){

    sv=c(g_style_vars,make_extra(style))
    if(len0(sv))
      return()
    sv= sv%sep% ","
    paste0('style="{inline_style(',sv, ')}"')
  }
  function(data,...,style=list()){
    assert_list(style)
    dots<-list(...)
    assert_names(names(data),must.include = unique(vnames))
    extra<-make_extra(dots)

    attribs=c(gvars,stylefn(style),extra)%sep%" "
    out<-paste0(glue(tag_open),value,tag_close)
    glue_data(data,out)
  }

}

make_glue_vars=function(x){
out=map2(names(x),x,function(x,y){
  format=''
  var=y[1]
  if(length(y)==2)
    format=y[2]%or%''
  if(str_detect(var,'\\{'))
    return(cglue('&&dash(x)&&="&&var&&&&format&&"'))
  cglue('&&dash(x)&&="{&&var&&}&&format&&"')
}) %>% unlist()
  out
}
make_glue_vars2=function(x){
  out=map2(names(x),x,function(x,y){


  return(cglue('&&dash(x)&&="&&y&&"'))

  }) %>% unlist()
  out
}
make_value=function(x){
  if(length(x)==0)
    return('')
  cglue('{&&unlist(x)&&}')
}
make_extra=function(x){
  if(len0(x))
    return()
  glue('{dash(names(x))}="{unlist(x)}"')
}
make_style_vars=function(x){
  out=map2(names(x),x,function(x,y){
    format=''
    var=y[1]
    if(length(y)==2)
      format=y[2]%or%''
    glue('{x}=paste0({var},"{format}")')
  }) %>% unlist()
  out
}
make_style_vars2=function(x){
  out=map2(names(x),x,function(x,y){
    if(str_detect(y,"\\{")){
    tmp<-unlist(str_split(y,'\\{|\\}'))
    vars<-unlist(str_extract_all(y,any_inside("\\{","\\}")))
    tmp=tmp%NIN%""
    tmp2=sapply(tmp,expr_text)
    tmp2[tmp%in%vars]<-vars
    y=glue('paste0({tmp2%sep%","})')
    }
    glue('{x}={y}')
  }) %>% unlist()
  out
}


make_tag=function(x){
  glue('<{x} {{attribs}}>')
}
close_tag=function(x){
  glue('</{x}>')
}
dash=function(x){
  str_replace_all(x,"\\.","-")
}

#' @export
g_str_find_names=function(x){
unlist(lapply(str_extract_all(x,any_inside("\\{","\\}")),function(x){
  if(len0(x))
    return(x)
  unlist(lapply(x,function(x)expr_find_names(parse_expr(glue('{x}')))))
       }))
}

#' @export
mark2=function(name,attrs,close=TRUE){
  dots=attrs
  glue_vars<-names( dots)%NIN%'style'
  glue_attrs=glue_vars%NIN%c('value','style')
  glue_value=glue_vars%IN%'value'
  style=dots$style
  style_vars<-names(style)%or%NULL
  value<-dots$value%or%NULL
  tag_open= make_tag(name)
  gvars<-unlist(make_glue_vars2(dots[glue_attrs]))

  g_style_vars=NULL
  stylefn=function(style=NULL){
    NULL
  }
  if (length(style_vars) > 0) {
    g_style_vars=make_style_vars2(style)
  }
  tag_close=''
  if(nlen0(glue_value))
    close=TRUE
  if(close==TRUE)
    tag_close<-close_tag(name)
  vnames=g_str_find_names(unlist(dots))
  has_html_class=any(grepl("^class=",gvars))
  stylefn=function(style=NULL){

    sv=c(g_style_vars,make_extra(style))
    if(len0(sv))
      return()
    sv= sv%sep% ","
    paste0('style="{inline_style(',sv, ')}"')
  }
  function(data,...,style=list()){
    assert_list(style)
    dots<-list(...)
    assert_names(names(data),must.include = unique(vnames))
    if(has_html_class&&!is.null(dots$class)){
      tmp=str_replace(gvars[grepl("^class=",gvars)],'"$'," ")
      gvars[grepl("^class=",gvars)]<-paste0(tmp,dots$class,'"')
      dots$class=NULL
    }
    extra<-make_extra(dots)

    attribs=c(gvars,stylefn(style),extra)%sep%" "

    out<-paste0(glue(tag_open),value,tag_close)
    glue_data(data,out)%sep%""
  }

}
#
# line=mark2(name='line',list(points='{paste(x,y,sep=",")%sep%" "}',style=list(top="{z}")))
# svg=mark2(name='svg',list(value='{V1}',class='{grp}',style=list(grid.area='{area}')))
# data=data.table(x=1:40,y=1:40,z='a',grp=c('a','b'),area=rep(c('d','e'),each=20))
#
# data[,svg(c(.BY,.SD[,line(.SD),by=grp])),by=area]
#
# tmp<-data[,line(.SD),by=grp]
# svg(tmp)
#
