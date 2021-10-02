#' @export
switch_orintation=function(aesthetics)
{
  x <- x_aes()
  y <- y_aes()
  x_aes <- match(aesthetics, x)
  x_aes_pos <- which(!is.na(x_aes))
  y_aes <- match(aesthetics, y)
  y_aes_pos <- which(!is.na(y_aes))
  if (length(x_aes_pos) > 0) {
    aesthetics[x_aes_pos] <- y[x_aes[x_aes_pos]]
  }
  if (length(y_aes_pos) > 0) {
    aesthetics[y_aes_pos] <- x[y_aes[y_aes_pos]]
  }
  aesthetics
}
#' @export
flip_names=function(aesthetics,flip)
{
 if(flip)
   aesthetics<-switch_orintation( aesthetics)
 aesthetics
}
#' @export
flip_data=function(data,flip=NULL){
  assert_logical(flip,null.ok = T,len=1)
  if(is.null(flip)||isTRUE(flip)){
    if(is.data.table(data)){
      setnames(data,names(data),switch_orintation(names(data)))
    }else{
      names(data)<-switch_orintation(names(data))
    }
}
  data

}

flipped_coord=function(aes,flip=FALSE){
  assert_logical(flip,len=1)
  if(flip==FALSE)
    return(aes)
  if(aes=='x')
    return('y')
  return('x')
}

