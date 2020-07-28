#' The application User-Interface
#' 
#' @param request Internal parameter for `{shiny}`. 
#'     DO NOT REMOVE.
#' @import shiny
#' @noRd
app_ui <- function(request) {
  tagList(
    # Leave this function for adding external resources
    golem_add_external_resources(),
    # List the first level UI elements here 
    
    tagList(
      nav_(
        "NavBar Title",
        c(
          "tab1" = "tab-1",
          "geom_point" = "geom_point",
          "geom_hist" = "geom_hist",
          "geom_boxplot" = "geom_boxplot",
          "geom_bar" = "geom_bar",
          "tab6" = "tab-6"
        )
      ),
      tags$div(
        class="container", 
        fluidRow(
          id = "tab1",  mod_tab1_ui("tab1_ui_1")
        ) %>% tagAppendAttributes(
          style = "display:none"
        ))),
    
    
    
    fluidPage(
      h1("GolemPractice"),
   
    )
  )
}

#' Add external Resources to the Application
#' 
#' This function is internally used to add external 
#' resources inside the Shiny application. 
#' 
#' @import shiny
#' @importFrom golem add_resource_path activate_js favicon bundle_resources
#' @noRd
golem_add_external_resources <- function(){
  
  add_resource_path(
    'www', app_sys('app/www')
  )
 
  tags$head(
    favicon(),
    bundle_resources(
      path = app_sys('app/www'),
      app_title = 'GolemPractice'
    )
    # Add here other external resources
    # for example, you can add shinyalert::useShinyalert() 
  )
}

