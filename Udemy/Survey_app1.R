# Load packages
library(shiny)
library(shinysurveys)
library(googledrive)
library(googlesheets4)


# Get the ID of the sheet for writing programmatically
# This should be placed at the top of your shiny app
sheet_id <- drive_get("Demo_app")$id

# Define questions in the format of a shinysurvey
survey_questions <- data.frame(
  question = c("How many foreigners?",
               "Which country are they from?",
               "How many foreign children",
               "How many citizens?",
               "Which county are they from?",
               "Are there children? How many are they? "),
  option = NA,
  input_type = "text",
  input_id = c("No.of Foreigners", "Location(Foreign)","No.of children","No.of citizens","location(County)","Children(Within the county)"),
  dependence = NA,
  dependence_value = NA,
  required = c(TRUE, FALSE)
)

# Define shiny UI
ui <- fluidPage(
  surveyOutput(survey_questions,
               survey_title = "Hello, World!",
               survey_description = "A demo survey")
)

# Define shiny server
server <- function(input, output, session) {
  renderSurvey()
  
  observeEvent(input$submit, {
    response_data <- getSurveyData()
    
    # Read our sheet
    values <- read_sheet(ss = sheet_id, 
                         sheet = "main")
    
    # Check to see if our sheet has any existing data.
    # If not, let's write to it and set up column names. 
    # Otherwise, let's append to it.
    
    if (nrow(values) == 0) {
      sheet_write(data = response_data,
                  ss = sheet_id,
                  sheet = "main")
    } else {
      sheet_append(data = response_data,
                   ss = sheet_id,
                   sheet = "main")
    }
    
  })
  
}

# Run the shiny application
shinyApp(ui, server)