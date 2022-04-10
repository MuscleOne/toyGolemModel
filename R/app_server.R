#' The application server-side
#'
#' @param input,output,session Internal parameters for {shiny}.
#'     DO NOT REMOVE.
#' @import shiny
#' @export
#' @noRd
app_server <- function(input, output, session) {
  # Your application server logic

  ## >>>>
  ##### backend: about the homepage ##########
  observeEvent(input$jump_to_expression, {
    updateTabsetPanel(session, "intabset", selected = "expression")
  })

  # observeEvent(input$jump_to_concentration, {
  #   updateTabsetPanel(session, "intabset", selected = "concentration")
  # })
  #
  # observeEvent(input$jump_to_weight, {
  #   updateTabsetPanel(session, "intabset", selected = "weight")
  # })
  ##### backend: about the homepage ##########


  ##### backend: to query data of serum small RNAs and the samples ##########
  # obtain a table of selected data/metadata, as well as condition we used
  cohort_data = mod_query_exprs_server("condt")

  # dataframe table of sample information and expression matrix
  df_sample = cohort_data$cohort_sample
  df_exprs = cohort_data$cohort_exprs

  # what condition we used to make query
  the_library = cohort_data$library_condt
  time = cohort_data$time_condt
  metal = cohort_data$metal_condt

  # # the display form of the selected sample data
  preview_sample = reactive({display_sample(df_sample())})
  # # display the data of sample information as well as expression
  mod_display_table_server("sample", preview_sample, remove_sub = F)
  #
  # ##
  observe(print(df_sample()[1:5, 2]))
  # observe(print(df_exprs()[1:5, ]))

  mod_display_table_server("exprs", df_exprs, remove_sub = F)
  # have a look of conditions we used to make query
  output$condition = renderPrint(list(time(), metal(), the_library()))

  # the download function
  mod_download_server("sample", df_sample, the_library, metal=metal, month=time, download_item="sample_info")
  mod_download_server("exprs", df_exprs, the_library, metal=metal, month=time, download_item="exprssion_matrix")
  ###### backend: to query data of serum small RNAs and the samples ##########
  ## <<<<

}
