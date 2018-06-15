#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
#
#    http://shiny.rstudio.com/
#

library(shiny)
library(leaflet)
library(RColorBrewer)
EarthQuakeData <- read.csv2("https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_month.csv", sep = ",")
MapQuakeData <- EarthQuakeData[c(2,3,5)]
colnames(MapQuakeData) <- c("lat", "long", "mag")
MapQuakeData$lat <- as.numeric(levels(MapQuakeData$lat)[MapQuakeData$lat])
MapQuakeData$long <- as.numeric(levels(MapQuakeData$long)[MapQuakeData$long])
MapQuakeData$mag <- as.numeric(levels(MapQuakeData$mag)[MapQuakeData$mag])

bootstrapPage(
        titlePanel("  Worldwide Seismic Activity - Last Month"),
        tags$style(type = "text/css", "html, body {width:100%;height:100%}"),
        leafletOutput("map", width = "100%", height = "100%"),
        absolutePanel(top = 10, right = 10,
                      sliderInput("range", "Magnitudes", min(MapQuakeData$mag), max(MapQuakeData$mag),
                                  value = range(MapQuakeData$mag), step = 0.1
                      ),
                      selectInput("colors", "Color Scheme",
                                  rownames(subset(brewer.pal.info, category %in% c("seq", "div")))
                      ),
                      checkboxInput("legend", "Show legend", TRUE)
        )
)
