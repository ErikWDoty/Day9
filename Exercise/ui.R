#
# This is the user-interface definition of a Shiny web application. You can
# run the application by clicking 'Run App' above.
#
# Find out more about building applications with Shiny here:
# 
#    http://shiny.rstudio.com/
#

library(shiny)

shinyUI(fluidPage(
  # Layout
  sidebarLayout(
    sidebarPanel(
      # Select PCs
      radioButtons(inputId = 'pcselect',
                   label='Select PC\'s to display',
                   choices = c('PC1 x PC2','PC1 x PC3','PC2 x PC3'),
                   selected = 'PC1 x PC2'),
      # Labels or No Labels
      h5(
       
      ),
      checkboxGroupInput(inputId = 'lab',
                         label = 'Display Labels?',
                         choices = c('TCGA Annotation', 'Hierarchical Clustering'))
    ),
    mainPanel(
      
      strong(h5(textOutput('labPCA'))),
     
      plotOutput("ReactivePCA")
      # Plotting
      ##############################
      # ADD A CALL TO plotOutput() #
      # TO DISPLAY YOUR SERVERSIDE #
      # GRAPHING                   #
      ##############################
    )
  )
))
