#' @export
ScaleDiscrete <- R6::R6Class(
  "ScaleDiscrete",
  public = list(

    initialize=function(range=NULL,domain=NULL,coord='x') {
      private$.range = range
      self$coord=coord
    },
    scale_absolute=function(data,domain=NULL){
      range=self$range$numeric_range
      domain=domain%or%self$domain
      dat<-self$range$map_to_numeric(data)
      out<-dat[,lapply(.SD, function(x) approx(range,self$domain,xout=x)$y)]
      setnames(out,paste0(self$coord,c('min',"","max","bin")))
      out
    },
    scale_fr=function(data){
      mid=self$range$dtable$binWidth
      dat=self$range$map_to_numeric(data)$binWidth
      if(len1(unique(dat)))
        return(1)
       dat/median(mid)
    },
    scale_grid_end=function(data){
      domain=glue("{self$grp_name}{self$grid_domain}-end")
      chr_approx(self$range$range, domain)(data)
    },
    scale_grid_start=function(data){
      domain=glue("{self$grp_name}{self$grid_domain}-start")
      chr_approx(self$range$range, domain)(data)
    },
    scale_grid_template=function(data){
      data.table(grid_min= self$scale_grid_start(data,name),grid_mid=.5,grid_max=  self$scale_grid_end(data,name),grid_bin=self$scale_fr(data))

    }
    ),
  private = list(
    .range=NULL,
    .coord=NULL,
    .grp_name='grp',
    .domain=c(0,100)
  ),
  active = list(
    grp_name=function(value) {
      if (missing(value)) {
        return(paste0(self$coord,private$.grp_name))
      }
      private$.grp_name<-value

    },
    prv = function(value) {
      if (missing(value)) {
        return(private)
      }
      private<-value

    },
    domain= function(value) {
      if (missing(value)) {
        if(self$coord=='y')
          return(rev(private$.domain))
        return(private$.domain)
      }
      private$.domain<-value

    },
    grid_domain=function(value){
      if (missing(value)) {
        rng= 1:l(self$range$range)
        if(self$coord=='y')
          return(rev(rng))
        return( rng)
      }
      stop("grid_domain is read only")
    },
    coord = function(value) {
      if (missing(value)) {
        return( private$.coord)
      }
      private$.coord<-
        assert_choice(value,c('x','y','color','size'))

    },
    range = function(value) {
    if (missing(value)) {
        return(private$.range)
    }
    stop("range is read only")

}
))

