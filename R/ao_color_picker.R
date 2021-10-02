#' create html color picker.

#' @name ao_color_picker
#' @param ...
#' @param inputId  \code{[string]}
#' @param color  \code{[choice]}  Possible values: \code{unique(c(black(), dgreys(), white(), lgreys(), oranges(), purples(), yellows(), l_purples(),l_greens(), pinks(), d_greens(), reds(), l_blues(), browns(), blues(), bgreys()))}.  Defaults to \code{'#0A5ED3'}
#' @param opacity  \code{[number]}  Must be greater than \code{0}.  Must be less than \code{1}.  Defaults to \code{0}
#' @return \code{ao_color_picker}: \code{[html]}
#' @export
ao_color_picker <- function(..., inputId, color = "#0A5ED3", opacity = 0) {
    # create html color picker
    assert_string(inputId)
    assert_string(color)
    assert_number(opacity, lower = 0, upper = 1)



    out <-
        div(
            id = inputId,
            class = "w-100 aoColorPicker",
            h_arrange(
                class = "my-1",
                div(class = "color-label px-1 text-secondary",
                    "Color"),
                div(class = "border-top border-secondary w-100")
            ),
            h_arrange(
                color_picker_col(list(black(),
                                      dgreys())),
                color_picker_col(list(white(), lgreys())),
                color_picker_col(list(oranges(),
                                      purples())),
                color_picker_col(list(yellows(), l_purples())),
                color_picker_col(list(l_greens(),
                                      pinks())),
                color_picker_col(list(d_greens(), reds())),
                color_picker_col(list(l_blues(),
                                      browns())),
                color_picker_col(list(blues(), bgreys()))
            ),
            h_arrange(
                class = "my-1",
                div(
                    id = paste0(inputId,
                                "_colorpicked"),
                    class = "color-picked w-50 border rounded",
                    `data-color` = color,
                    `data-opacity` = opacity,
                    style=glue('background-color:{color}')
                )
            ),
            h_arrange(
                div(class = "color-label px-1 text-secondary", "Opacity"),
                div(class = "border-top border-secondary w-100")
            ),
            h_arrange(
                sliderInput(
                    paste0(inputId, "_opacity_slider"),
                    label = NULL,
                    min = 0,
                    max = 1,
                    step=.01,
                    value = opacity,
                    ticks = FALSE,
                    width = "75%"
                ),
                div(
                    class = "ml-1 slider-input-wrapper",
                    tags$input(
                        id = paste0(inputId, "_opacity_input"),
                        class = "text-right slider-form form-control rounded-0 form-control-sm",
                        value = paste0(opacity*100, "%"),
                        type = "text"
                    )
                )
            ),
            ...
        )
    out %>% attachDependencies(html_dependency_ao_color_picker(), append = TRUE)
    # Returns: \code{[html]}
}
#' @export
update_ao_color_picker=function(inputId,color,opacity,session=getDefaultReactiveDomain()){
    assert_string(inputId)
    assert_string(color)
    assert_number(opacity, lower = 0, upper = 1)

    message=list(color=color,opacity=opacity)
    session$sendInputMessage(inputId, message)
    return(invisible(NULL))
}
color_picker_cell = function(colors) {
    pos = "solo"
    if (l(colors) > 1) {
        pos <- c("top", rep("middle", l(colors) - 2), "bottom")
    }
    v_arrange(class = "mb-1",
              lapply(expr_glue(
                  div(
                      `data-color` = "{colors}",
                      class = "color-btn color-btn-{pos}",
                      style = "background-color:{colors}"
                  )
              ), eval))
}

color_picker_col=function(colors){
    v_arrange(lapply(colors,color_picker_cell))
}
# color_picker_row=function(colors){
#    h_arrange(lapply(colors,color_picker_col))
# }

oranges=function(n=3){
    rev(color_seq(colors=c("white","#f28e2b"),from=.3,to=1,length=n))
}
yellows=function(n=3){
    rev(color_seq(colors=c("white","#b6992d"),from=.3,to=1,length=n))
}
l_greens=function(n=3){
    rev(color_seq(colors=c("white","#509046"),from=.3,to=1,length=n))
}
d_greens=function(n=3){
    rev(color_seq(colors=c("white","#157448"),from=.3,to=1,length=n))
}
l_blues=function(n=3){
    rev(color_seq(colors=c("white","#4e79a7"),from=.3,to=1,length=n))
}
blues=function(n=3){
    rev(color_seq(colors=c("white","#0a5ed3"),from=.3,to=1,length=n))
}
purples=function(n=3){
    rev(color_seq(colors=c("white","#b637ff"),from=.3,to=1,length=n))
}
l_purples=function(n=3){
    rev(color_seq(colors=c("white","#a8759a"),from=.3,to=1,length=n))
}
pinks=function(n=3){
    rev(color_seq(colors=c("white","#e15759"),from=.3,to=1,length=n))
}
reds=function(n=3){
    rev(color_seq(colors=c("white","#dc3545"),from=.3,to=1,length=n))
}
browns=function(n=3){
    rev(color_seq(colors=c("white","#82614f"),from=.3,to=1,length=n))
}
bgreys=function(n=3){
    rev(color_seq(colors=c("white","#606b76"),from=.3,to=1,length=n))
}
black=function(n=3){
    "#000000"
}
white=function(n=3){
    "#fff"
}
dgreys=function(n=5){
    rev(color_seq(colors=c("#898989","#363a40"),from=0,to=1,length=n))
}
lgreys=function(n=5){
    color_seq(colors=c("#f5f5f5","#b4b4b4"),from=0,to=1,length=n)
}





