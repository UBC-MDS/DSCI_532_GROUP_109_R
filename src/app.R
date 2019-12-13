library(dash)
library(dashCoreComponents)
library(dashHtmlComponents)
library(dashTable)
library(tidyverse)
library(plotly)
library(cowplot)
library(gapminder)

app <- Dash$new(external_stylesheets = "https://codepen.io/chriddyp/pen/bWLwgP.css")

source("make_plot.R")

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
      htmlH1('Fate of Titanic Passengers by Location on Ship'),
      htmlH2('Description'),
      #selection components go here
      htmlIframe(height=15, width=10, style=list(borderWidth = 0)), #space
      htmlLabel('Select deck level'),
      deckDropdown,
      #end selection components
      graph,
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