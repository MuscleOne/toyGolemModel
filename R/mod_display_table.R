#' display_table UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
#' @importFrom reactable reactableOutput reactable colDef renderReactable
mod_display_table_ui <- function(id){
  ns <- NS(id)
  reactableOutput(ns("df"))
}

#' display_table Server Functions
#' @importFrom reactable reactableOutput reactable colDef renderReactable
#' @noRd
mod_display_table_server <- function(id, df_table, remove_sub = T){
  stopifnot(is.reactive(df_table))

  if (remove_sub==T){
    df_table_new = reactive(remove_sub(df_table())) # function to remove the "_" in the column name
    moduleServer(id, function(input, output, session){

      reactable_df_table = reactive({reactable(df_table_new(),
                                               searchable = TRUE,
                                               showPageSizeOptions = TRUE,
                                               paginationType = "jump",
                                               pageSizeOptions = c(8, 12, 16),
                                               defaultPageSize = 8,
                                               columns = list(
                                                 gene_id = colDef(
                                                   sticky = "left",
                                                   # Add a right border style to visually distinguish the sticky column
                                                   style = list(borderRight = "1px solid #eee"),
                                                   headerStyle = list(borderRight = "1px solid #eee")
                                                 )
                                               ),#columns
                                               defaultColDef = colDef(minWidth = 150))}
      )#reactive
      output$df = renderReactable({reactable_df_table()})
    }#function
    )# moduleServer
  } else {
    moduleServer(id, function(input, output, session){
      reactable_df_table = reactive({reactable(df_table(),
                                               searchable = TRUE,
                                               showPageSizeOptions = TRUE,
                                               paginationType = "jump",
                                               pageSizeOptions = c(8, 12, 16),
                                               defaultPageSize = 8,
                                               columns = list(
                                                 gene_id = colDef(
                                                   sticky = "left",
                                                   # Add a right border style to visually distinguish the sticky column
                                                   style = list(borderRight = "1px solid #eee"),
                                                   headerStyle = list(borderRight = "1px solid #eee")
                                                 )
                                               ),#columns
                                               defaultColDef = colDef(minWidth = 150))}
      )#reactive
      output$df = renderReactable({reactable_df_table()})
    }#function
    )# moduleServer
  } #else
}

## To be copied in the UI
# mod_display_table_ui("display_table_1")

## To be copied in the server
# mod_display_table_server("display_table_1")
