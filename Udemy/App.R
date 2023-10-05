
library(dipsaus) #stylizing excel styles
library(forecast)#Time series analysis
library(DT)
#library(tidyverse)
library(googlesheets4)
library(googledrive)
library(data.table)
gs4_auth(cache = ".secrets",email = "savinskamau01@gmail.com")

#Import data sheet
sheet_id<-"https://docs.google.com/spreadsheets/d/1I-6pHIgKXz49Ck2Zo7ar4W9IJ08SUxGzSenNtnBkUsI/edit?usp=sharing"
new_id<-"https://docs.google.com/spreadsheets/d/1Uv3cTZ3ush0yedtrJ1iicks2oZ2iTuiac8sS5FooKbQ/edit?usp=sharing"

ui<-navbarPage(title = "Hotel App",theme=shinythemes::shinytheme("united"),
               tabPanel("Calculator ",
                        h2(tags$b("Foods")),
                        inputPanel(h3(tags$b("SNACKS")),
                                   # p(),
                                   numericInput("Chapo",label = "chapo",value = 0,min = 0),
                                   numericInput("Ndazi",label = "Ndazi",value = 0,min = 0),
                                   numericInput("Tm",label = "Tm",value = 0,min = 0),
                                   numericInput("cake",label = "cake",value = 0,min = 0),
                                   numericInput("Hcake",label = "1/2cake",value = 0,min = 0),
                                   numericInput("egg",label = "Eggs",value = 0,min = 0),
                                   numericInput("om",label = "Omelet",value = 0,min = 0),#add
                                   numericInput("sss",label = "Sausage/Samosa/Smokie",value = 0,min = 0)#add
                                   
                        ),
                        p(),
                        
                        inputPanel(h3(tags$b("MEALS")),
                                   numericInput("ChapoP",label = "Chapo Mix",value = 0,min = 0),
                                   numericInput("wali",label = "Wali Mix",value = 0,min = 0),
                                   numericInput("ugali",label = "Ugali Mix",value = 0,min = 0),
                                   numericInput("Pilau",label = "Pilau Mix",value = 0,min = 0),
                                   numericInput("beefC",label = "Beef chapo",value = 0,min = 0),
                                   numericInput("beefU",label = "Beef Ugali",value = 0,min = 0),
                                   numericInput("beefR",label = "Beef Rice",value = 0,min = 0),
                                   numericInput("beefP",label = "Beef Pilau",value = 0,min = 0),
                                   numericInput("KukuC",label = "Kuku Chapo",value = 0,min = 0),
                                   numericInput("KukuU",label = "Kuku Ugali",value = 0,min = 0),
                                   numericInput("KukuR",label = "Kuku Rice",value = 0,min = 0),
                                   numericInput("KukuP",label = "Kuku Pilau",value = 0,min = 0),
                                   numericInput("ugaliMa",label = "Ugali Matumbo",value = 0,min = 0),
                                   numericInput("riceMa",label = "Rice Matumbo",value = 0,min = 0),
                                   numericInput("ChapoMa",label = "Chapo Matumbo",value = 0,min = 0),
                                   numericInput("PilauMa",label = "Pilau Matumbo",value = 0,min = 0),
                                   numericInput("ugaliMu",label = "Ugali Managu",value = 0,min = 0),
                                   numericInput("riceMu",label = "Rice Managu",value = 0,min = 0),
                                   numericInput("chapoMu",label = "Chapo Managu",value = 0,min = 0),
                                   numericInput("PilauMu",label = "Pilau  Managu/Minji",value = 0,min = 0),
                                   numericInput("ugaliFMu",label = "Ugali Fry  Managu",value = 0,min = 0),
                                   numericInput("riceFMu",label = "Rice Fry  Managu",value = 0,min = 0),
                                   numericInput("chapoFMu",label = "Chapo Fry  Managu",value = 0,min = 0),
                                   numericInput("PilauFMu",label = "Pilau Fry  Managu",value = 0,min = 0),
                                   numericInput("ugaliMMu",label = "Ugali Matumbo  Managu",value = 0,min = 0),
                                   numericInput("riceMMu",label = "Rice Matumbo  Managu",value = 0,min = 0),
                                   numericInput("chapoMMu",label = "Chapo Matumbo  Managu",value = 0,min = 0),
                                   numericInput("PilauMMu",label = "Pilau Matumbo  Managu",value = 0,min = 0),
                                   numericInput("ugaliMb",label = "Ugali Mboga",value = 0,min = 0),
                                   numericInput("riceMb",label = "Rice Mboga",value = 0,min = 0),
                                   numericInput("chapoMb",label = "Chapo Mboga",value = 0,min = 0),
                                   numericInput("UgaliP",label = "Ugali Plain",value = 0,min = 0),
                                   numericInput("McheleP",label = "Mchele Plain",value = 0,min = 0),
                                   numericInput("PilauP",label = "Pilau Plain",value = 0,min = 0),
                                   numericInput("Service",label = "Service Nyama",value = 0,min = 0)
                                   
                        ),
                        h2(tags$b("Beverage")),
                        inputPanel(
                          numericInput("Tea",label = "Tea",value = 0,min = 0),
                          numericInput("Bc",label = "Black Coffee",value = 0,min = 0),
                          numericInput("Wc",label = "White Coffee",value = 0,min = 0),
                          numericInput("Lemon",label = "Lemon Tea",value = 0,min = 0),
                          numericInput("conc",label = "Concusion",value = 0,min = 0),#Add
                          numericInput("Predator",label = "Predator",value = 0,min = 0),
                          numericInput("Soda",label = "Soda",value = 0,min = 0),
                          numericInput("plastic",label = "Plastic Soda",value = 0,min = 0),
                          numericInput("Dasani",label = "Dasani 1/2ltr",value = 0,min = 0),
                          numericInput("Dasani1",label = "Dasani 1ltr",value = 0,min = 0),
                          numericInput("Water",label = "Water 1/2ltr",value = 0,min = 0),
                          numericInput("Water1",label = "Water 1ltr",value = 0,min = 0),
                          numericInput("Mmaid",label = "Minute maid",value = 0,min = 0)
                        ),
                        actionButtonStyled("enterbutton","Enter",
                                           btn_type = "button", type = "info"),
                        actionButtonStyled("Newbutton","New",
                                           btn_type = "button", type = "primary"),
                        textOutput("thankyoutext"),
                        textOutput("new")
               ),
               
               tabPanel("Stock Book",
                        wellPanel(
                          selectizeInput("Item",label ="Food",choices=list("Milk","Soda","Plastic Soda","Ndazi",
                                                                           "Tm","Water","Dasani","CookingOil")),#Use the names function with the data to be used
                          numericInput("Opening",label = "Opening stock",value = 0,min = 0),
                          numericInput("Added",label = "Added stock",value = 0,min = 0),
                          numericInput("Closing",label = "Closing stock",value = 0,min = 0),
                          actionButtonStyled("submitbutton","Submit",
                                             btn_type = "button", type = "primary"),
                          textOutput("done")
                        ))
               
)

