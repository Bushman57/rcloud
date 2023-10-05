## Changing themes
server<-function(input,output,session){}
library(shinythemes)
ui<-fluidPage(themeSelector(),# displaying different themes, replace this line with theme = shinytheme("darkly")
  titlePanel(strong("This is the STRONG tag in the title")),
  sidebarLayout(
    sidebarPanel(
      withTags(
        div(
          b("Bold text: here you see a line break, a horizontal line and some codes"),
          br(),
          hr(),
          code("plot(lynx)")
        )
      )
    ),
    mainPanel(
      tabsetPanel(
        tabPanel("Weblink with direct tag a", a(href="www.r-tutorials.com","r-tutorials")),
        tabPanel(tags$b("Using b for bold text"),tags$b("a bold text")),
        tabPanel("Citations with the blockquote tag",tags$blockquote("R is Great",cite="R programmer"))
      )
    )
  )
)  
shinyApp(ui = ui, server = server)  