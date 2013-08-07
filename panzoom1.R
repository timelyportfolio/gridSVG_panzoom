require(ggplot2)
require(gridSVG)

easyData <- data.frame(x=0:5,y=seq(0,50,by=10))

ggplot(data = easyData, aes(x=x,y=y)) +
  geom_point(size = 6) +
  scale_x_continuous(breaks=seq(0, 5, 1)) +
  scale_y_continuous(breaks=seq(0, 50, 10)) +
  theme(panel.grid.major = element_line(size=1,colour="gray")) +
  theme(panel.grid.minor = element_line(colour=NA)) +
  theme(panel.background = NULL)

#define a simple html head template
htmlhead <- 
'<!DOCTYPE html>
<head>
  <meta charset = "utf-8">
  <script src = "http://d3js.org/d3.v3.js"></script>
</head>

<body>
'

#use gridSVG to export our plot to SVG
mysvg <- grid.export("panzoom1.svg")


#define a simple pan zoom script using d3
panzoomScript <-
'  <script>
    var svg = d3.selectAll("#gridSVG");
svg.call(d3.behavior.zoom().scaleExtent([1, 8]).on("zoom", zoom))

function zoom() {
  svg.attr("transform", "translate(" + d3.event.translate + ")scale(" + d3.event.scale + ")");
} 
  </script>
</body>
'

#combine all the pieces into an html file
sink("panzoom_ggplot2.html")
cat(htmlhead,saveXML(mysvg$svg),panzoomScript)
sink(file=NULL)

