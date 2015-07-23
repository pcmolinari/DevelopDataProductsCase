
#server.R

###################
## set up the data
####################
palette(c("#E41A1C", "#377EB8", "#4DAF4A", "#984EA3",
  "#FF7F00", "#FFFF33", "#A65628", "#F781BF", "#999999"))

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

# Load the ggplot2 package which provides
# the 'mpg' dataset.
library(ggplot2)






##################
##################




library(shiny)


server <-function(input, output) {


selectedData <- reactive({
    df2[, c(input$xcol, input$ycol)]
})

clusters <- reactive({
    kmeans(selectedData(), input$clusters)
})


  output$plot1 <- renderPlot({
    par(mar = c(5.1, 4.1, 0, 1))
    plot(selectedData(),
         col = clusters()$cluster,
         pch = 20, cex = 3)
    points(clusters()$centers, pch = 4, cex = 4, lwd = 4)
  })





output$hist<- renderPlot({
hist(rnorm(input$num))
})

output$stats<- renderPrint({
summary(rnorm(input$num))
})


output$table <- renderDataTable({    
data <- df
data
})



  
  # Fill in the spot we created for a plot
  output$phonePlot <- renderPlot({
    
    # Render a barplot
   
if (input$Amountby == "type") {
barplot(df3$amount, names.arg=df3$type)
}

if (input$Amountby == "card_holder") {
barplot(df4$amount, names.arg=df4$card_holder)
}

if (input$Amountby == "country") {
barplot(df5$amount, names.arg=df5$country)
}

if (input$Amountby == "date_charged") {
barplot(df6$amount, names.arg=df6$date_charged)
}

  })




}

