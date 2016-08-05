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
        leafletOutput("map")
)

#server
server <- function(input, output) {
        output$map <- renderLeaflet({
                leaflet(data = wiki) %>%
                        addTiles() %>%
                        addCircleMarkers(popup = ~Organization, color = ~pal(Sector), 
                                         clusterOptions = markerClusterOptions())
        })
}

# Execute app
shinyApp(ui = ui, server = server)