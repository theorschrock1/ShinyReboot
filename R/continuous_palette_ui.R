#' Render a continuous palette ui.

#' @name continuous_palette_ui
#' @param inputId  \code{[string]}
#' @param data_range  \code{[numeric]}  Must have an exact length of \code{2}.
#' @param selected  \code{[string]}  Defaults to \code{'Blues'}
#' @return \code{continuous_palette_ui}: \code{[html]}
#' @export
continuous_palette_ui <- function(inputId, data_range, selected = "Blues",stepped=FALSE,n_steps=4,selected_range=NULL,selected_values=NULL,color_min=NULL,color_max=NULL){
 ns<- NS(inputId)
  .continuous_palette_ui(inputId=ns("cont_pal"),data_range=data_range, selected = selected,stepped=stepped,n_steps=n_steps,selected_range=selected_range,selected_values=selected_values,color_min=color_min,color_max=color_max)
}
.continuous_palette_ui <- function(inputId, data_range, selected = "Blues",stepped=FALSE,n_steps=4,selected_range=NULL,selected_values=NULL,color_min=NULL,color_max=NULL) {
    # Render a continuous palette ui
    assert_string(inputId)
    assert_numeric(data_range, len = 2)
    assert_string(selected)
    ms = function(x) paste0(inputId, "-", x)


    pal_colors<-continuous_pal(selected,n=3)
    if(is.null(color_min))
        color_min<- pal_colors[1]
    if(is.null(color_max))
        color_max<- pal_colors[3]

    c(data_min,data_mid,data_max)%<-%c(min(data_range),mean(data_range),max(data_range))
    out <- flexCol(id = inputId, class = "w-100 c-palette-picker",`data-min`=data_min,`data-mid`=data_mid,`data-max`=data_max)
    if(nnull(selected_range)){
        c(data_min,data_mid,data_max)%<-%c(min(selected_range),mean(selected_range),max(selected_range))
    }
    c(selected_min,selected_mid,selected_max)%<-%c(data_min,data_mid,data_max)

     if(nnull(selected_values)){
        c(selected_min,selected_mid,selected_max)%<-%sort(selected_values)
    }
    # restoreInput(inputId,
    #              list(
    #                  palette = selected,
    #                  colors = c(color_min,
    #                             color_mid,
    #                             color_max),
    #                  data_range = c(data_min,
    #                                 data_mid,
    #                                 data_max),
    #                  stepped = stepped
    #              ))

    c(handle_min,handle_mid,handle_max)%<-%rescale( c(selected_min,selected_mid,selected_max),to=c(0,1),from=c(data_min,data_max))

    sel_palette=div(id=ms('selected_c_palette'),`data-handle_min`=handle_min,`data-handle_mid`=handle_mid,`data-handle_max`=handle_max)
    inner <- tagList(flexRow(continuous_pallete_picker(inputId = ms("palette_picker"),selected = selected),
                           icon_btn(ms("reset_palette"),icon='refresh',class='ml-1 mdi-xs rounded-0')),
        flexRow(class = "w-100", tags$span(class = "range-label  disabled mr-auto small",
        "Min"), tags$span(class = "range-label mr-auto small  disabled", "Mid"), tags$span(class = "range-label small disabled",
        "Max")), flexRow(class = "range-inputs w-100", tags$input(id = ms("variable_min"),
        `data-min` =data_min, `data-handle` = "handle_min", type = "text", class = "p-0  rounded-0 my-group3 form-control shadow-none disabled w-15 mr-auto",
        value = signif(selected_min, 3), disabled = "disabled"), tags$input(id = ms("variable_mid"),
        `data-mid` = data_mid, `data-handle` = "handle_mid", type = "text", class = "text-center p-0 rounded-0 my-group3 form-control shadow-none disabled w-15 mr-auto",
        value = signif(selected_mid, 3), disabled = "disabled"), tags$input(id = ms("variable_max"),
        `data-max` = data_max, `data-handle` = "handle_max", type = "text", class = "p-0 rounded-0 my-group3 form-control shadow-none disabled w-15 text-right",
        value = signif(selected_max, 3), disabled = "disabled")), flexRow(class = "w-100",
        default_color_picker(ms("color_min"),value = color_min, height = "32px", width = "31px", class = "spectrum_lim p-1",`data-id`='color_min'),
        flexCol(class = "cont_p_selected border mt-1 p-1 flex-fill ", div(class = "c_palette",sel_palette)),
        default_color_picker(ms("color_max"),value=color_max, height = "32px", width = "31px", class = "spectrum_lim p-1",`data-id`='color_max')),
        flexRow(div(class = "form-check px-3  py-0 mr-auto", tags$input(type = "checkbox",
            class = "form-check-input mycheck", id = ms("flip")), tags$label(class = "form-check-label mycheck-label m-0 p-0",
            `for` = "exampleCheck1", "Reversed")), div(class = "form-check px-3  py-0",
            tags$input(id = ms("edit_range"), type = "checkbox", class = "form-check-input mycheck"),
            tags$label(class = "form-check-label mycheck-label m-0 p-0", `for` = "exampleCheck1",
                "Edit Range"))), div(class = "ml-1 step-group my-group input-group input-group-sm",
            div(class = "input-group-prepend", div(class = "input-group-text pl-0 m-0 my-group bg-white border-0",
                tags$input(id = ms("stepped_range"), class = "check2", type = "checkbox",value=js_logical(stepped)),
                tags$span(class = "ml-1 small",
                  "Stepped Color"))),
               tags$input(id = ms("n_steps"), type = "number",
                class = "text-center p-0 rounded-0 my-group form-control shadow-none disabled",
                value = n_steps, disabled = "disabled"), div(class = "input-group-append",
                tags$span(class = "input-group-text pl-0 m-0 my-group bg-white border-0 ",
                  tags$span(id = ms("steps-label"), class = "ml-1 small disabled", "Steps")))))
     out<-out %>%
        tagAppendChildren(inner) %>%
        attachDependencies(html_dependency_continuous_palette_picker())

 tagList(tags$head(singleton(shinyjs::useShinyjs()),out))
    # Returns: \code{[html]}
}
#' @export
update_continuous_palette=function(inputId,data_range=NULL,selected_values=NULL,selected_range=NULL,color_min=NULL,color_max=NULL,selected=NULL,stepped=NULL,n_steps=NULL){
  ms=function(x){
        paste0(inputId,"-",x)
    }


    session=getDefaultReactiveDomain()
    if(nnull(selected)){
    shinyWidgets::updatePickerInput(session,ms('palette_picker'),selected=selected)
    }
    if(nnull(color_min)){
    update_default_color_picker(ms('color_min'),value=color_min)
    }
    if(nnull(color_max)){
    update_default_color_picker(ms('color_max'),value=color_max)
    }
         dvals<-selected_values%or%selected_range
         if(nnull(dvals)){
         if(is.null(selected_values)){
            data_min=min(dvals)
            data_max=max(dvals)
            data_mid=(data_min+data_max)/2
         }else{
             dvals<-sort(dvals)
             data_min=min(dvals)
             data_max=max(dvals)
             data_mid=dvals[2]
         }

        if(nnull(data_min)){
        updateNumericInput(session,ms('variable_min'),value=data_min)
        }
        if(nnull(data_mid)){
        updateNumericInput(session,ms('variable_mid'),value=data_mid)
        }
        if(nnull(data_max)){
        updateNumericInput(session,ms('variable_max'),value=data_max)
        }
         }

    if(nnull(n_steps)){
        updateNumericInput(session,ms("n_steps"),value=n_steps)
    }
    if(nnull(stepped)){
    updateCheckboxInput(session,ms("stepped"),value=stepped)
    }
         message=NULL
         if(nnull(selected_range)){

             message = drop_nulls(
                 list(
                     selected_min =min(selected_range),
                     selected_max = max(selected_range)
                 )
             )

         }
         if(nnull(data_range)){
             message$data_min =min(data_range)
             message$data_max = max(data_range)
             message$data_mid =(min(data_range)+max(data_range))/2
         }
             updateInput(inputId,value=message)

  #updateInput(inputId =inputId,value=   message )
}
