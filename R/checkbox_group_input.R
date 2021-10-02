#' Create a checkbox group input.

#' @name checkbox_group_input
#' @param ...
#' @param inputId  \code{[string]}
#' @param label  \code{[string]}  NULL is ok.
#' @param choices  \code{[atomic_vector]}
#' @param selected  \code{[choice]}  Possible values: \code{choices}.  NULL is ok.  Defaults to \code{NULL}
#' @param clear_filter  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param search  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @param options_dropdown  \code{[logical]}  Must have an exact length of \code{1}.  Defaults to \code{TRUE}
#' @return \code{checkbox_group_input}: \code{[html]}
#' @examples

#'  checkbox_group_input(inputId = 'myid', label = 'label', choices = names(mtcars))
#'  checkbox_group_input(inputId = 'myid', label = 'label', choices = c(TRUE,FALSE),selected=c(T,F),type='radio')
#' @export
checkbox_group_input <- function(..., inputId, label, choices,type='checkbox', selected = NULL,
    clear_filter = TRUE,as_dropdown=FALSE, search = TRUE, options_dropdown = TRUE,variable_id=NULL) {
    # Create a radio slider input
    dots = list(...)
    if (l(dots) > 0)
        assert_names(names(dots))
    assert_string(inputId)
    assert_string(label, null.ok = TRUE)
    assert_string(variable_id,null.ok=TRUE)
    if(is.null(variable_id))
        variable_id=inputId
    assert_atomic_vector(choices)
    if(nnull(selected)){
    assert_subset(selected, choices = choices)
    }
    assert_logical(clear_filter, len = 1)
    assert_logical(search, len = 1)
    assert_logical(options_dropdown, len = 1)
    ms = function(x) paste0(inputId, "-", x)



    gui<-check_group_ui(create_options(choices = choices, selected = selected,type=type),ms =ms,show_searchbox =as_dropdown&search,select_all_btns=(type=='checkbox'))
    displaydd<-""
    if(as_dropdown){
       main_ui<- standard_dropdown(inputId=ms("ddmenu"),target=glue("#{ms('dropbtn')}"),width='fit',class='bg-white p-1',
                      gui
                      )
    }else{
        displaydd="d-none "
        main_ui<-tagList(gui,standard_dropdown(inputId=ms("ddmenu"),target=glue("#{ms('dropbtn')}"),width='fit',class='bg-white p-1'))
    }
    ddtext=selected
    if(is.null(selected)){
        ddtext="(All)"
    }
    if(l(selected)>1){
        ddtext=glue("({l(selected)} selected)")
    }
    ddbtn= h_arrange(id=ms('dropbtn'),class=glue('mb-0 p-0 pl-1 w-100 border'),span(class='m-0 selected-label mr-auto',ddtext),div(icon_mdi("menu-down",class='mdi-md'),class='border-left px-1'))
   if(as_dropdown==FALSE){
     remove_class(ddbtn)<-"d-flex"
     append_class(ddbtn) <-'d-none'
   }

    toolbar <- filter_head(inputId=inputId,label=label, clear_filter = clear_filter , search = search&as_dropdown==FALSE, options_dropdown=options_dropdown)

inputType<-
    chr_approx(c(TRUE,FALSE),c("drop-list",'check-list'))(as_dropdown)
    out <-
        flexCol(
            class = glue("ao-checkbox-group data-filter w-100 {inputType}"),`data-id`=variable_id,
            id = inputId,
            toolbar,
            ddbtn,
            main_ui
        )

    out %>% tagAppendAttributes(...) %>% attachDependencies(html_dependency_ao_checkbox_group(),
        append = TRUE)
    # Returns: \code{[html]}
}
create_options =function(choices,selected,type=c("checkbox",'radio'),radio_all_option=TRUE){
    assert_choice(type,c("checkbox",'radio'))
    on="check-box-outline"
    off="checkbox-blank-outline"
    radio_all=NULL
    if(length(selected)==length(choices))
        selected=NULL
    if(type=='radio'){
        if(radio_all_option){
            all_check=""
            if(is.null(selected))
                all_check=" checked"
           radio_all<- h_arrange(
                class = "checkbox-row p-0",
                justify = "start",
                div(
                    class = glue("select-option radio radio-all{all_check} "),
                    icon_mdi("checkbox-blank-outline", class = "mdi-md"),
                    icon_mdi("check-box-outline", class = "mdi-md"),
                    icon_mdi('radiobox-blank', class = "mdi-md"),
                    icon_mdi('radiobox-marked', class = "mdi-md")
                ),
                div(class = "ml-2 flex-fill check-label", "(All)")
            )
        }

        if(length(selected)>1)
            g_stop("selected must be length(1) for radio options")
       off='radiobox-blank'
       on='radiobox-marked'
    }
        default=''
    if(type=='checkbox')
        default=" checked"
    checked <- rep(default, l(choices))

if (nnull(selected))
    checked <- (sUtils::chr_approx(c(FALSE, TRUE), c("", " checked")))(choices %in%selected)

    div(class = "d-flex flex-column p-1 scroll-content checkgroup",radio_all, lapply(expr_glue(
        h_arrange(
            class = "checkbox-row p-0",
            justify = "start",
            div(
                class = "select-option {type}{checked}",
                icon_mdi("checkbox-blank-outline", class = "mdi-md"),
                icon_mdi("check-box-outline", class = "mdi-md"),
                icon_mdi('radiobox-blank', class = "mdi-md"),
                icon_mdi('radiobox-marked', class = "mdi-md")
            ),
            div(class = "ml-2 flex-fill check-label", "{choices}")
        )
    ), eval))
}

check_group_ui=function(options_html,select_all_btns=TRUE,show_searchbox=FALSE,ms){
    select_btns= NULL
    search_display<-' d-none'
    sbtn_display=""
    if(show_searchbox){
        search_display<-""
        sbtn_display<-' d-none'
    }
    if(select_all_btns){
       select_btns= h_arrange(
            class = "btn-group",
            div(class = "btn btn-sm btn-light btn-all py-0 w-50 border",
                "All"),
            div(class = "btn btn-sm w-50 btn-none btn-light py-0  border",
                "None")
        )
    }

tagList(div(class='checkgroup-wrapper non-scroll-content w-100',div(
        class = glue("mb-1 border search-box{search_display}"),
        tags$input(
            id = ms("search"),
            type = "text",
            class = "form-control form-control-sm border-0 shadow-none",
            placeholder = "Search"
        ),
        icon_btn(ms("hide_search"), "close", class = glue("mdi-sm mag-btn py-0{ sbtn_display}"))
    ),select_btns),options_html)
}



