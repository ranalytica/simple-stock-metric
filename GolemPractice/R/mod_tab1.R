#' tab1 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
mod_tab1_ui <- function(id){
  ns <- NS(id)
  tagList(
    includeMarkdown(
      system.file("app/www/tab-1.md", package = "GolemPractice")
    )
 
  )
}
    
#' tab1 Server Function
#'
#' @noRd 
mod_tab1_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_tab1_ui("tab1_ui_1")
    
## To be copied in the server
# callModule(mod_tab1_server, "tab1_ui_1")
 
