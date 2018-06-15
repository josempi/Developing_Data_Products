#
# This is the server logic of a Shiny web application. You can run the
# application by clicking 'Run App' above.
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


function(input, output, session) {

        # Reactive expression for the data subsetted to what the user selected
        filteredData <- reactive({
                MapQuakeData[MapQuakeData$mag >= input$range[1] & MapQuakeData$mag <= input$range[2],]
        })

        # This reactive expression represents the palette function,
        # which changes as the user makes selections in UI.
        colorpal <- reactive({
                colorNumeric(input$colors, MapQuakeData$mag)
        })

        output$map <- renderLeaflet({
                # Use leaflet() here, and only include aspects of the map that
                # won't need to change dynamically (at least, not unless the
                # entire map is being torn down and recreated).
                leaflet(MapQuakeData) %>% addTiles() %>%
                        fitBounds(~min(long), ~min(lat), ~max(long), ~max(lat))
        })

        # Incremental changes to the map (in this case, replacing the
        # circles when a new color is chosen) should be performed in
        # an observer. Each independent set of things that can change
        # should be managed in its own observer.
        observe({
                pal <- colorpal()

                leafletProxy("map", data = filteredData()) %>%
                        clearShapes() %>%
                        addCircles(radius = ~10^mag/10, weight = 1, color = "#777777",
                                   fillColor = ~pal(mag), fillOpacity = 0.7, popup = ~paste(mag)
                        )
        })

        # Use a separate observer to recreate the legend as needed.
        observe({
                proxy <- leafletProxy("map", data = MapQuakeData)

                # Remove any existing legend, and only if the legend is
                # enabled, create a new one.
                proxy %>% clearControls()
                if (input$legend) {
                        pal <- colorpal()
                        proxy %>% addLegend(position = "bottomright",
                                            pal = pal, values = ~mag
                        )
                }
        })
}
