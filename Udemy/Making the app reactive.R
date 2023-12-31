##Making the app reactive using observed function
library(shiny)
server<-function(input,output,session){
  observe({
    addtext<-paste("Your initial input:",input$mystring)
    updateTextInput(session,"mystring2",value = addtext)
  })
}

ui <-   basicPage(
  h1("Using Observe"),
  textInput("mystring", "Write here"),
  textInput("mystring2", "Full App Output")
)

shinyApp(ui = ui, server = server)