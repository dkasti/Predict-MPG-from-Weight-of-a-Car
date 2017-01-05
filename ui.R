#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
shinyUI(fluidPage(
    titlePanel("Predict MPG from Weight of a car"),
    h3("Documentation: How to use this app?"),
    h5("Although, it is almost selft explanatory, I would like to explain how you can use this app.
       This app is based on the mtcars data extracted from the 1974 Motor Trend US magazine, and
       comprises fuel consumption and 10 aspects of automobile design and performance for 32 automobiles (1973–74 models).
       In this app a user can input various values of weight for a car ranging from 1000 lbs to 6000 lbs by sliding the slidebar below. Then, the app
       gives the predicted values for miles per gallon of the car based on three models: linear, quadratic and cubic. The app
       also shows the fitting curves for each of these models in the mtcars data set, which a user can hide, if one wants, by
       unchecking the checkboxes below."),
    sidebarLayout(
        sidebarPanel(
            sliderInput("sliderWT", "Weight of the car (in 100 lbs)?", 10, 60, value = 30),
            checkboxInput("showModel1", "Show/Hide Linear Model", value = TRUE),
            checkboxInput("showModel2", "Show/Hide Quadratic Model", value = TRUE),
            checkboxInput("showModel3", "Show/Hide Quintic Model", value = TRUE)
        ),
        mainPanel(
            plotOutput("plot1"),
            h4("Predicted MPG of the car from Linear Model:"),
            textOutput("pred1"),
            h4("Predicted MPG of the car from Quadratic Model:"),
            textOutput("pred2"),
            h4("Predicted MPG of the car from Quintic Model:"),
            textOutput("pred3")
        )
    )
))
