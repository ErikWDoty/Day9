#
# This is the server logic of a Shiny web application. You can run the 
# application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

# Data
load('prad.project.RData')

# Libraries
require(shiny)
require(ggplot2)

shinyServer(
  function(input, output) {
    
    
    output$ReactivePCA <- renderPlot(
      ggplot(prad.project, 
             aes_string(
               substr(input$pcselect, 1, 3), substr(input$pcselect, 7, 9)
             )
      ) +
        geom_point(
          if (length(input$lab) == 0) NULL
          else if (length(input$lab) == 2) {
            aes(col=factor(annot), shape=factor(clust))
          }
          else if (length(input$lab) == 1 & input$lab == 'TCGA Annotation') {
            aes(col=factor(annot))
          }
          else if (length(input$lab) == 1 & input$lab == 'Hierarchical Clustering') {
            
            aes(shape = factor(clust))
            
            
            
            ########################
            # FILL THIS OUT TO     #
            # SET THE SHAPE USING  #
            # CLUSTER MEMBERSHIP   #
            ########################
          }
        ) +
        theme_bw() +
        theme(panel.grid.major = element_blank(),
              panel.grid.minor = element_blank()) +
        labs( title = input$pcselect,
          x = substr(input$pcselect, 1, 3), y = substr(input$pcselect, 7, 9)
        )
    )
  })