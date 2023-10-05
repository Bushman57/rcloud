#Load packages
library(shiny)
library(googlesheets4)
library(googledrive)
library(data.table)
library(dipsaus) #stylizing excel styles
library(datamods)#Import google sheets

gs4_auth(cache = ".secrets",email = "savinskamau01@gmail.com")

# This should be placed at the top of your shiny app
sheet_id <- "https://docs.google.com/spreadsheets/d/1AtKFy6K3RzRrmKikNk40mhmOqyho8urR6YbB0B_iGkQ/edit?usp=sharing"
#options(shiny.autoreload=TRUE)
#Server
server<-function(input,output,session){
  to_be_done_at_submit<-eventReactive(input$submitbutton,{
    #Collect data
    dtData<-data.table(
      Nationality<-input$nation,
      location<-input$loc,
      No.male<-input$male,
      No.female<-input$female,
      No.children<-input$children,
      No.Visitors<-No.male+No.female+No.children,
      Amount<-if(Nationality=="Citizen"){No.male*70+No.female*70+No.children*30}else{No.male*300+No.female*300+No.children*200},
      DATE<-Sys.Date()
    )
    #Put data on drive
    googlesheets4::sheet_append(ss = sheet_id, 
                 data = dtData,
                 sheet = "Sheet1")
    #read_sheet(sheet_id)
    #Say thank you
    h5(tags$b("Thank you for entering data."))
  })
  
  output$thankyoutext <- renderUI({
    to_be_done_at_submit()
  })
  #Update the values
observeEvent(input$submitbutton,{
    updateNumericInput(session,"male",value=0)
    updateNumericInput(session,"female",value=0)
    updateNumericInput(session,"children",value=0)
    updateTextInput(session,"loc",value = "")
    insertUI("#submitbutton", "afterEnd",
    updateActionButtonStyled(session,"submitbutton",label = "New",type = "success")
      
    )
    })
  
  observeEvent(input$ViewData,{
    output$googlesheet<-renderUI({ tags$iframe(id = "googlesheet",
                src = sheet_id,
                width = 1200,
                height = 768,
                frameborder = 0,
                marginheight = 0)
  
  })
    })
  #Import data
  imported <- import_googlesheets_server("myid")
  datax<-imported$data
 
    res_filter <- filter_data_server(
      id = "filtering",
      data = reactive(mtcars),
      name = reactive("Tours_data"),
      vars = reactive(names(mtcars)),
      widget_num = "slider",
      widget_date = "slider",
      label_na = "Missing"
     
    )
}

#Ui
ui<-navbarPage(theme=shinythemes::shinytheme("readable"),
  #theme=shinythemes::shinytheme("united"),
  #theme=shinythemes::shinytheme("slate"),
  
  #Application tittle
  h3("Tourist Data App "),
  
  #tab panel with a Text input,Numeric input,Select box
  
  tabPanel("App",
           wellPanel (selectInput("nation", label = h3("Nationality"), 
                                  choices = list("Citizen" = "Citizen", "Foreigner" = 'Foreigner')),
                      #selectizeInput('loc', choices = NULL,label = h3("Location")),
                      textInput("loc", label = h3("Location")),
                      numericInput("male", label = h3("No.of males"),value = 0,min = 0),
                      numericInput("female", label = h3("No.of females"),value = 0,min = 0),
                      numericInput("children", label = h3("No.of children"),value = 0,min = 0),
                      actionButtonStyled("submitbutton","Submit",
                                         btn_type = "button", type = "primary"),
                      ),
                      uiOutput("thankyoutext")
           

  ),
  tabPanel("Background Infromation",
           wellPanel(
                     tags$img(src ="pic.png",height="850px", width="460px", align="left"),
           ),
           mainPanel(
             
             #Cutomised button
             actionButtonStyled("ViewData", "View", icon = NULL, width = NULL, 
                                btn_type = "button", type = "primary"),
             htmlOutput("googlesheet")
          )),
  tabPanel("Analysis",
           h3(tags$b("Use the link below to analyse your data")),
           import_googlesheets_ui("myid"),
           filter_data_ui("filtering", max_height = "500px")
           
           ),
  tabPanel("New",
           
           panama<-read_sheet(sheet_id)
           )
)

shinyApp(ui=ui,server = server)