
# This is the server logic for a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)
library(htmlwidgets)

library(DT)

source("plots.R")
#options(shiny.trace = TRUE)

shinyServer(function(input, output) {
  
  
  output$yearDistribution <- renderPlot({
    
    plotYearDistribution();
    
  })
 
  output$bodyPartDistribution <- renderPlot({
    bodyPartDistribution()
  })
  
  
  output$deviceDistribution <- renderPlot({
    deviceDistribution()
    
  })
  
  output$tbl = DT::renderDataTable(server = FALSE,
        X, filter="top",
        
        options = list(lengthChange = FALSE, 
                       pageLength = 20,
                       autoWidth=TRUE,
                       columnDefs = list( #list(visible=FALSE, targets=8), 
                                         list(width="10%", targets="_all"),
                                         list(width="10px", targets=c(8,9)),
                                         list(targets = 8,
                                           render = JS(
                                             "function(data, type, row, meta) {",
                                               "return createThumbs(data, type, row, meta);",
                                             "}")),
                                         list(targets = c(1, 2, 3, 5, 6, 7),
                                            render = JS(
                                              "function(data, type, row, meta) {",
                                              "return '<div>'+data+'</div>'",
                                              "}"
                                              )
                                          )
                                    ),
                       initComplete = JS("initComplete")
        ),
                      
        escape=FALSE,
        selection="single"
  )
  
})
