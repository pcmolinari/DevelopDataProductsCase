#ui.R

card_holder = c("aa", "bb", "cc") 
type = c("entertainment", "travel", "stationary","entertainment", "travel", "stationary","entertainment", "travel", "stationary") 
amount = c(2, 3, 5, 12, 31, 52, 95, 96, 100) 
country = c("NL", "US", "NG","NL", "US", "NG","NL", "US", "NG")
date_charged = c("01/01/15", "01/01/15", "02/02/15","02/02/15", "01/03/15", "01/04/15","15/05/15", "01/06/15", "31/07/15")
tax = c(0.02, 0.13, 0.25, 0.09, 0.01, 0.34, 0.81, 0.73, 0.54) 
df = data.frame(card_holder, type, amount, country, date_charged, tax)
df2 = data.frame(amount, tax)
coldisplay = data.frame(card_holder, type, country, date_charged)
df3<-aggregate(amount ~ type, data=df, FUN="sum")
df4<-aggregate(amount ~ card_holder, data=df, FUN="sum")
df5<-aggregate(amount ~ country, data=df, FUN="sum")
df6<-aggregate(amount ~ date_charged, data=df, FUN="sum")



library(shiny)
ui <- fluidPage(

titlePanel("Credit Card expense Analysis"),


  sidebarLayout(
    


    sidebarPanel(
      # Inputs excluded for brevity
	##sliderInput(inputId = "num", label = "Choose a number", value = 25, min = 1, max=1000),
	helpText("For the graphic select variables"),
	selectInput("Amountby", "Select variable:", choices=colnames(coldisplay)),
        hr(),
        helpText("All  data presented is not real"),
	helpText("For the cluster select variables"),
	selectInput('xcol', 'X Variable', names(df2)),
    	selectInput('ycol', 'Y Variable', names(df2),
        selected=names(df2)[[2]]),
    	numericInput('clusters', 'Cluster count', 2, min = 2, max = 5)

    ),
  
    mainPanel(

      tabsetPanel(
        tabPanel("By category", plotOutput("phonePlot")), 
        tabPanel("Cluster K", plotOutput("plot1")), 
        tabPanel("Table Content", dataTableOutput(outputId="table"))
	 ###,tabPanel("Map", plotOutput("plot1")), 




      )
    )
  )

)