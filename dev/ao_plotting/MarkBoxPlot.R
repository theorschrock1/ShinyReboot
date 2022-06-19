#' @export
MarkBoxPlot <- R6::R6Class(
  "MarkBoxPlot",
  inherit =MarkSVG,
  public = list(
    aes = ops(
      ymin =,
      lower =,
      middle =,
      upper =,
      ymax=,
      xmin=,
      xmax=,
      width=.75,
      fill='white',
      color='black',
      size='.05rem',
      flippable=TRUE
    ),
    setup_params=function(data,params,scales){

      params$flipped_aes=self$aes$flipped_aes
       params
    },
    setup_data=function(data,params,scales){
      data=flip_data(data,params$flipped_aes)
      data[,c('xmin','x','xmax','width'):=.(0,50,100,width*100)]
      data[,flipped_aes:=params$flipped_aes]
      data[,position:='position-dodge']
      data[,pad:=(100-width)/2]
      flip_data(data,params$flipped_aes)
      data
    },
    compute_panel=function(data,scales,...){
      flipped_aes=data$flipped_aes[1]
      data=flip_data(data,flipped_aes)
      m_point= mark_circle()
      m_segment=mark_segment()
      m_rect=mark_rect()
      minline=flip_data( data[, .(
        y = ymin,
        yend = lower,
        x = x,
        xend = x,
        size = size,
        color = color,
        group = group,
        ygrid = ygrid,
        xgrid = xgrid,
        position = position,
        PANEL=PANEL
      )],flipped_aes)
      minline=m_segment$compute_panel(minline ,scales)
      maxline =flip_data( data[, .(
        y = upper,
        yend= ymax,
        x = x,
        xend = x,
        size = size,
        color = color,
        group = group,
        ygrid = ygrid ,
        xgrid = xgrid,
        position = position,
        PANEL=PANEL
      )],flipped_aes)
      maxline=m_segment$compute_panel(maxline ,scales)

      midline =flip_data( data[, .(
        y = middle,
        yend= middle,
        x = xmin+pad,
        xend = xmax-pad,
        size = size,
        color = color,
        group = group,
        ygrid = ygrid ,
        xgrid = xgrid,
        position = position,
        PANEL=PANEL
      )],flipped_aes)
      midline=m_segment$compute_panel(midline ,scales)


      lowerbox = flip_data(data[, .(
        ymin = lower,
        xmin = xmin+pad,
        xmax = xmax-pad,
        ymax = middle ,
        color = color,
        fill = fill,
        size=size,
        group = group,
        ygrid = ygrid,
        xgrid = xgrid,
        position = position,
        PANEL=PANEL
      )],flipped_aes)

      lowerbox=m_rect$compute_panel(lowerbox,scales)

      upperbox =flip_data(  data[, .(
        ymin =  middle,
        xmin = xmin+pad,
        xmax = xmax-pad,
        ymax = upper ,
        color = color,
        fill = fill,
        size=size,
        group = group,
        ygrid = ygrid,
        xgrid = xgrid,
        position = position,
        PANEL=PANEL
      )])

      upperbox=m_rect$compute_panel( upperbox,scales)

      coord=flip_names('y',flipped_aes)
      cscale=scales[[coord]]
      points<-data[,.(y=unlist(outliers),x=50,size=size),by=.(color,group=group,ygrid=ygrid,xgrid=xgrid,position=position,PANEL)]
      points[,y:=  cscale$scale(y) ]


      points<- m_point$compute_panel(flip_data(points,flipped_aes),scales)
      out<- rbindlist(.(points,upperbox,lowerbox,minline,maxline,midline))
      out
    }
  ))
#' @export
mark_boxplot=function(){
  MarkBoxPlot$new()$build_fn()()
}
