library(shiny)
library(shinythemes)

shinyUI(fluidPage(theme = shinytheme("journal"),
                  tags$head(
                    tags$style(HTML("
      h1 {
        font-weight: 500;
        line-height: 1.1;
        color: #48ca3b;
      }
      h2 {
        font-weight: 500;
        line-height: 1.1;
        color: gray;
      }
      h3 {
        font-weight: 500;
        line-height: 1.1;
        color: blue;
      }

    "))
                  ),                
                  
  headerPanel("housing price index by period and place"),
  sidebarPanel(
    sliderInput('period', 'period:', 1, min = 0, max = 99, step = 1),
    radioButtons("place_name", "place_name:",
                 c("East South Central Division" = "East South Central Division",
                   "East North Central Division" = "East North Central Division")
                   "West South Central Division" = "West South Central Division",
                   "West North Central Division" = "West North Central Division")    
                   ),
    actionButton('goButton', "Submit"),
    HTML("<br/><br/><br/>"),
    HTML('<b>Documentation:</b><br/>'),
    HTML("This shiny app was built based on data from <a target='blank' href='https://www.fhfa.gov/DataTools/Downloads/Pages/House-Price-Index-Datasets.aspx'>this website</a>. 
         Data were taken from US housing authority providing statistics on housing price index "),
    HTML("<br/><br/>"),
    HTML('<b>Instructions:</b><br/>'),
    HTML("<b>1)</b> Select your period from the slider <br/>
          <b>2)</b> Select your place_name from the radio button <br/>
          <b>3)</b> Click on the Submit button <br/>
          Your housing index will be showed on tabs on the right."),
    HTML("<br/><br/>"),
    HTML('<b>GitHub repository with .R files:</b>'),
    HTML("<a target='blank' href='https://github.com/pjwalshldn/DevelopingDataProducts.git'>Link</a>"),
    HTML("<br/><br/>")
    
  ),
  mainPanel(
    uiOutput('myoutput')
  )
))
