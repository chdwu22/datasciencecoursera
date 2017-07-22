#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

# Define UI for application that draws a histogram
shinyUI(fluidPage(
  
  # Application title
  titlePanel("Predicting Gas Mileage"),
  
  # Sidebar with a slider input for number of bins 
  sidebarLayout(
    sidebarPanel(
       sliderInput("cyl", "Number of cylinders:", min = 4, max = 8, value = 6),
       sliderInput("disp", "Engine displacement:", min = 60, max = 500, value = 200),
       sliderInput("wt", "Weight:", min = 1500, max = 5000, value = 3000),
       checkboxInput("am", "Automatic transmission", value = T),
       submitButton("Submit")
    ),
    
    # Show a plot of the generated distribution
    mainPanel(
       h3("Predicted MPG:"),
       h4(textOutput("pred")),
       h3("."),
       plotOutput("plot"),
       
       h3("DOCUMENTATION"),
       h4("Introduction"),
       h5("This application is used to predict gas mileage based on four predictors: the number of cylinders, engine displacement, weight, and transmission type. 
          The model used in this application is a linear regression model built using the 'mtcars' dataset. "),
       h4("How to use"),
       h5("Select the specs of the car by adjusting the sliders and the checkbox at the side panel. Then, click the 'submit' button. The main panel displays the results, 
          the predicted gas mileage of the car and some insightful plots. In the plot, the red 'circle-x' symbole denotes the the prediction.")
    )
  )
))
