#' Create pill items.

#' @name pill_item
#' @param id  [character] the pill ids
#' @param label  [character] the pill labels
#' @param type  [character]  Must have an exact length of or equal to one of the following: [1,length(id)].  Defaults to 'measure'
#' @return \code{pill_item}: [html]
#' @examples

#'  pill_card(pill_item(id = c('sales', 'transactions', 'traffic',
#'  'basket size'), label = c('sales', 'transactions', 'traffic',
#'  'basket size')), inputId = 'one', name = 'Chart', icon = 'test')

#' @export
pill_item <- function(id, label,type = "measure",data=list(),icon='numeric',is_hierachy=FALSE) {
    # Create pill items
    assert_character(id)
    assert_character(label, len=length(id))
    assert_list(data)
    assert_choice(type,c("measure",'dimension'))
    order=ifelse(type=='measure',2,1)

    assert_any(type, check_character(len = 1), check_character(len = length(id)))
    class=glue("pill-item pill-{type} order-{order}")
    data_attributes<-"`data-null`=NULL"
    if('id'%nin%names(data)){
        data$id=id
    }
    hierachy_class<-chr_approx(c(TRUE,FALSE), c(" hierachy collapsed",""))(is_hierachy)
   # print(data)
    if(length(data)>0){
    # input_type=sapply(data,function(x){
    #     if(length(x)!=length(id))
    #         g_stop("length of data attributes not equal to length of ids")
    #     if(is.logical(x))return("checkbox")
    #     if(is.character(x))return('radio')
    #     if(is.numeric(x))return('action')
    #     g_stop('data attributes must be logical,numeric, or character')
    # })
    data_init=lapply(data,function(x){
        if(is.logical(x))x<-js_logical(x)
        if(is.numeric(x))x<-as.character(x)
          x[is.na(x)]<-"NA"
          glue("'{x}'")
        })

    data_names<-glue('`data-{names(data)}`')
    data_names[data_names=='`data-radio_id`']<-'`data-id`'

    data_attributes=map2(data_names,data_init,function(x,y)paste0(x,"=",y)) %>%
        reduce(function(x,y){paste(x,y,sep=',')})
    }
    out <- expr_glue(tags$div(id="{id}",
                              `data-name`='{label}',
                                  {data_attributes},
                                  class='d-flex flex-row {class} align-items-center{hierachy_class}',
                                  div(class='pill-data-icon flex-nowrap',span(class='data-calculation',"="),icon_mdi('{icon}')),
                              div(class='pill-area d-flex flex-fill',
                                  div(class='modify-hierachy expand',icon_mdi('plus-box-outline')),div(class='modify-hierachy collapse',icon_mdi('minus-box-outline')),tags$div("{label}",class="pill-label flex-fill",`data-id`="{id}"),div(icon_mdi('menu-down',class='icon-right dropdown-handle float-right')))
                                  )
                         ) %>% exprs_eval()

    out
    # Returns: [html]
}
