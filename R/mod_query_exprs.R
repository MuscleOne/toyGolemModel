#' query_exprs UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_query_exprs_ui <- function(id){
  ns <- NS(id)
  tagList(
    mod_query_exprs_select_studies_ui(ns("data"), dataset_label="studies",
                                      dataset_choices=name_libraries),
    mod_query_exprs_select_cohorts_ui(ns("time"), characteristics="month_post_implantation"),
    mod_query_exprs_select_cohorts_ui(ns("metal"), characteristics="metal_implanted")
  )
}

#' query_exprs Server Functions
#'
#' @noRd
mod_query_exprs_server <- function(id){
  moduleServer( id, function(input, output, session){
    ns <- session$ns
    selected = mod_query_exprs_select_studies_server("data")

    sample = selected$selected_sample
    exprs = selected$selected_exprs
    selected_library = selected$selected_library

    # the input and the logical result of condition "collected_time"
    cohort_time_condt =
      mod_query_exprs_select_cohorts_server("time", sample, characteristics="month_post_implantation")
    cohort_time = cohort_time_condt$cohort_condt
    time_condt = cohort_time_condt$cohort_selectinput

    # the input and the logical result of condition "metal_embodied"
    cohort_metal_condt =
      mod_query_exprs_select_cohorts_server("metal", sample, characteristics="metal_implanted")
    cohort_metal = cohort_metal_condt$cohort_condt
    metal_condt = cohort_metal_condt$cohort_selectinput

    # observe(print({sample()[cohort_time()&cohort_metal(),]}))
    cohort_col_selected = reactive({sample()[cohort_time()&cohort_metal(), 2]})

    list(cohort_sample = reactive({sample()[cohort_time()&cohort_metal(),]}),
         cohort_exprs =
           reactive({
             exprs()[, c('transcript_id', cohort_col_selected())]
           }),# cohort_expr
         time_condt = reactive(time_condt()),
         metal_condt = reactive(metal_condt()),
         library_condt = reactive(selected_library())
    )# list

  })
}

## To be copied in the UI
# mod_query_exprs_ui("query_exprs_1")

## To be copied in the server
# mod_query_exprs_server("query_exprs_1")
