#' download UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd
#'
#' @importFrom shiny NS tagList
mod_download_ui <- function(id, download_item = "sample"){
  ns <- NS(id)
  downloadButton(ns("download"), paste0("Export ", download_item, " to .tsv"), class = "down")
}

#' download Server Functions
#'
#' @noRd
mod_download_server <- function(id, df_table, pre_name, metal=metal, month=time, download_item="sample"){
  stopifnot(is.reactive(df_table))
  stopifnot(is.reactive(pre_name))
  stopifnot(is.reactive(metal))
  stopifnot(is.reactive(month))

  moduleServer(id, function(input, output, session){
    output$download = downloadHandler(
      filename = function(pre=paste0(pre_name(), "_", download_item, "_")){
        if( is.null(metal())&is.null(month()) ) {
          print(paste0(pre, Sys.Date(),  "_metal_ALL_month_ALL.tsv"))
        } else if ( is.null(metal())&(!is.null(month())) ){
          print(paste0(pre, Sys.Date(),
                       "_metal_ALL_month_",
                       paste(month(), collapse="_"), ".tsv"))
        } else if ( (!is.null(metal()))&is.null(month()) ){
          print(paste0(pre, Sys.Date(),
                       "_metal_", paste(metal(), collapse="_"), "_month_ALL.tsv"))
        } else {
          print(paste0(pre, Sys.Date(),
                       "_metal_", paste(metal(), collapse="_"), "_month_",
                       paste(month(), collapse="_"), ".tsv"))
        }
      },
      content = function(file) {
        vroom::vroom_write(df_table(), file)
      }
    )
  })# moduleServer
}

## To be copied in the UI
# mod_download_ui("download_1")

## To be copied in the server
# mod_download_server("download_1")
