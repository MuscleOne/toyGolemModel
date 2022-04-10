#' query_exprs_select_studies UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_query_exprs_select_studies_ui <- function(id, dataset_label, dataset_choices){
  ns <- NS(id)
  selectInput(ns("dataset"), dataset_label, choices = dataset_choices)
}

#' query_exprs_select_studies Server Functions
#'
#' @noRd
mod_query_exprs_select_studies_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    list(selected_sample = reactive(l_sample[[input$dataset]]),
         selected_exprs = reactive(l_exprs[[input$dataset]]),
         selected_library = reactive(input$dataset)
    )
  })
}

## To be copied in the UI
# mod_query_exprs_select_studies_ui("query_exprs_select_studies_1")

## To be copied in the server
# mod_query_exprs_select_studies_server("query_exprs_select_studies_1")
