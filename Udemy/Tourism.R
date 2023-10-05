library(ggplot2)
library(tidyverse)
library(shiny)

ui<-fluidPage(
  plotOutput("plot",brush = "user_brush"),
 # dataTableOutput("table")
)
server<-function(input,output,session){
  library(forecast)
  
  output$plot <- renderPlot({
    attach(Thompson_2021)
    Thompson_2021 %>% select(MALE.ADULTS,FEMALE.ADULTS) %>% as.ts(frequency=1,start=c(1,2021))%>% autoplot()
    
    
    #ggplot(plotextract , aes(price, carat)) + geom_point()
  })
   
  
}
shinyApp(ui=ui,server = server)