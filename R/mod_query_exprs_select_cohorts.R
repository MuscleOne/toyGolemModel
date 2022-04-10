#' query_exprs_select_cohorts UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @param characteristics characteristics of the cohorts, "month_post_implantation" or "metal_implanted"
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_query_exprs_select_cohorts_ui <- function(id, characteristics="month_post_implantation"){
  ns <- NS(id)
  selectizeInput(ns("char"),
                 paste(strsplit(characteristics, "_")[[1]], collapse=" "),
                 choices = NULL, multiple = TRUE,
                 options = list(placeholder = 'Show ALL'))
}

#' query_exprs_select_cohorts Server Functions
#'
#' @noRd
mod_query_exprs_select_cohorts_server <- function(id, data, characteristics="month_post_implantation"){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    observeEvent(data(), {
      updateSelectizeInput(session, "char",
                           choices=sort(unique(data()[, paste0(characteristics)])))
    })

    # the key commend to select the column in the input table we want!
    list(cohort_condt = reactive({
      if(is.null(input$char)) {
        data()[, paste0(characteristics)] %in% unique(data()[, paste0(characteristics)])
      } else {
        data()[, paste0(characteristics)] %in% input$char
      }
    }),#cohort_condt
    cohort_selectinput = reactive(input$char)
    ) # list
  })
}

## To be copied in the UI
# mod_query_exprs_select_cohorts_ui("query_exprs_select_cohorts_1")

## To be copied in the server
# mod_query_exprs_select_cohorts_server("query_exprs_select_cohorts_1")
