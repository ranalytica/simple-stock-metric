#' tab6 UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
library(shiny)
mod_tab6_ui <- function(id){
  ns <- NS(id)
  tagList(
    h2("you can do whatever you want"),
    col_6(
      includeMarkdown(
        system.file("app/www/tab-6a.md", package = "GolemPractice")
      )
    ),
    col_6(
      includeMarkdown(
        system.file("app/www/tab-6b.m", package = "GolemPractice")
      )
    )
 
  )
}
    
#' tab6 Server Function
#'
#' @noRd 
mod_tab6_server <- function(input, output, session){
  ns <- session$ns
 
}
    
## To be copied in the UI
# mod_tab6_ui("tab6_ui_1")
    
## To be copied in the server
# callModule(mod_tab6_server, "tab6_ui_1")
 
