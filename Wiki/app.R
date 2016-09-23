## Jean-Louis Rochet, 8-5-16
## Shiny app for MA WinWin Wiki leaflet map

# Load libraries
library(shiny)
library(magrittr)
library(readr)
library(leaflet)

# Read file
wiki <- read_csv("mawikiclean.csv")

# Define sector colors
pal <- colorFactor(c("navy", "red", "green"), domain = c("Public", "Social", "Private"))

# ui
ui <- fluidPage(
        title = "MA WinWin Wiki Map",
        leafletOutput("map"),
        #filters as inputs
        checkboxGroupInput(inputId = "sector", label = "Sectors:", 
                           choices = c("Public" = "Public", "Social" = "Social", "Private" = "Private"), 
                           selected = c("Public" = "Public", "Social" = "Social", "Private" = "Private"))
)

#server
server <- function(input, output) {
        # Sector filter reactivity NOT WORKING
        wikitab <- wiki[wiki$Sector==input$sector,] #subsetting works in command line when sector specified
        
        #Leaflet output
        output$map <- renderLeaflet({
                leaflet(data = wikitab) %>%
                        addProviderTiles("CartoDB.Positron") %>%
                        addCircleMarkers(popup = ~Organization, color = ~pal(Sector), 
                                         clusterOptions = markerClusterOptions())
        })
}

# Execute app
shinyApp(ui = ui, server = server)