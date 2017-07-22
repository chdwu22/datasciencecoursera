#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)
library(ggplot2)
library(grid)
library(gridExtra)

# Define server logic required to draw a histogram
shinyServer(function(input, output) {
  cars <- mtcars
  cars$am <- as.factor(cars$am)
  model <- lm(mpg~cyl+disp+wt+am, data = cars)
  coeff <- model$coefficients
  
  df <- NULL
  
  prediction <- reactive({
    transmission <- as.factor(0)
    if(input$am == FALSE)
      transmission <- as.factor(1)
    df <- data.frame(cyl=input$cyl, disp=input$disp, wt=input$wt/1000, am=transmission)
    predict(model, df)
  })
  
  output$pred <- renderText(prediction())
  
  getCyl <- reactive({input$cyl})
  getDisp <- reactive({input$disp})
  getWt <- reactive({input$wt/1000})
  getAm <- reactive({
    transmission <- as.factor(0)
    if(input$am == FALSE)
      transmission <- as.factor(1)
  })
   
  output$plot <- renderPlot({
    p1 <- qplot(cyl, mpg, data=mtcars) + geom_point(data = data.frame(cyl=getCyl(), mpg=prediction()), aes(x=cyl, y= mpg), colour="red", shape = 13, size = 4)
    p2 <- qplot(disp, mpg, data=mtcars) + geom_point(data = data.frame(disp=getDisp(), mpg=prediction()), aes(x=disp, y= mpg), colour="red", shape = 13, size = 4)
    p3 <- qplot(wt, mpg, data=mtcars) + geom_point(data = data.frame(wt=getWt(), mpg=prediction()), aes(x=wt, y= mpg), colour="red", shape = 13, size = 4)
    p4 <- qplot(am, mpg, data=mtcars)
    grid.arrange(p1, p2, p3, p4, ncol = 2)
  })
})