server<-function(input,output,session){
  Enter_button<-eventReactive(input$enterbutton,{
    #Collect data
    Hotel_data<-data.table(
      chapo<-input$Chapo,#Snacks
      Ndazi<-input$Ndazi,
      Tm<-input$Tm,
      cake<-input$cake,
      Hcake<-input$Hcake,
      Egg<-input$egg,
      Om<-input$om,
      sss<-input$sss,
      ChMix<-input$ChapoP,#Mix
      Walimix<-input$wali,
      Ugalimix<-input$ugali,
      PilauMix<-input$Pilau,
      BeefChapo<-input$beefC,#Beef
      BeefUgali<-input$beefU,
      BeefRice<-input$beefR,
      BeefPilau<-input$beefP,
      KukuChapo<-input$KukuC,#Kuku
      KukuUgali<-input$KukuU,
      KukuRice<-input$KukuR,
      KukuPilau<-input$KukuP,
      MatumboU<-input$ugaliMa,#Matumbo
      MatumboR<-input$riceMa,
      MatumboC<-input$ChapoMa,
      MatumboP<-input$PilauMa,
      ManaguU<-input$ugaliMu,#Managu
      ManaguR<-input$riceMu,
      ManaguC<-input$chapoMu,
      ManaguP<-input$PilauMu,
      FryManaguU<-input$ugaliFMu,#Fry Managu
      FryManaguR<-input$riceFMu,
      FryManaguC<-input$chapoFMu,
      FryManaguP<-input$PilauFMu,
      MatumboManaguU<-input$ugaliMMu,#Matumbo Managu
      MatumboManaguR<-input$riceMMu,
      MatumboManaguC<-input$chapoMMu,
      MatumboManaguP<-input$PilauMMu,
      MbogaU<-input$ugaliMb,#Mboga
      MbogaR<-input$riceMb,
      MbogaC<-input$chapoMb,
      PlainU<-input$UgaliP,#Plain
      PlainR<-input$McheleP,
      PlainP<-input$PilauP,
      PlainS<-input$Service,#Service
      Tea<-input$Tea,#Beverages
      TeaB<-input$Bc,
      TeaW<-input$Wc,
      TeaL<-input$Lemon,
      Conc<-input$conc,
      SodaP<-input$Predator,
      Soda<-input$Soda,
      PlasticSoda<-input$plastic,#
      Dasani<-input$Dasani,
      Dasani_1ltr<-input$Dasani1,
      Water_.5ltr<-input$Water,
      Water_1ltr<-input$Water1,
      MinuteMaid<-input$Mmaid,
      
      #Prices
      amount<-sum(
        chapo*30,#Snacks
        Ndazi*20,
        Tm*30,
        cake*30,
        Hcake*30,
        Egg*40,
        Om*50,
        sss*50,
        ChMix*90,#Mix
        Walimix*150,
        Ugalimix*150,
        PilauMix*180,
        BeefChapo*190,#Beef
        BeefUgali*250,
        BeefRice*250,
        BeefPilau*300,
        KukuChapo*290,#Kuku
        KukuUgali*350,
        KukuRice*350,
        KukuPilau*350,
        MatumboU*180,#Matumbo
        MatumboR*200,
        MatumboC*140,
        MatumboP*250,
        ManaguU*150,#Managu
        ManaguR*150,
        ManaguC*90,
        ManaguP*200,
        FryManaguU*300,#Fry Managu
        FryManaguR*300,
        FryManaguC*240,
        FryManaguP*350,
        MatumboManaguU*200,#Matumbo Managu
        MatumboManaguR*200,
        MatumboManaguC*140,
        MatumboManaguP*250,
        MbogaU*80, #Mboga
        MbogaR*80,
        MbogaC*90,
        PlainU*50, #Plain
        PlainR*100,
        PlainP*130,
        PlainS*75,
        Tea*30,
        TeaB*30,
        TeaW*50,
        TeaL*40,
        Conc*50,
        SodaP*70,
        Soda*50,
        PlasticSoda*50,
        Dasani*50,
        Dasani_1ltr*100,
        Water_.5ltr*40,
        Water_1ltr*70,
        MinuteMaid*80
      ),
      Date<-Sys.Date()
    ) 
    #Put the data on the drive
    googlesheets4::sheet_append(ss=sheet_id,
                                data = Hotel_data,
                                sheet = "October")
    
    #h5(tags$b("Thank you for entering the data"))
    updateActionButtonStyled(session,"enterbutton",label = "Enter",type = "success")
    paste0("Total amount is: ",amount)
  })
  output$thankyoutext <- renderText({
    Enter_button()
  })
  #Update the values
  New_button<-eventReactive(input$Newbutton,{
    updateNumericInput(session,"Chapo",value=0)
    updateNumericInput(session,"Ndazi",value=0)
    updateNumericInput(session,"Tm",value=0)
    updateNumericInput(session,"cake",value=0)
    updateNumericInput(session,"Hcake",value=0)
    updateNumericInput(session,"egg",value=0)
    updateNumericInput(session,"om",value=0)
    updateNumericInput(session,"sss",value=0)
    updateNumericInput(session,"ChapoP",value=0)
    updateNumericInput(session,"wali",value=0)
    updateNumericInput(session,"ugali",value=0)
    updateNumericInput(session,"Pilau",value=0)
    updateNumericInput(session,"beefC",value=0)
    updateNumericInput(session,"beefU",value=0)
    updateNumericInput(session,"beefR",value=0)
    updateNumericInput(session,"beefP",value=0)
    updateNumericInput(session,"KukuC",value=0)
    updateNumericInput(session,"KukuU",value=0)
    updateNumericInput(session,"KukuR",value=0)
    updateNumericInput(session,"KukuP",value=0)
    updateNumericInput(session,"ugaliMa",value=0)
    updateNumericInput(session,"riceMa",value=0)
    updateNumericInput(session,"ChapoMa",value=0)
    updateNumericInput(session,"PilauMa",value=0)
    updateNumericInput(session,"ugaliMu",value=0)
    updateNumericInput(session,"riceMu",value=0)
    updateNumericInput(session,"chapoMu",value=0)
    updateNumericInput(session,"PilauMu",value=0)
    updateNumericInput(session,"ugaliFMu",value=0)
    updateNumericInput(session,"riceFMu",value=0)
    updateNumericInput(session,"chapoFMu",value=0)
    updateNumericInput(session,"PilauFMu",value=0)
    updateNumericInput(session,"ugaliMMu",value=0)
    updateNumericInput(session,"riceMMu",value=0)
    updateNumericInput(session,"chapoMMu",value=0)
    updateNumericInput(session,"PilauMMu",value=0)
    updateNumericInput(session,"ugaliMb",value=0)
    updateNumericInput(session,"riceMb",value=0)
    updateNumericInput(session,"chapoMb",value=0)#
    updateNumericInput(session,"UgaliP",value=0)
    updateNumericInput(session,"McheleP",value=0)
    updateNumericInput(session,"PilauP",value=0)
    updateNumericInput(session,"Service",value=0)
    updateNumericInput(session,"Tea",value=0)
    updateNumericInput(session,"Bc",value=0)
    updateNumericInput(session,"Wc",value=0)
    updateNumericInput(session,"Lemon",value=0)
    updateNumericInput(session,"conc",value=0)
    updateNumericInput(session,"Predator",value=0)
    updateNumericInput(session,"Soda",value=0)
    updateNumericInput(session,"plastic",value=0)
    updateNumericInput(session,"Dasani",value=0)
    updateNumericInput(session,"Dasani1",value=0)
    updateNumericInput(session,"Water",value=0)
    updateNumericInput(session,"Water1",value=0)
    updateNumericInput(session,"Mmaid",value=0)
    updateActionButtonStyled(session,"enterbutton",label = "Enter",type = "info")
    
    paste0("Enter newdata 😎")
  })
  output$new<-renderText({
    New_button()
  })
  
  Stock<-eventReactive(input$submitbutton,{
    stock_data<-data.table(
      Date<-Sys.Date(),
      Opening<-input$Opening,
      Added<-input$Added,
      Total<-sum(Added,Opening),
      Closing<-input$Closing,
      Used<-Total-Closing
    )
    #Put the data on the drive
    googlesheets4::sheet_append(ss=new_id,
                                data = stock_data,
                                sheet =input$Item)
    paste0("Data recorded")
    
  })
  output$done<-renderText({
    Stock()
  })
}
shinyApp(ui=ui,server = server)
