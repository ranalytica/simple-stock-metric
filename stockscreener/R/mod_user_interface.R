#' user_interface UI Function
#'
#' @description A shiny Module.
#'
#' @param id,input,output,session Internal parameters for {shiny}.
#'
#' @noRd 
#'
#' @importFrom shiny NS tagList 
#' 

library(shiny)
library(plotly)
library(tidyquant)
library(ggplot2)
library(dplyr)
library(shinydashboard)
library(dygraphs)
library(timetk)
library(glue)



mod_user_interface_ui <- function(id){
  ns <- NS(id)
  tagList(
    dashboardPage(
      dashboardHeader(title = "Stock Analysis"),
      dashboardSidebar(
        textInput(ns("ticker1"), "Stock Symbol", "NIO"),
        actionButton("static", "v.s."),
        textInput(ns("ticker2"),label=NULL,value= "SPY"),
        br(),
        dateRangeInput(ns("dates"),
                       "Date range",
                       start = "2020-01-01",
                       end = as.character(Sys.Date()))),
      
      dashboardBody(
        
      box(title = " Price History", 
          dygraphOutput(ns("HistPrice"), height = 250)),
      box(title = "Stock Comparison", 
          dygraphOutput(ns("Compare"), height = 250)),
      box(title = "Price Distribution", 
          plotlyOutput(ns("Distribution"), height = 250)),
      box(title = "Beta", 
          plotlyOutput(ns("Beta"), height = 250)),
    
     
        
      )
    )
  )
    
}
    
#' user_interface Server Function
#'
#' @noRd 
mod_user_interface_server <- function(input, output, session){
  ns <- session$ns
 
  
  dataInput <- reactive({
    tq_get(toupper(c(input$ticker1, input$ticker2)), get="tiingo",
           from = input$dates[1],
           to = input$dates[2])
  })
  
# -- data manipulation
  
  dataInput2 <- reactive({
  
  dataInput() %>% filter(symbol==toupper(input$ticker1)) %>% 
      select(symbol, date, close, volume ) %>% rename(tick1 = close)
      
})
  
  datatick1 <- reactive({
      
    dataInput2() %>% mutate(
      shares1 = 1000/dataInput2()[[1,3]], 
      investment1 = shares1*tick1, ratio1 = round((investment1/1000)-1,digits=3))
  })
  
  
  dataInput3 <- reactive({
  
    dataInput() %>% filter(symbol==toupper(input$ticker2)) %>% 
      select(symbol, date, close,volume )%>% rename(tick2 = close) 
})
  
  datatick2 <- reactive({ 
    dataInput3() %>% 
      mutate(shares2 = 1000/dataInput3()[[1,3]], 
             investment2 = shares2*tick2, ratio2 = round((investment2/1000)-1,digits=3))
    })
  
  dataInput4 <- reactive({

   left_join(datatick1(),datatick2(), by="date") 
})
  
 
# --- Price plot
  
output$HistPrice <- renderDygraph({
  dataInput() %>% filter(symbol==toupper(input$ticker1)) %>% 
    dplyr::select(symbol, date, close) %>% 
    tidyr::spread(key = symbol, value = close) %>% 
    timetk::tk_xts() %>% 
    dygraph() %>% 
    dyRangeSelector()
})
# --- Compare plot    
  output$Compare <- renderDygraph({

    dataInput() %>% 
      dplyr::select(symbol, date, close) %>% 
      tidyr::spread(key = symbol, value = close) %>% 
      timetk::tk_xts() %>% 
      dygraph() %>%
      dyRebase(value = 1) %>% 
      dyRangeSelector()
    
  })
 


# --- Distribution plot
  
  output$Distribution <- renderPlotly({ 
    
    fd=function(x) {
      n=length(x)
      r=IQR(x)
      2*r/n^(1/3)
    }
    
    p2 <- ggplot(dataInput4(), 
            aes(x=tick1)) +
          
          geom_histogram(aes
                    (y=..density..),     
                     binwidth=fd,
                     colour="black", fill="grey") +
          geom_density(alpha=.2, fill="#FF6666")+
          labs(x=input$ticker1, 
                     y="Frequency",
                     title = glue::glue(
                       toupper(input$ticker1), " Price History"))
    
    ggplotly(p2)
  })
# --- Beta plot
  output$Beta <- renderPlotly({

    fit <- lm(ratio1~ratio2, data = dataInput4())
        
 p4 <-  dataInput4() %>% plot_ly(
    x=~ratio2,
    y=~ratio1,
    text =~date,
    type = 'scatter',
    hovertemplate = paste('Date:%{text}','<br>ticker1: %{y}',
                          '<br>ticker2: %{x}<br>')
  )
    
  p4 %>% add_lines(x=~ratio2, y=~fitted(fit)) %>%  
          layout(showlegend=F,xaxis = list(title = glue::glue("{input$ticker2}")), 
                 yaxis = list(title = glue::glue("{input$ticker1}")))
  })
# ---
  
# ---
  
  
  
  
  
}
    
## To be copied in the UI
# mod_user_interface_ui("user_interface_ui_1")
    
## To be copied in the server
# callModule(mod_user_interface_server, "user_interface_ui_1")
 
