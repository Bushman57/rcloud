library(dipsaus) #stylizing excel styles
library(shiny)

ui<-fluidPage()
server<-function(){
  
}
library(shiny)

ui <- fluidPage(
  selectizeInput()
)

server <- function(input, output, session) {
  
}

shinyApp(ui=ui, server=server)