dropdown_radio_group <- function(inputId, options, labels,class = "",check_icon="checkbox-blank-circle") {
  fn_description('Create an drop down radio button group')
  fn_returns('[HTML]')
  assert_character(inputId, len = 1)
  assert_character(labels)
  assert_character(class)
  assert_character(check_icon,len = 1)
  bclass=str_trim(glue('btn dropdown-item dropdown-btn {class}'))
  buttons<-HTML(glue('<div role="button" class="{bclass}">
    <input type="radio" name="{inputId}" id="{options}"/>
  <span class="mdi mdi-{check_icon} icon-left"></span><span>{labels}</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>')%sep%"\n")


  div(id = inputId, class = "btn-group-toggle dropdown-group", `data-toggle` = "buttons",  buttons)
  # Returns: [HTML]
}
fn_document(dropdown_radio_group,{
  dropdown_radio_group(inputId="numberformat",options=letters[1:4],labels=c("Currency","Percentage","Number","Units"))
})

dropdown_btn_group=function(...,inputIds, labels,state="",types,class="",check_icon="check-bold"){
  fn_description('Create an dropdown button group')
  fn_returns('[HTML]')
  assert_character(inputIds)
  assert_character(labels,len=length(inputIds))
  assert_character(class)
  assert_any(types, check_character(len = 1), check_character(len = length(inputIds)))
  assert_character(check_icon,len = 1)

  if(len(types)==1&&types=="submenu")is_submenu=TRUE
  submenu<-chr_approx(c(TRUE,FALSE),c("dropright",""))(is_submenu)
  submenu2<-chr_approx(c(TRUE,FALSE),c("submenu",""))(is_submenu)

  btypes<-chr_approx(c("action","checkbox","submenu","model"),c("",'data-toggle="buttons"',glue('id="{inputIds}" data-toggle ="dropdown"  aria-haspopup ="true"  aria-expanded="false"')))(types)
labels<-ifelse(types=="model",paste0(labels,"..."),labels)
bclass=str_trim(glue('btn dropdown-item dropdown-btn {submenu2} {state} {class}'))
 buttons<-HTML(glue('<div role="button" class="{bclass}" {btypes} >
  <span class="mdi mdi-{check_icon} icon-left"></span><span>{labels}</span><span class="mdi mdi-menu-right float-right icon-right"></span></div>')%sep%"\n")

  div(class = glue("btn-group-toggle dropdown-group {submenu}"), buttons,...)
}
fn_document(dropdown_btn_group,{
  dropdown_btn_group(inputIds=c("copy","duplicate","edit"),labels=c("Copy","Duplicate","Edit"),types=c("action","action","model"))
})
dropdown_menu=function(...,label,class=""){
  fn_description("Create a drop down menu")
  fn_returns("HTML")
  assert_character(label,len = 1)
  assert_character(class,len = 1)
ml_dropdown(class = class, is_submenu = FALSE,
            dd_header(label,
                      id = label2id(label),
                      class = "menu-text",
                      carat = FALSE,
                      is_submenu = FALSE),
            dd_menu(id = label2id(label), class = "shadow",add_dividers(..., type = "-")))
  }
fn_document(dropdown_menu,{
  dropdown_menu(label="File",class='menu-item',
                dropdown_btn_group(inputIds=letters[1:3],labels=c("Add to Sheet","New Calculation","Show Filter"),types=c("action","action","checkbox")),
                dropdown_btn_group(inputIds=letters[4:6],labels=c("Copy","Duplicate","Edit"),types=c("action","action","model")),
                dropdown_radio_group(inputId="letters",options=letters[1:4],labels=c("Currency","Percentage","Number","Units")),
                dropdown_submenu(label="More Options",dropdown_btn_group(inputIds=letters[1:2],labels=letters[1:2],types=c("action","action"))))
},overwrite = TRUE)
dropdown_submenu=function(...,label,parent=NULL){
   fn_description("Create a drop down submenu")
  fn_returns("HTML")
  assert_character(label,len = 1)
  dropdown_btn_group(labels=label,inputIds = label2id(label),types="submenu",dd_menu(id=label2id(label),class='submenu',...))
}
fn_document(dropdown_submenu,{
  dropdown_submenu(label="More Options",dropdown_btn_group(inputIds=letters[1:2],labels=letters[1:2],types=c("action","action")))
},overwrite = TRUE)
package_document()

context_menu=function(...,id,class=""){
  fn_description("Create a context menu")
  fn_returns("HTML")
  assert_character(id,len = 1)
  assert_character(class,len = 1)

  assert_character(class,len = 1)
  ml_dropdown(class=class,is_submenu = FALSE,
               dd_header(label="contenxtlabel",
                         id = label2id("contenxtlabel"),
                         class = "menu-text context-label",
                         carat = FALSE,
                         is_submenu = FALSE),
              dd_menu(id = id, class = glue("context-menu shadow"),add_dividers(..., type = "-")))
}



context_menu(id="context",class='menu-item',
              dropdown_btn_group(inputIds=letters[1:3],labels=c("Add to Sheet","New Calculation","Show Filter"),types=c("action","action","checkbox")),
              dropdown_btn_group(inputIds=letters[4:6],labels=c("Copy","Duplicate","Edit"),types=c("action","action","model")),
              dropdown_radio_group(inputId="letters",options=letters[1:4],labels=c("Currency","Percentage","Number","Units")),dropdown_submenu(label="More Options",dropdown_btn_group(inputIds=letters[1:2],labels=letters[1:2],types=c("action","action"))))



dropdown_menu(label="File",class='menu-item',
              dropdown_btn_group(inputIds=letters[1:3],labels=c("Add to Sheet","New Calculation","Show Filter"),types=c("action","action","checkbox")),
              dropdown_btn_group(inputIds=letters[4:6],labels=c("Copy","Duplicate","Edit"),types=c("action","action","model")),
              dropdown_radio_group(inputId="letters",options=letters[1:4],labels=c("Currency","Percentage","Number","Units")),
              dropdown_submenu(label="More Options",dropdown_btn_group(inputIds=letters[1:2],labels=letters[1:2],types=c("action","action"))))
