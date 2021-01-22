#' Continuos palette module.

#' @name continuous_palette_server
#' @param id  \code{[string]}
#' @param settings  \code{[reactive]}  list(list(unnamed = 'Must be unnamed', named = 'Must be named', unqiue = 'Names must be unique'))  The list must have the following structure: \code{list(data_range = numeric(length = 2), selected_range = numeric(NULL, len = 2),selected_values = numeric(NULL, len = 3), selected = string(), stepped = TF(NULL),n_steps = int(NULL))}.
#' @return \code{continuous_palette_server}: reactiveValues['data']
#' @examples

#'  if (interactive()) {
#'  library('shiny')
#'  library('ShinyReboot')
#'  library('bslib')
#'  bs_global_theme()
#'  ui <- fluidPage(bs_theme_dependencies(theme = bs_global_get()),
#'  titlePanel('cont_pal module example'), uiOutput('test'))
#'  server <- function(input, output, session) {
#'  output$test = renderUI({
#'  continuous_palette_ui(inputId = 'mod_id', data_range = c(0,
#'  100))
#'  })
#'  settings = reactive({
#'  list(data_range = c(0, 100), selected_values = c(2,
#'  40, 90))
#'  })
#'  out <- continuous_palette_server(id = 'mod_id', settings = settings)
#'  observeEvent(out$data, {
#'  print(out$data)
#'  })
#'  }
#'  shinyApp(ui, server)
#'  }
#' @export
continuous_palette_server <- function(id, settings) {
    # Continuos palette module
    id <- assert_string(id)
    moduleServer(id, function(input, output, session) {
        ns <- session$ns
        settings <- assert_reactive(x = settings, .m = "cont_pal_server", type = "named_list", 
            structure = list(data_range = numeric(length = 2), selected_range = numeric(NULL, 
                len = 2), selected_values = numeric(NULL, len = 3), selected = string(), 
                stepped = TF(NULL), n_steps = int(NULL)))
        observeEvent(settings(), {
            req(input$cont_pal)
            s <- settings()
            update_continuous_palette(inputId = "cont_pal", data_range = s$data_range, selected = "Blues", 
                selected_range = s$selected_range, selected_values = s$selected_values, 
                stepped = s$stepped, n_steps = s$n_steps)
        })
        vals <- reactiveValues(data = NULL)
        user_inputs <- eventReactive(input$cont_pal, {
            tmp = lapply(input$cont_pal, unlist)
            vals$data = tmp
            tmp
        })
        observeEvent(user_inputs(), {
            inps <- user_inputs()
            req(inps$n_steps)
            if (inps$stepped) {
                s <- settings()
                colors = unlist(inps$color_range)
                data_range = unlist(inps$data_range)
                c(org_min, org_max) %<-% sort(s$data_range)
                if (org_min < min(data_range)) {
                  data_range = c(org_min, data_range)
                  colors <- c(colors[1], colors)
                }
                if (org_max > max(data_range)) {
                  data_range = c(data_range, org_max)
                  colors <- c(colors, colors[length(colors)])
                }
                removeUI(selector = paste0("#", ns("stepped_divs")), immediate = TRUE)
                shinyjs::addClass(id = "cont_pal", class = "stepped")
                shinyjs::removeClass(id = "cont_pal-selected_c_palette", class = "h-100")
                insertUI(selector = paste0("#", ns("cont_pal-selected_c_palette")), where = "afterEnd", 
                  ui = div(id = ns("stepped_divs"), class = "d-flex p-0 m-0 border w-100 h-100", 
                    gradient_divs(class = "flex-fill h-100", n = unlist(inps$n_steps), domain = colors, 
                      range = data_range)), immediate = TRUE)
                return()
            }
            shinyjs::addClass(id = "cont_pal-selected_c_palette", class = "h-100")
            shinyjs::removeClass(id = "cont_pal", class = "stepped")
            removeUI(selector = paste0("#", ns("stepped_divs")), immediate = TRUE)
        })
        return(vals)
    })
    # Returns: reactiveValues['data']
}
