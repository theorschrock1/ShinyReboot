#
# This is a Shiny web application. You can run the application by clicking
# the 'Run App' button above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#


library(shiny)
library(bootstraplib)
library(exprTools)
library(ShinyReboot)
bs_global_theme()
ui <- fluidPage(
    bs_dependencies(theme = bs_global_get()),
# head ----
    tags$head(
        HTML('<link href="https://fonts.googleapis.com/css2?family=Varela&display=swap" rel="stylesheet">
        <link href="https://fonts.googleapis.com/css2?family=Inter&display=swap" rel="stylesheet"><link href="https://fonts.googleapis.com/css2?family=Inter&family=Roboto&display=swap" rel="stylesheet">
             <link href="https://cdn.materialdesignicons.com/5.4.55/css/materialdesignicons.min.css" media="all" rel="stylesheet">'),
        reboot_Dependancies(),
        load_app_css(),
        load_app_js()
    ),
# fixed nav top ----
    ao_nav_fixed_top(
      navbar_row(class='navbar-dark bg-dark',
                 render_main_menu()),
      navbar_row(tags$a(class='pt-1',href="#",
                   tags$img(src="logo.png",width="30",height="18", alt="", loading="lazy")),
                 icon_tool_bar(
        icon_button_group(inputId=c("undo","redo","save"),c("arrow-left","arrow-right","floppy"),c("Undo","Redo","Save")),
        icon_button_group(
          c("data_source_new","data_source_refresh","pause_data_updates"),
          c("database-plus","database-refresh","database-lock"),
          c("New data source","Refresh data source","Pause auto updates")),
        icon_button_group(
          c("new_chart","clear_chart","transpose"),
          c("chart-box-plus-outline","tab-remove","rotate-left-variant"),
          c("New Chart","Clear Chart","Swap rows and colums")),
        icon_radio_group(inputId="sort_options",
                         c('sort_remove',
                           'sort_ascending',
                           'sort_descending'),
                         c('sort-variant-remove',
                           'sort-ascending',
                           'sort-descending'),
                         c('Clear sort',
                           'Sort ascending',
                           'Sort descending'))
      ))
    ),
# menutop ----

# content -----------------
    div(class="d-flex p-0 m-0  h-100",
# sidebar ------
        sidebar_left(id="sidebarMenu",class='d-md-block bg-white shadow-sm',
                     sidebar_sticky(
                         navList(nav_id='sidebar-left-nav',class='mt-0',
                                 format = 'justified',
                                 navItem(tab_id="data-variables","Data"),
                                 navItem(tab_id='analytics','Analytics')
                                 ),
                         navListContent(nav_id='sidebar-left-nav',
                                        div(id='data-variables',
                                            flexRow(class='nav-card overflow-auto flex-fill px-4',
                                            pill_card(inputId ="nav_dimensions",
                                                      sort=FALSE,
                                                      fallbackOnBody = TRUE,
                                                      group=list(
                                                          name='nav_dimensions',
                                                          pull='clone',
                                                          put=FALSE),

                                                      dragClass='drag',
                                                      animation= 25,

                                                      pill_item(
                                                          id = c("Date",
                                                                 "EmployeeID",
                                                                 "Location",
                                                                 "Store"),
                                                          label = c("Date",
                                                                    "EmployeeID",
                                                                    "Location",
                                                                    "Store"),
                                                          type = 'dimension'
                                                      ))),
                                            flexRow(class='nav-card overflow-auto flex-fill px-4',
                                                    pill_card(inputId ="measure_dimensions",
                                                              sort=FALSE,
                                                              fallbackOnBody = TRUE,
                                                              group=list(
                                                                  name='nav_measures',
                                                                  pull='clone',
                                                                  put=FALSE),

                                                              dragClass='drag',
                                                              animation= 25,

                                                              pill_item(
                                                                  id = c("Items",
                                                                         "Labor Hours",
                                                                         "Overtime hours",
                                                                         "Sales"),
                                                                  label = c("Items",
                                                                            "Labor Hours",
                                                                            "Overtime hours",
                                                                            "Sales")
                                                              )))
                                            )
                         )
                     )),

# main----
               main(class = "col-md-9 ml-sm-auto col-lg-10 p-0 m-0 h-100",
# cards----
                               flexBox(class='p-1 flex-fill h-100',
                    flexCol(class='px-1',
                    pill_card(
                       icon="layers-outline",
                        inputId = "pages",
                        name = "Pages",
                        group=list(name='pills',put=c("pills","nav_dimensions","nav_measures")),
                        removeOnSpill=TRUE,
                       fallbackOnBody = TRUE,
                        ghostClass='ghost-class-row',
                        dragClass='drag',
                    ),
                    pill_card(
                      icon="filter-outline",
                      inputId = "filters",
                      name = "Filters",
                      group=list(name='pills',put=c("pills","nav_dimensions","nav_measures")),
                      removeOnSpill=TRUE,
                      fallbackOnBody = TRUE,
                      ghostClass='ghost-class-row',
                      dragClass='drag',
                    ),
                    pill_card(
                      inputId = "marks",
                      name = "Marks",
                      icon = 'bookmark-multiple-outline',
                      sort_ops = sortable_options(
                        'marks',
                        pull = TRUE,
                        put = list(class_types = c(".pill-measure", ".pill-dimension")),
                        removeOnSpill = TRUE,
                        sort = TRUE,
                        draggable = '.pill-item'
                      ),
                      btn_block(
                        `data-id` = 'btn_block',
                        btn_block_row(block_btns(
                          inputId = tmpids(3),
                          label = c("Color", "Size", "Label"),
                          icon = c('palette-outline', "chart-bubble", "text-recognition")
                        )),
                        btn_block_row(block_btns(
                          inputId = tmpids(3),
                          label = c("Detail", "Tooltip", "Shape"),
                          icon = c('grain', 'tooltip-text-outline', 'shape-outline')
                        ))
                      )
                    ),

                    flexCol(class = "flex-fill",
# rowcard----
                                      pill_card(
                                        icon="view-sequential",
                                        inputId = "rows",
                                        name = "Rows",
                                        type='row',
                                        group=list(name='pills',put=c("pills","nav_dimensions","nav_measures")),
                                        removeOnSpill=TRUE,
                                        invertSwap=TRUE,
                                        ghostClass='ghost-class-row',
                                        dragClass='drag',

                                        draggable='.pill-item'



                                     ),
# colcard----
                                        pill_card(
                                          icon="view-column",
                                          inputId = "cols",
                                          name = "Columns",
                                          type='row',
                                          invertSwap=TRUE,
                                          group=list(name='pills',put=c("pills",
                                                                        "nav_dimensions",
                                                                        "nav_measures")),
                                          removeOnSpill=TRUE,
                                          draggable='.pill-item',
                                          ghostClass='ghost-class-row',
                                          dragClass='drag'

                                        ),
# graph-----------------
                              flexCol(class="flex-fill bg-white w-100")
                            )


            )

     )
    )
# ----
)
# server -----

server <- function(input, output,session) {

    observeEvent(input$rows,{
        glue("rows: {input$rows%sep%','}") %>% print()
    })
  observeEvent(input$sort_options,{
      glue("sort_options: {input$sort_options%sep%','}") %>% print()
    })
    observeEvent(input$chart,{
        glue("chart: {input$chart%sep%','}") %>% print()
    })
}
# dropdown_menu(label="File",class='menu-item',
#               dropdown_btn_group(inputIds=letters[1:3],labels=c("Add to Sheet","New Calculation","Show Filter"),types=c("action","action","checkbox")),
#               dropdown_btn_group(inputIds=letters[4:6],labels=c("Copy","Duplicate","Edit"),types=c("action","action","model")),
#               dropdown_radio_group(inputId="letters",options=letters[1:4],labels=c("Currency","Percentage","Number","Units")),
#               dropdown_submenu(label="More Options",dropdown_btn_group(inputIds=letters[1:2],labels=letters[1:2],types=c("action","action"))))
# Run the application
shinyApp(ui = ui, server = server)
