#' Create an drop down radio button group.

#' @name dropdown_radio_group
#' @param inputId  [character]  Must have an exact length of 1.
#' @param options
#' @param labels  [character]
#' @param class  [character]  Defaults to ''
#' @param check_icon  [character]  Must have an exact length of 1.  Defaults to 'checkbox-blank-circle'
#' @return \code{dropdown_radio_group}: [HTML]
#' @examples

#'  dropdown_radio_group(inputId = 'numberformat', options = letters[1:4],

#'  labels = c('Currency', 'Percentage', 'Number', 'Units'))

#' @export
dropdown_radio_group <- function(inputId, options, labels, class = "", check_icon = "checkbox-blank-circle",trigger_event=NULL) {
    # Create an drop down radio button group
    assert_character(inputId, len = 1)
    assert_character(labels)
    assert_character(class)
    assert_character(check_icon, len = 1)
    trigger=""
    assert_string(trigger_event,null.ok=TRUE)
    if(nnull(trigger_event)){
        trigger= glue(' data-trigger="{trigger_event}"')
    }
    if(inputId%ndetect%start_with('option_'))
            inputId<-paste0('option_',inputId)
    bclass = str_trim(glue("btn dropdown-item input-item dropdown-btn {class}"))
    buttons <- HTML(glue("<div role=\"button\" class=\"{bclass}\"{trigger}>\n    <input type=\"radio\" name=\"{inputId}\" id=\"{options}\" value=\"{options}\">\n  <span class=\"mdi mdi-{check_icon} icon-left\"></span><span class='dropdown-label'>{labels}</span><span class=\"mdi mdi-menu-right float-right icon-right\"></span></div>") %sep%
        "\n")
    div(id = inputId, class = "btn-group-toggle dropdown-group ao-radio-button-grp", `data-toggle` = "buttons",
        buttons)
    # Returns: [HTML]
}
