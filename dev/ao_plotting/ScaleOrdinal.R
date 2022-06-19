#' @export
ScaleOrdinal = R6::R6Class(
  'ScaleOrdinal ',
  inherit=ScaleDiscreteAO,
  public = list(
    default_palettes=NULL,
    initialize = function(...) {
      self$super_init(...)
      self$validate_palette_format()

    },
    super_init=import_fn(super_init),
    validate_palette_format=function(pals=self$palettes){
      assert_data_table(self$palettes)
     palettes= as.list(self$palettes)

     assert_named_list(palettes,
                       structure = list(
                         package = char(),
                         palette = char(),
                         length = integer(),
                         type = char(),
                         path=char()
                       ))
    },
    get_default_palettes=function(defaults=self$default_palettes){
      if(is.null(defaults))
        abort("default palettes not set")
      assert_list(defaults,types=c('numeric','numeric'))
      assert_named(defaults)
      defaults
    },
    get_palette=function(pal=self$palette_name){
      if(is.null(self$palette_name)){
        n_groups=max(self$get_limits())
        def_pals=unlist(self$get_default_palettes())
        pal<-names(def_pals[def_pals>=n_groups][1])
        if(is.na(pal)){
          pal=palettes[which.min(abs(length - n_groups))]
          pal=pal$palette
        }
      }
      pal
    },
    get_trans_range=function(){
      scale$trans$transform(scale$trans$range)
    },
    get_domain=function(pal=self$get_palette()){
      if(nnull(self$manual_domain))
        return(self$manual_domain)
      abort('not implemented')
    },
    reset_domain_mapping=function(){
      self$manual_domain=NULL
    },
    set_domain_mapping=function(labels,domain){
      if(!all(labels%in%self$get_labels()))
        g_stop("missing labels when setting domain range manually")
      if(length(domain)!=length(labels))
        g_stop("length of labels must match length of domain")
      self$manual_domain=domain[self$trans$transform(labels)]
    },
    scale = function( x, domain =   self$get_domain(), range =self$get_labels() )   {
      range=as.numeric(self$trans$transform(range))

      if(l(range)>l(domain)){
       abort('pallete length > than range')
      }

      map_ordinal(x,domain=domain,range=range)


    }
  ),
  private = list(.init=FALSE,
                 .palette=NULL,
                 .manual_domain=NULL),
  active = list(
    manual_domain = function(value) {
      if (missing(value)) {
        return(private$.manual_domain)
      }
      private$.manual_domain<-assert_character(value,null.ok = TRUE)

    },
    palettes = function(value) {
      if (missing(value)) {
        abort('not implemented')
      }
      stop("palettes is read only")

    },
    palette_name = function(value) {
      if (missing(value)) {
        return(private$.palette)
      }
      private$.palette<-
        assert_choice(value,self$palettes$palette)

    }
  )
)
#' @export
scale_ordinal=function(aes,trans=discrete_trans(),range=NULL,...){
  ScaleOrdinal$new(coord='z',aes=aes,trans=trans,range=range,...)
}
