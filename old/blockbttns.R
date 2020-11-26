block_btns=function(inputId,icon,label,size='sm'){
  HTML(glue('<li class="ao_block_item">
  <button id="{inputId}" class="ao_btn ao_block-btn ao_block-btn-{size}" type="button">
    <span class="mdi mdi-{icon} ao_block-btn_icon"></span>
    <span class="block-button-text">{label}</span>
      </button></li>'))
}
btn_block=function(...){
  tags$ul(class="ao-btn-block",...)
}
btn_block_row=function(...){
  tags$li(class="ao-btn-block ao-btn-block-row",
          tags$ul(class="ao-btn-block",...))
}
btn_block_col=function(...){
  tags$li(class="ao-btn-block ao-btn-block-col",
          tags$ul(class="ao-btn-block",...))
}


btn_block(
  btn_block_col(
  btn_block_row(
    block_btns(inputId=tmpids(3),label=c("Color","Size","Label"),icon=c('palette-outline',"chart-bubble","text-recognition"))),
  btn_block_row(
    block_btns(inputId=tmpids(3),label=c("Detail","Tooltip","Shape"),icon=c('focus-field','tooltip-outline','shape-outline'))
  ))
)
'palette-outline',"chart-bubble","text-recognition"

c('shape-outline',
'tooltip-outline',
'view-grid-plus-outline')
view_mdi_icons("large")
materialIconGallery()
tmpids=function(n){
  sapply(1:n,function(x)paste0('id',create_unique_id(4)))
}
tmpids(4)

ao_nav_fixed_top=function(...){
tags$nav(class="fixed-top m-0 p-0",...)
  }
navbar_row=function(...,class="navbar-light bg-light"){
  tags$nav(class=glue("navbar m-0 p-0 {class}"),
    tags$div(class="navbar-nav px-1 m-0",...))
}

