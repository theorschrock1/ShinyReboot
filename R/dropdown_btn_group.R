#' Create an dropdown button group.

#' @name dropdown_btn_group
#' @param ...
#' @param inputIds  [character]
#' @param labels  [character]  Must have an exact length of length.  Must have an exact length of inputIds.
#' @param state  [character]  Defaults to ''
#' @param types  [character]  Must have an exact length of or equal to one of the following: [1,length(inputIds)].
#' @param class  [character]  Defaults to ''
#' @param check_icon  [character]  Must have an exact length of 1.  Defaults to 'check-bold'
#' @return \code{dropdown_btn_group}: [HTML]
#' @examples

#'  dropdown_btn_group(inputIds = c('copy', 'duplicate', 'edit'),
#'  labels = c('Copy', 'Duplicate', 'Edit'), types = c('action',
#'  'action', 'model'))

#' @export
dropdown_btn_group <- function(..., inputIds, labels, state = "", types, class = "",
    check_icon = "check-bold") {
    # Create an dropdown button group
    assert_character(inputIds)
    assert_character(labels, len = length(inputIds))
    assert_character(class)
    assert_any(types, check_character(len = 1), check_character(len = length(inputIds)))
    assert_character(check_icon, len = 1)
    is_submenu=FALSE
    if (len(types) == 1 && types == "submenu")
        is_submenu = TRUE
    submenu <- chr_approx(c(TRUE, FALSE), c("dropright", ""))(is_submenu)
    submenu2 <- chr_approx(c(TRUE, FALSE), c("submenu", ""))(is_submenu)
    btypes <-
        chr_approx(c("action", "checkbox", "submenu", "model"),
                   c("","data-toggle=\"buttons\"",
                    glue("aria-haspopup =\"true\"  aria-expanded=\"false\"",
                     "")
                   ))(types)

    aoType <-
        chr_approx(c("action", "checkbox", "submenu", "model"),
                   c("ao-action-button",
                     "ao-check-button",
                     "",
                     "ao-action-button")
                   )(types)
    labels <- ifelse(types == "model", paste0(labels, "..."), labels)
    bclass = str_trim(glue("btn dropdown-item dropdown-btn {submenu2} {state} {class}  {aoType}"))
    buttons <- HTML(glue("<div id=\"{inputIds}\" role=\"button\" class=\"{bclass}\" {btypes} >\n  <span class=\"mdi mdi-{check_icon} icon-left\"></span><span class='dropdown-label'>{labels}</span><span class=\"mdi mdi-menu-right float-right icon-right\"></span></div>") %sep%
        "\n")
    div(class = glue("btn-group-toggle dropdown-group {submenu}"), buttons, ...)
    # Returns: [HTML]
}
