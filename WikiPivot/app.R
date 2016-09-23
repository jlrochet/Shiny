## Jean-Louis Rochet, 8-19-16
## Shiny app for MA WinWin Wiki pivot table

# Load libraries
library(shiny)
library(magrittr)
library(leaflet)
library(dplyr)
library(rpivotTable)

# Read data
mawiki <- read.csv("mawiki.csv", stringsAsFactors = FALSE)

# Drop unnecessary columns
mawiki %>% select(Organization, Organization.Description, Programs.or.Key.Initiatives,
                  Program.description, Sector, Region.Served, Primary.Dimension,
                  Primary.Componenet, Primary.Indicator) -> mawiki

# Drop empty rows
mawiki <- mawiki[1:2379,]

# Generic pivot table
# rpivotTable(mawiki)

# Standard pivot table
# rpivotTable(mawiki, rows = c("Primary.Dimension", "Primary.Componenet", "Primary.Indicator"), cols = "Sector", rendererName = "Table", 
#            exclusions = list(Sector = list(""), Primary.Indicator = list("")))

# Bar chart of number of programs in each sector by primary dimension
# rpivotTable(mawiki, rows = "Primary.Dimension", cols = "Sector", rendererName = "Bar Chart", 
#            exclusions = list(Sector = list("")))

# Treemap of Primary Component prevalence by sector
# rpivotTable(mawiki, rows = c("Sector", "Primary.Componenet"), rendererName = "Treemap", exclusions = list(Sector = list("")))

# ui
ui <- fluidPage(
        title = "MA WinWin Wiki Pivot Table",
        rpivotTableOutput("pivot")
)

#server
server <- function(input, output) {
        output$pivot <- renderRpivotTable({
                rpivotTable(mawiki, rows = c("Primary.Dimension", "Primary.Componenet", 
                                    "Primary.Indicator"), cols = "Sector", 
                                    rendererName = "Table", exclusions = list(Sector = list(""), 
                                    Primary.Indicator = list("")))
        })
}

# Execute app
shinyApp(ui = ui, server = server)