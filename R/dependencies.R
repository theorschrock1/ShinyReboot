#' @export
html_dependency_setShinyInput <- function() {
  htmltools::htmlDependency(
    name = "setShinyInput",
    version = packageVersion("ShinyReboot"),
    src = "assets/setShinyInput",
    package = "ShinyReboot",
    script = "setShinyInput.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_rebootJS <- function() {
  htmltools::htmlDependency(
    name = "rebootjs",
    version = packageVersion("ShinyReboot"),
    src = "assets/rebootJS",
    package = "ShinyReboot",
    script = "reboot.js",
    all_files = FALSE
  )
}

#' @export
html_dependency_filter_shelf <- function() {
  htmltools::htmlDependency(
    name = "filter_shelf",
    version = packageVersion("ShinyReboot"),
    src = "assets/filterShelf",
    package = "ShinyReboot",
    script = "filterShelf.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_ShinySignIn <- function() {
  htmltools::htmlDependency(
    name = "signin",
    version = packageVersion("ShinyReboot"),
    src = "assets/signin",
    package = "ShinyReboot",
    stylesheet ="signin.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_filter_header <- function() {
  htmltools::htmlDependency(
    name = "filter_header",
    version = packageVersion("ShinyReboot"),
    src = "assets/filter_header",
    package = "ShinyReboot",
    stylesheet ="filter-header.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_btn_block <- function() {
  htmltools::htmlDependency(
    name = "btn_block",
    version = packageVersion("ShinyReboot"),
    src = "assets/btn_block",
    package = "ShinyReboot",
    stylesheet ="btn_block.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_ao_color_picker<-function(){
  htmltools::htmlDependency(
    name = "ao_color_picker",
    version = packageVersion("ShinyReboot"),
    src = "assets/ao_color_picker",
    package = "ShinyReboot",
    stylesheet ="aoColorPicker.css",
    script  ="aoColorPickerBinding.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_ao_range_slider<-function(){
  htmltools::htmlDependency(
    name = "ao_range_slider",
    version = packageVersion("ShinyReboot"),
    src = "assets/ao_range_slider",
    package = "ShinyReboot",
    stylesheet ="ao_range_slider.css",
    script  ="aoRangeSliderBinding.js",
    all_files = FALSE
  )
}
html_dependency_ao_checkbox_group<-function(){
  htmltools::htmlDependency(
    name = "ao_checkbox_group",
    version = packageVersion("ShinyReboot"),
    src = "assets/ao_checkbox_group_input",
    package = "ShinyReboot",
    stylesheet ="ao-checkbox-group.css",
    script  ="aoCheckboxGroupBinding.js",
    all_files = FALSE
  )
}
html_dependency_ao_radio_slider<-function(){
  htmltools::htmlDependency(
    name = "ao_radio_slider",
    version = packageVersion("ShinyReboot"),
    src = "assets/ao_radio_slider",
    package = "ShinyReboot",
    stylesheet ="ao_radio_slider.css",
    script  ="aoRadioSliderBinding.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_default_color_picker<-function(){
  htmltools::htmlDependency(
    name = "default_color_picker",
    version = packageVersion("ShinyReboot"),
    src = "assets/default_color_picker",
    package = "ShinyReboot",
    stylesheet ="defaultColorPicker.css",
    script  ="defaultColorPickerBinding.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_continuous_palette_picker<-function(){
  htmltools::htmlDependency(
    name = "continuous_color_picker",
    version = packageVersion("ShinyReboot"),
    src = "assets/c_palette_picker",
    package = "ShinyReboot",
    stylesheet ="c_palette_picker.css",
    script  ="c_palette_picker_binding.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_d_palette_picker<-function(){
  htmltools::htmlDependency(
    name = "d_palette_picker",
    version = packageVersion("ShinyReboot"),
    src = "assets/d_palette_picker",
    package = "ShinyReboot",
    stylesheet ="discretePalPicker.css",
    script  ="discretePalPickerBinding.js",
    all_files = FALSE
  )
}
#' @export
html_dependency_main_menu_bar <- function() {
  htmltools::htmlDependency(
    name = "main_menu_bar",
    version = packageVersion("ShinyReboot"),
    src = "assets/main_menu_bar",
    package = "ShinyReboot",
    stylesheet ="menu-bar.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_context_menu <- function() {
  htmltools::htmlDependency(
    name = "context_menu",
    version = packageVersion("ShinyReboot"),
    src = "assets/context_menu",
    package = "ShinyReboot",
    script  ="contextmenu.js",
    stylesheet ="contextmenu.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_dropdown_menu <- function() {
  htmltools::htmlDependency(
    name = "dropdown_menu",
    version = packageVersion("ShinyReboot"),
    src = "assets/dropdown_menu",
    package = "ShinyReboot",
    script = 'dropdown.js',
    stylesheet ="dropdown.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_pill_card <- function() {
  htmltools::htmlDependency(
    name = "pill_card",
    version = packageVersion("ShinyReboot"),
    src = "assets/pill_card",
    package = "ShinyReboot",
    stylesheet ="pill_card.css",
    all_files = FALSE
  )
}
#' @export
html_dependency_picker_page_btn <- function() {
  htmlDependency(
    name = "select_picker_pagination",
    version = packageVersion("ShinyReboot"),
    src =  "assets/select_picker_pagination",
    package = "ShinyReboot",
    script = "select_picker_pagination.js",
    all_files =FALSE
  )
}
#' @export
html_dependency_split_grid <- function() {
  htmlDependency(
    name = "split-grid",
    version =packageVersion("ShinyReboot"),
    src =  "assets/split-grid/dist/",
    package = "ShinyReboot",
    script = c("split-grid.js",'splitGridBinding.js'),
    all_files =FALSE
  )
}
#' @export
html_dependency_split_JS <- function() {
  htmlDependency(
    name = "split.js",
    version = '1.6.0',
    src =  "assets/split.js/dist/",
    package = "ShinyReboot",
    script = c("split.js",'splitBinding.js'),
    all_files =FALSE
  )
}
#' @export
html_dependency_sortable_JS <- function() {
  htmlDependency(
    name = "sortable.js",
    version = '1.12.0',
    src =  "assets/sortablejs/dist/",
    package = "ShinyReboot",
    script = c("sortable.umd.js",'sortableBinding.js'),
    all_files =FALSE
  )
}
#' @export
html_dependency_variable_dropzone <- function() {
  htmlDependency(
    name = "variable_dropzone",
    version =packageVersion("ShinyReboot"),
    src =  "assets/variableDropzone/",
    package = "ShinyReboot",
    script = c('variableDropzoneBinding.js'),
    all_files =FALSE
  )
}

#' @export
spectrum_colorpicker_depends=function(){
  deps = htmlDependency("spectrum-colorpicker2", "2.0", c(href = "https://cdn.jsdelivr.net/npm/spectrum-colorpicker2"),
                        script = "dist/spectrum.min.js", stylesheet = "dist/spectrum.min.css")
}
#' @export
html_dependency_material_icons=function(){
  htmltools::htmlDependency(
    name = "mdi-icons",
    version = packageVersion("ShinyReboot"),
    src = "assets/mdi-icons",
    package = "ShinyReboot",
    stylesheet = c("css/materialdesignicons.min.css","css/mdi.css"),
    all_files =FALSE
  )
}

#' @export
bootstrap_select_depends=function(){
  htmltools::htmlDependency("bootstrap-select", "1.13.14", c(href = "https://cdn.jsdelivr.net/npm/bootstrap-select@1.13.14"),
                            script = "dist/js/bootstrap-select.min.js",
                            stylesheet = "dist/css/bootstrap-select.min.css")
}


#' @export
html_dependency_draggableModel <- function ()
{
    htmlDependency(name = "draggableModel", version = packageVersion(c(Package = "ShinyReboot")),
        src = "assets/draggableModel", package = c(Package = "ShinyReboot"),
        stylesheet = "draggableModel.css", script = c("draggableModelBinding.js", 'dragElement.js'),
        all_files = FALSE)
}
#' @export
html_dependency_select_picker<-function()
{
  htmlDependency(name = "select-picker", version = packageVersion(c(Package = "ShinyReboot")),
                 src = "assets/select_picker", package = c(Package = "ShinyReboot"),
                 stylesheet = "select-picker.css",
                 all_files = FALSE)
}
#' @export
html_dependency_ace_editor<-function()
{
  htmlDependency(name = "ace_custom_editor", version = packageVersion(c(Package = "ShinyReboot")),
                 src = "assets/ace_editor", package = c(Package = "ShinyReboot"),
                 script= c('ace_editor_drop.js',"set_ace_token.js"),
                 all_files = FALSE)
}
#' @export
html_dependency_ace_highlighter<-function()
{
  htmlDependency(name = "ace_highlighter",
                 version = packageVersion(c(Package = "ShinyReboot")),
                 src = "assets/ace_editor", package = c(Package = "ShinyReboot"),
                 stylesheet =  "ace_highlighter.css",
                 all_files = FALSE)
}


#' @export
html_dependency_icon_toggler <- function ()
{
    htmlDependency(name = "icon_toggler", version = packageVersion(c(Package = "ShinyReboot")),
        src = "assets/icon_toggler", package = c(Package = "ShinyReboot"),
        stylesheet = "icon_toggler.css", script = "icon_togglerBinding.js",
        all_files = FALSE)
}


#' @export
html_dependency_data_dropdown <- function ()
{
    htmlDependency(name = "data_dropdown", version = packageVersion(c(Package = "ShinyReboot")),
        src = "assets/data_dropdown", package = c(Package = "ShinyReboot"),
        stylesheet = "data_dropdown.css", script = "data_dropdownBinding.js",
        all_files = FALSE)
}
html_dependency_standard_dropdown <- function ()
{
  htmlDependency(
    name = "standard_dropdown",
    version = packageVersion(c(Package = "ShinyReboot")),
    src = "assets/standard_dropdown",
    package = c(Package = "ShinyReboot"),
    script = "standard_dropdown.js",
    stylesheet = 'standard_dropdown.css',
    all_files = FALSE
  )
}
html_dependency_ao_sheet <- function ()
{
  htmlDependency(
    name = "ao_sheet",
    version = packageVersion(c(Package = "ShinyReboot")),
    src = "assets/ao_sheet",
    package = c(Package = "ShinyReboot"),
    script = "aoSheetBinding.js",
    all_files = FALSE
  )
}


#' @export
html_dependency_editable_text <- function ()
{
    htmlDependency(name = "editable-text", version = packageVersion(c(Package = "ShinyReboot")),
        src = "assets/editable-text", package = c(Package = "ShinyReboot"),
        stylesheet = "editable-text.css", script = "editable-textBinding.js",
        all_files = FALSE)
}
