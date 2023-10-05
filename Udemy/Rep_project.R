server<-function(input,output,session){
  library(shiny)
  library(DT)
  library(ggplot2)
  library(shinythemes)
  library(tidyverse)
  #Plots
    attach(course_proj_data)
  output$plot<-renderPlot({
    point=(G1*input$w1)+(G2*input$w2)+(G3*input$w3)
    ggplot(course_proj_data,aes(point,`MarketCap in M`),group)+geom_point()+geom_smooth(method = "lm")
  })
   #Reactive plot
  diam<-reactive({
    course_proj_data$point=(G1*input$w1)+(G2*input$w2)+(G3*input$w3)
    user_brush<-input$user_brush
    sel<-brushedPoints(course_proj_data,user_brush)
    return(sel)
    })
  #Table
  output$tablex<-DT::renderDataTable(DT::datatable(diam()))
 #Panel 3
  output$tableDT=DT::renderDataTable(datatable(course_proj_data)%>%  formatCurrency("MarketCap_in_M","$")
  %>% formatStyle("MarketCap_in_M",color = "green") %>% formatStyle(c("G1","G2","G3"),backgroundColor= "lightblue") %>% formatStyle("Symbol",color = "grey"))
    #Download data as csv
  output$mydownload<-downloadHandler(
    filename = "mining.csv",
    content = function(file){
      write.csv(diam(),file)
    }
  )
  
}
ui<-navbarPage(title = h3("The mining stock scale"),theme=shinythemes::shinytheme("sandstone"),
             
             tabPanel(toupper("adjust your mining stock"),
                     wellPanel(
                       sliderInput("w1",h4(tags$b("Weight on grade 1")),
                                  min = 0,max = 20,value = 5,width =  '2000px'),
                      sliderInput("w2",h4(tags$b("Weight on grade 2")),
                                  min = 0,max = 20,value = 8,width =  '2000px'),
                      sliderInput("w3",h4(tags$b("Weight on grade 3")),
                                  min = 0,max = 6,value = 0.6,step = 0.2,width =  '2000px'),
                      plotOutput("plot",brush = "user_brush"),
                      DT::dataTableOutput("tablex"),
                      downloadButton("mydownload")
                      )),
             
             tabPanel(toupper("Documentation"),titlePanel("Codes to this work"),
                      tags$p("Coming soon...."),tags$code()),
                      
             
             tabPanel(toupper("Data Table with underlying data"),
                      DT::dataTableOutput("tableDT")
                      )
                      
  )
shinyApp(ui=ui,server =server )
#Plot 
#-What are the X and Y values
#-x value is the ((G1*W1)+(G2*W2)+(G3*W3))=Plot and the y value is the market cap
#-The regression line
#Reactive to select the table


#?wellPanel()
