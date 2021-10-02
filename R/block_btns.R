#' @export
block_btns=function(inputId,icon,label,size='sm'){
  HTML(glue('<li class="ao_block_item">
  <button id="{inputId}" class="ao_btn ao_block-btn ao_block-btn-{size}" type="button">
    <span class="mdi mdi-{icon} ao_block-btn_icon"></span>
    <span class="block-button-text">{label}</span>
      </button></li>'))
}
#' @export
btn_block=function(...){

  out= tags$ul(class="ao-btn-block",...)
  attachDependencies(out,html_dependency_btn_block())
}
#' @export
btn_block_row=function(...){
  tags$li(class="ao-btn-block ao-btn-block-row",
          tags$ul(class="ao-btn-block",...))
}
#' @export
btn_block_col=function(...){
  tags$li(class="ao-btn-block ao-btn-block-col",
          tags$ul(class="ao-btn-block",...))
}
#' @export
tmpids=function(n){
  sapply(1:n,function(x)paste0('id',create_unique_id(4)))
}

# btn_block(
#   btn_block_col(
#     btn_block_row(
#       block_btns(inputId=tmpids(3),label=c("Color","Size","Label"),icon=c('palette-outline',"chart-bubble","text-recognition"))),
#     btn_block_row(
#       block_btns(inputId=tmpids(3),label=c("Detail","Tooltip","Shape"),icon=c('focus-field','tooltip-outline','shape-outline'))
#     ))
# )
