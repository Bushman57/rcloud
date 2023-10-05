## Advanced App - brush and click

server <- function(input,output, session) {
  
  
  library(ggplot2) # for the diamonds dataset, and ggplot feature
  library(DT) # for the dataTableOutput
  library(shiny) # should always be activated
  
  
  output$plot <- renderPlot({
    ggplot(plotextract , aes(price, carat)) + geom_point()
  })
  
  diam <- reactive({
    
    user_brush <- input$user_brush
    sel <- brushedPoints(diamonds, user_brush)
    return(sel)
    #Since user_brush is a function we use the type closure when calling it.
  })
  
  output$table <- DT::renderDataTable(DT::datatable(diam()))
}

ui <-   fluidPage(
  h1("Using the brush feature to select specific observations"),
  plotOutput("plot", brush = "user_brush"),
  dataTableOutput("table")
)

shinyApp(ui = ui, server = server)

## Advanced App - click

server <- function(input,output, session) {
  
  library(ggplot2) # for the diamonds dataset, and ggplot feature
  library(DT) # for the dataTableOutput
  
  output$plot <- renderPlot({
    ggplot(diamonds, aes(price, carat)) + geom_point()
  })
  
  diam <- reactive({
    
    user_click <- input$user_click
    sel <- nearPoints(diamonds, user_click, threshold = 10, maxpoints = 5)
    # maxpoints gives the maximum number of observations in the table
    # threshold gives the maximum distance in the dataset
    return(sel)
    
  })
  
  output$table <- DT::renderDataTable(DT::datatable(diam()))
}

ui <-   fluidPage(
  h1("Using the click feature to select specific observations"),
  plotOutput("plot", click = "user_click"),
  dataTableOutput("table")
)

shinyApp(ui = ui, server = server)


