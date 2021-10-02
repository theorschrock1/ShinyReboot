#' Create a grid with resizable rows or columns.

#' @name split_grid
#' @param inputId  [character] the shiny inputId and id of the outer div. Defaults to NULL.  If null, a random id will be generated.
#' @param grid_dims [int(len=2)] \code{c(nrows,ncols)]}
#' @param grid_assignments \code{list(html=class('shiny.tag'),row=int(),col=int(),rowspan=int(NULL),colspan=int())}.
#' @param autoAssign [logical(FALSE)] Defaults to FALSE. Defaults to TRUE if grid assignments rows and cols are not present.
#' @param autoAssignbyRow [logical(FALSE)] should the auto_assignment fill by column or row first?
#' @param row_sizes [character css(auto,fr,px)] length 1 or length nrows.
#' @param column_sizes [character css(auto,fr,px)] length 1 or length nrows.
#' @param gutterSize  [numeric]  Gutter size in pixels. Defaults to 10.
#' @param gutterAttrs [list] a list of html attributes to use when creating the gutters. Defaults to NULL.
#' @param rowGutterAttrs a list of html attributes to use when creating the gutters. Defaults to gutterAttr.
#' @param colGutterAttrs a list of html attributes to use when creating the gutters. Defaults to gutterAttr
#' @param minSize [number] The minimum size in pixels for all tracks. Default: 0
#' @param columnMinSize [number] The minimum size in pixels for all tracks.
#' @param rowMinSize [number] The minimum size in pixels for all tracks.
#' @param columnMinSizes list(column=[number],minSize=[number]) An list by column/row index, with values set to the minimum size in pixels for the column/row at that index. Allows individual minSizes to be specified by  column/row. Note this option is plural with an s, while the two fallback options are singular.
#' @param rowMinSizes list(row=[number],minSize=[number]) See columnMinSizes.
#' @param snapOffset [numeric] Snap to minimum size offset in pixels. Defaults to 30
#' @param columnSnapOffset [numeric] Snap to minimum size offset in pixels. Defaults to \code{snapOffset}.
#' @param rowSnapOffset [numeric] Snap to minimum size offset in pixels. Defaults to \code{snapOffset}.
#' @param columnCursor [string] Cursor to show while dragging. Default: 'col-resize'
#' @param rowCursor [string] Cursor to show while dragging. Default: 'row-resize'
#' @param dragInterval  [numeric] Number of pixels to drag. Defaults to 1
#' @param columnDragInterval [numeric]  Number of pixels to drag. Defaults to 1
#' @param rowDragInterval [numeric]  Number of pixels to drag. Defaults to 1
#' @param onDrag [JS Function] Callback on drag. Defaults to NULL
#' @param onDragStart [JS Function] Callback on drag start. Defaults to NULL
#' @param onDragEnd [JS Function] Callback on drag end. Defaults to NULL
#' @return \code{split_grid}: html

