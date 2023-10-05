## Downloading tables

server <- function(input,output, session) {
  
  
  library(ggplot2) # for the diamonds dataset, and ggplot feature
  library(DT) # for the dataTableOutput
  library(shiny) # should always be activated
  
  
  output$plot <- renderPlot({
    ggplot(diamonds, aes(price, carat)) + geom_point()
  })
  
  diam <- reactive({
    
    user_brush <- input$user_brush
    sel <- brushedPoints(diamonds, user_brush)
    return(sel)
    #Since user_brush is a function we use the type closure when calling it.
  })
  
  output$table <- DT::renderDataTable(DT::datatable(diam()))
  output$mydownload<-downloadHandler(
    filename = "plotextract.csv",
    content = function(file){
      write.csv(diam(),file)
    }
  )
}

ui <-   fluidPage(
  h1("Exporting Data as csv"),
  plotOutput("plot", brush = "user_brush"),
  dataTableOutput("table"),
  downloadButton("mydownload")
)

shinyApp(ui = ui, server = server)

