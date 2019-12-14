library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
#library(tidyverse)
#library(plotly)
#library(cowplot)
#library(gapminder)

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

source("src/make_plot.R")

deckDropdown <- dccDropdown(
  id = 'deck',
  options=list(
    list(label = "A", value = "A"),
    list(label = "B", value = "B"),
    list(label = "C", value = "C"),
    list(label = "D", value = "D"),
    list(label = "E", value = "E"),
    list(label = "F", value = "F"),
    list(label = "G", value = "G")
  ),
  value = "F" 
)

graph <- dccGraph(
  id = 'cabin_graph',
  figure = facet_plots2()
)


graph3 <- dccGraph(
  id = 'deck_graph',
  figure = facet_plots1()
)


app$layout(
  htmlDiv(
    list(
      htmlImg(src='https://github.com/RobBlumberg/titanic_image/blob/master/titanic_header_new.png?raw=true', width='1780px'),
      htmlH2('The sinking of the Titanic on April 12, 1912 four days into its maiden voyage as thelargest ocean liner in the world is one of the worst maritime disasters of all time which killed over 1,500 of the estimated 2,224 passengers and crew on board. This app has been created to support an exploratory research proposal on the correlation of passenger location with survival rates which may be used to improve and democratize safety in the design of large passenger ships.'),
      #selection components go here
      htmlIframe(height=15, width=10, style=list(borderWidth = 0)), #space
      htmlLabel('Select deck level'),
      deckDropdown,
      #end selection components
      graph,
      htmlImg(src='https://github.com/gptzjs/DSCI_532_GROUP_109_R/blob/master/img/survival_legend.png?raw=true', width='500px'),
      graph3,
      htmlIframe(height=20, width=10, style=list(borderWidth = 0)) #space
    )
  )
)

#Adding callbacks for interactivity
app$callback(
  # update figure of gap-graph
  output=list(id = 'cabin_graph', property='figure'),
   
  params=list(input(id = 'deck', property='value')),

   # this translates your list of params into function arguments
   function(deck_value) {
     facet_plots2(deck_value)
   })


app$run_server(host = "0.0.0.0", port = Sys.getenv('PORT', 8050))