#' create a continuous color palette picker.

#' @name continuous_pallete_picker
#' @param inputId  \code{[string]}
#' @param package  \code{[subset]}  Defaults to \code{'grDevices'}
#' @param selected  \code{[choice]}  Possible values: \code{palette_names}.  Defaults to \code{NULL}
#' @return \code{continuous_pallete_picker}: \code{[html]}
#' @examples

#'  continuous_pallete_picker(inputId = 'myid')
#' @export
continuous_pallete_picker <- function(inputId, package = "grDevices", selected = "Blues") {
  # create a discrete color palette picker

  assert_string(inputId)
  palette_names = continous_pal_names(package)

  if (nnull(selected)) {
    assert_choice(selected, choices = palette_names )
  }
  disp<-cont_pal_dd_display(pals=palette_names )
  select_picker(inputId, selected = selected %or% palette_names[1], choices = palette_names, display_content = disp,
                width = "100%", class = "border-top-0 border-right-0 border-left-0")
  # Returns: \code{[html]}
}
#' @export
continous_pal_names=function(lib='grDevices'){
  palnames= data.table(paletteer::palettes_c_names)
  assert_subset(lib, choices=unique(palnames$package))
  out=palnames[package==lib]$palette
  if(lib=="grDevices"){
    out=out[-(1:14)]
  }
  sort(out)
}
#' @export
continuous_pal=function(pal,lib='grDevices',n=3,direction=-1,alpha=FALSE){
  colors=as.character(paletteer_c(paste0(lib,"::",pal),n=n,direction=direction))
  if(alpha==FALSE)
    colors=str_remove(colors,"FF$")
  colors
}
#paletteer_c(paste0(lib,"::",pal)
continuous_pal_divs=function(pals=continous_pal_names(),lib='grDevices',n=3,as_character=FALSE,direction=-1,...){

  out<-lapply(pals,function(pal,lib,n,as_character,...){
    colors=continuous_pal(pal=pal,lib=lib,n=n,direction=direction)
    color_min=colors[1]
    color_center=colors[2]
    color_max=colors[3]
    style<-paste0("background-image: linear-gradient(90deg,",colors%sep%",",");")
    out<-div(...) %>% tagAppendAttributes(style=style,`data-id`=pal,`data-color_min`=colors[1],`data-color_center`=colors[2],`data-color_max`=colors[3])
    if(as_character)
      out=as.character(out)

    out
  },lib=lib,n=n,as_character=as_character,direction=direction,...)
  if(as_character)
    return(unlist(out))
  out
}

cont_pal_dd_display = function(pals=continous_pal_names(), pal_names=NULL) {
  if(is.null(pal_names))
    pal_names=pals
  inner =continuous_pal_divs(pals=pals,lib='grDevices',n=3,as_character = TRUE,class='c_palette d-flex align-self-stretch',style='width:20px;')
  glue("<div class='d-flex h-100'>{inner}<div class='d-flex h-100'><div class='ml-1'>{pal_names}</div></div>")
}

