## Jean-Louis Rochet, 8-5-16
## Shiny app test with Histogram example

# Load shiny library
library(shiny)

# ui
ui <- fluidPage(
        sliderInput(inputId = "num", label = "Choose a number", value = 25, min = 1, max = 100),
        plotOutput("hist")
)

#server
server <- function(input, output) {
        output$hist <- renderPlot({
                hist(rnorm(input$num), main = "Histogram")
        })
}

# Execute app
shinyApp(ui = ui, server = server)