#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
data(mtcars)
shinyServer(function(input, output) {
    mtcars$wt<-mtcars$wt*10
    fit1 <- lm(mpg~wt, data = mtcars)
    fit2 <- lm(mpg~poly(wt,2), data = mtcars)
    fit5 <- lm(mpg~poly(wt,5), data = mtcars)

    fit1pred <- reactive({
        weightInput <- input$sliderWT
        predict(fit1, newdata = data.frame(wt = weightInput))
    })

    fit2pred <- reactive({
        weightInput <- input$sliderWT
        predict(fit2, newdata = data.frame(wt = weightInput))
    })

    fit5pred <- reactive({
        weightInput <- input$sliderWT
        predict(fit5, newdata = data.frame(wt = weightInput))
    })
    output$plot1 <- renderPlot({
        weightInput <- input$sliderWT

        plot(mpg~wt, data = mtcars, xlab = "Weight of car in 100 lbs",
             ylab = "Miles Per Gallon", bty = "n", pch = 16, xlim = c(10,70), ylim = c(5,40))
        if(input$showModel1){
            abline(fit1, col = "red", lwd = 2)
        }
        if(input$showModel2){
            fit2values <- predict(fit2, newdata = data.frame(wt = 10:60))
            lines(10:60, fit2values, col = "blue", lwd = 2)
        }
        if(input$showModel3){
            fit5values <- predict(fit5, newdata = data.frame(wt = 10:60))
            lines(10:60, fit5values, col = "green", lwd = 2)
        }
        legend(50, 30, c("Linear Model", "Quadratic Model", "Quintic Model"), pch = 16,
               col = c("red", "blue", "green"), bty = "n", cex = 1.2)
        points(weightInput, fit1pred(), col = "red", pch = 16, cex = 2)
        points(weightInput, fit2pred(), col = "blue", pch = 16, cex = 2)
        points(weightInput, fit5pred(), col = "green", pch = 16, cex = 2)
    })

    output$pred1 <- renderText({
        round(fit1pred(),2)
    })

    output$pred2 <- renderText({
        round(fit2pred(),2)
    })

    output$pred3 <- renderText({
        round(fit5pred(),2)
    })
})
