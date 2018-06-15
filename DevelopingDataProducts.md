Developing Data Products
========================================================
author: Jose M. Pi
date: June 14, 2018
autosize: true





## Worldwide Seismic Activity - Last Month

Introduction
========================================================

This presentation is part of the Developing Data Products Coursera.org course project submission.

- This is an R Presentation generated with RStudio Version 1.0.153 – © 2009-2017 RStudio, Inc.
- Libraries and resources used were Shiny, Leaflet, RColorBrewer and Slidify.


Data Summary - Worldwide Seismic Activity - Last Month
========================================================



Ref: https://earthquake.usgs.gov/earthquakes/feed/v1.0/summary/1.0_month.csv

```r
summary(MapQuakeData)
```

```
      lat              lng              mag       
 Min.   :-65.20   Min.   :-180.0   Min.   :0.950  
 1st Qu.: 19.40   1st Qu.:-155.3   1st Qu.:1.740  
 Median : 19.42   Median :-155.3   Median :2.130  
 Mean   : 28.44   Mean   :-136.5   Mean   :2.202  
 3rd Qu.: 37.83   3rd Qu.:-146.5   3rd Qu.:2.530  
 Max.   : 83.89   Max.   : 179.9   Max.   :6.100  
```

```r
head(MapQuakeData)
```

```
       lat       lng  mag
1 19.42667 -155.2842 2.12
2 19.42900 -155.2887 2.01
3 19.44200 -155.2442 2.46
4 19.40950 -155.2685 2.61
5 19.41800 -155.2655 2.15
6 19.40933 -155.2632 2.10
```


Worldwide Seismic Activity - Last Month
========================================================
### Worldwide Seismic Activity Study


This is a geospatial graphical plot, using the Leaflet Open Street Map functionality, that allows the observer to select magnitude ranges, color schemes, and the map zoom in/out function using the mouse or the +/- button.

Use the link below to run the interactive study.

Shiny App Link: https://datast0r.shinyapps.io/Worldwide_Seismic_Activity/


GitHub Repository Info
========================================================

Use the below link to access the GitHub files.

GitHub Link: https://github.com/josempi/Developing_Data_Products
