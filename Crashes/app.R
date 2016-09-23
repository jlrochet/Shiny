## Created by Jean-Louis Rochet on 9-22-2016
## Map visualization for Cambridge crash data affecting pedestrians
## CSV file downloaded from open data site and renamed "crashes.csv"

# Load libraries
library(magrittr)
library(dplyr)
library(readr)
library(leaflet)
library(shiny)

# Read file
crashes <- read_csv("crashes.csv")

# Filter out rows where Object 2 is not pedestrian
crashes <- filter(crashes, `Object 2` == "Pedestrian")

# Filter out rows with NAs in Lat or Long
crashes <- filter(crashes, !is.na(Latitude) | !is.na(Longitude))

# ui
ui <- fluidPage(
        leafletOutput("map")
)

#server
server <- function(input, output) {
        output$map <- renderLeaflet({
                leaflet(data = crashes) %>%
                        addTiles() %>%
                        addCircleMarkers(popup = ~`Object 1`)
        })
}

# Execute app
shinyApp(ui = ui, server = server)