
# This is the user-interface definition of a Shiny web application.
# You can find out more about building applications with Shiny here:
# 
# http://www.rstudio.com/shiny/
#

library(shiny)

shinyUI(fluidPage(title="VR Gesture Survey",theme = "style.css",
  tags$head(tags$script(src="script.js")),
  tags$head(tags$script(src="js/unslider-min.js")),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/unslider.css")
  ),
  tags$head(
    tags$link(rel = "stylesheet", type = "text/css", href = "css/unslider-dots.css")
  ),
  titlePanel("VR Gesture Survey"),
  tabsetPanel(
    tabPanel("Database", 
             fluidRow( column(DT::dataTableOutput('tbl'), width = 12)),
              tags$div(id = "unslider")),
    
    tabPanel("Statistics", 
             fluidRow( column(width=5), column("Year distribution", width=2), column(width=5)),
             fluidRow( column(plotOutput("yearDistribution"), width=12)),
             fluidRow( column(width=5), column("Device distribution", width=2), column(width=5)),
            fluidRow( column(plotOutput("deviceDistribution"), width=12)),
            fluidRow( column(width=5), column("Body part distribution", width=2), column(width=5)),
            fluidRow( column(plotOutput("bodyPartDistribution"), width=12))),

    tabPanel("Slides at iGesto", 
             includeHTML("slidesigesto.html")),
    tabPanel("About", 
             includeHTML("about.html"))
  )

  
))