#' @export
split_grid=function(...,
                   inputId,
                   nrow,
                   ncol,
                   minSize=0,
                   gutterSize=1,
                   row_sizes='auto',
                   column_sizes='auto',
                   grid_assignments=NULL,
                   gutter_assignments=NULL,
                   gutterAttrs=NULL,
                   rowGutterAttrs=NULL,
                   colGutterAttrs=NULL,
                   dragInterval=1,
                   columnDragInterval=NULL,
                   rowDragInterval=NULL,
                   columnMinSize=NULL,
                   rowMinSize=NULL,
                   columnMinSizes=NULL,
                   rowMinSizes=NULL,
                   snapOffset=0,
                   columnSnapOffset=NULL,
                   rowSnapOffset=NULL,
                   columnCursor='col-resize',
                   rowCursor='row-resize',
                   onDrag=NULL, 	#JS Function 		Callback on drag.
                   onDragStart=NULL, 	#JS Function 		Callback on drag start.
                   onDragEnd=NULL 	#JS Function 		Callback on drag end.
){


  assert_character(inputId,len=1)
  assert_integerish(nrow)
  assert_integerish(ncol)
  assert_length(column_sizes,len=c(1,ncol),null.ok = TRUE)
  assert_length(row_sizes,len=c(1,nrow),null.ok = TRUE)
  assert_numeric(minSize,lower=0)
  assert_numeric(columnMinSize,lower=0,null.ok = TRUE)
  assert_numeric(rowMinSize,lower=0,null.ok = TRUE)
  # assert_named_list(grid_assignments,list(row=int(),col=int(),rowspan=int(NULL),colspan=int()),null.ok=TRUE)
  # assert_named_list(gutter_assignments,list(id=string(),row=int(),col=int(),rowspan=int(NULL),colspan=int()),null.ok=TRUE)
  # assert_named_list(
  #   columnMinSizes,
  #   structure = list(col = numeric(), minSize = numeric()),
  #   null.ok = TRUE
  # )
  # assert_named_list(
  #   rowMinSizes,
  #   structure = list(row = numeric(), minSize = numeric()),
  #   null.ok = TRUE
  # )
  assert_number(gutterSize,lower=1)
  assert_number(snapOffset,lower=0)
  assert_list(gutterAttrs,null.ok = T)
  assert_list(rowGutterAttrs,null.ok = T)
  assert_list(colGutterAttrs,null.ok = T)
  assert_valid_fn_string(onDrag,null.ok = TRUE)
  assert_valid_fn_string(onDragEnd,null.ok = TRUE)
  assert_valid_fn_string(onDragStart,null.ok = TRUE)
  # childs=1:l(  innerHTML)
  # split_ids=glue("'#{id} > :nth-child({childs})'")%sep%","

  gutter_assignments[,track:=ifelse(type=='vertical_gutter',col,row)]
 # types<-split(gutter_assignments[,.(track=track,element=id,type=type)],by=c('type'),keep.by=F)


  #names(types)<-c('rowGutters',"columnGutters")

  #out=list()
  # out[[1]]=lapply(types,function(x){
  #
  #   x[,fd:=lapply(1:nrow(x),function(i)list(track=track[i],element=element[i]))]
  #   x$fd
  #
  #   })
  #out$tracks=drop_nulls(lapply(types,function(x){
   #as.list(x[,.(track=track,element=element)])
    #   }))

  options<-drop_nulls(list(minSize=minSize,
             columnMinSize=columnMinSize,
             rowMinSize=rowMinSize,
             columnMinSizes=columnMinSizes,
             rowMinSizes=rowMinSizes,
             gutterSize=  gutterSize,
             snapOffset=snapOffset,
             columnCursor=columnCursor,
             rowCursor=rowCursor,
             columnSnapOffset=columnSnapOffset,
             rowSnapOffset=rowSnapOffset,
             dragInterval=dragInterval,
             columnDragInterval=columnDragInterval,
             rowDragInterval=rowDragInterval,
             onDrag=onDrag,
             onDragStart=onDragStart,
             onDragEnd=  onDragEnd))

  options=toJSON(list(options=options),auto_unbox = T,json_verbatim = TRUE)

print(options)
  gridhtml<-c(glue_data(gutter_assignments,'<div id="{paste(inputId,id,sep="_")}" class="{type}" style="grid-row: {row} / span {rowspan};grid-column: {col} / span {colspan};" data-track={track}></div>'),glue_data(grid_assignments,'<div style="grid-row: {row} / span {rowspan};grid-column: {col} / span {colspan};" data-variable="{variable}" data-value="{value}">{html}</div>'))%sep%"\n"

 grid_tmp_rows=c(rep(glue('{row_sizes} {gutterSize}px'),(nrow-1)/2),row_sizes)%sep%" "
 grid_tmp_cols=c(rep(glue('{column_sizes} {gutterSize}px'),(ncol-1)/2),column_sizes)%sep%" "
 style=glue("display:grid;grid-template-rows:{grid_tmp_rows};grid-template-columns:{grid_tmp_cols};")
 splitTag=div(...,HTML(gridhtml)) %>%
   tagAppendAttributes(id=inputId,class='split-grid',style=style) %>% attachDependencies(html_dependency_split_grid())

  #as_glue(str_replace_all(out,'"CALLBACK":"CALLBACKS"', cb))
  # tags$script(
  #   type = "application/json",
  #   `data-for` =inputId,
  #   out
  # )

tagList(
  splitTag,
  tags$script(type = "application/json",
                 `data-for` = inputId,
                  options
               ))


}

#' @export
grid_table=function(data,byvars){
  data<-copy(data)
  ncols=l(names(data))
  names_data=names(data)[1:ncols]
  j_names=names_data%NIN%byvars
  reduce(c(byvars,""),function(x,y){
    i=length(x)

    data[,c(glue("g{i}")):=.GRP,by=x]
    out=c(x,y)

    out
  })
  data[,data_row:=1:nrow(data)]
  cop=copy(data)

  data[,nrow:=g3*2-1]
  data[,gutter:=F]
  cop[,gutter:=T]
  cop[,nrow:=g3*2-2]
  ds<-rbind(data,cop)
  setkey(ds,nrow)

  sdcols=c( glue("g{1:length(byvars)}"),'nrow')
  ds[,c('col'):=(ncols*2)-((lapply(.SD,function(x)c(0,diff(x))) %>% reduce(`+`))*2-1),.SDcols=sdcols]

  guts=ds[gutter==T]

  guts[,colspan:=(ncols*2-1)-(col)+1]
  guts=guts[nrow!=0]

  hguts=guts[,.(id=paste0('horizonal_gutter-',nrow),row=nrow,rowspan=1,col=col,colspan=colspan,type='horizontal_gutter')]
  vguts=data.table(id=paste0('verical_gutter-',1:(ncols-1)),row=1,rowspan=max(ds$nrow),col=1:(ncols-1)*2,colspan=1,type='vertical_gutter')
  dsf=ds[gutter==F]
  dsf[,c(j_names):=lapply(.SD,signif),.SDcols=j_names]
  dsf[,c(names_data):=lapply(.SD,as.character),.SDcols=names_data]
  ds2<-melt(dsf,id.vars=c('data_row','nrow'),measure.vars =list(c('cut', 'color', 'clarity' ,'V1'),c("g1",'g2','g3','data_row')))

  ds2[,col:=.GRP,by='variable']
  ds2[,id:=paste(variable,value1)]

  out<-ds2[,.(row=min(nrow),rowspan=max(nrow)-min(nrow)+1,col=min(col)*2-1,colspan=1,html=unique(value1)),by=list(variable,value1,value2)]
  out[,type:='cell']
  out[,value2:=NULL]
  out[,value:=value1]
  out[,value1:=NULL]
  list(data=out,gutters=rbindlist(list(vguts,hguts),fill=T),ncols=max(ds2$col)*2-1,nrow=max(ds2$nrow))
}
