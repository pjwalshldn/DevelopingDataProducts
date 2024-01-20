library(ggplot2)
housingData <- data.frame(period=c('1,2,3,4,5,6,7,8,9,10,11,12,1,2,3,4,5,6,7,8,9,10,11,12,1,2'),
                        place_name=c('East North Central Division', 'East South Central Division', 'West South Central Division', 'West North Central Division',
                        index_nsa=c('101.8,101.9,102.0,99.1,103.1,101.5,107.1,100.1,100.0'),
housingData$period <- as.character(housingData$period)

initial.msg <- function(input.data){
  msg <- paste0("housing data shows that, for the period (", input.data$period, 
         ")  the index_nsa  ", input.data$index_nsa, 
         ")
  return(msg)
}


initial.plot <- function(housingData, input.data){
  g <- ggplot(housingData[housingData$period == input.data$period,], aes(x=period, y=index_nsa))) + geom_point(size=4) +
    geom_point(data=input.data, colour="blue", size=4) +
    geom_text(data=input.data, label="You", hjust=1.3, size=7, colour="blue") +
    labs(title=paste0("period to index_nsa"))
  return(g)
}

middle.msg <- function(input.data){
  if(input.data$period == '1' | input.data$period == '1'){  
    mid.msg <- "price measured early in the year"
  }
  else{
    mid.msg <- "Since you are past first measurement  means higher index_nsa,"     }
  return(mid.msg)
}
  
  g <- ggplot(house[housingData$place_name==input.data$place_name,], aes(x=period, y=index_nsa, color=gender)) + 
    geom_point(size=4) +
    geom_smooth(method="lm", col="green", size=1) +
    geom_point(data=pred.out, colour="blue", size=4) +
    geom_text(data=pred.out, label="You", vjust=-1.2, size=7, colour="blue") +
    labs(title=paste0("index_nsa by place_name"))
  
  return(g)
}


library(shiny)
shinyServer(
  function(input, output) {
    # Get period field
    period.vl <- eventReactive(input$goButton, {get.period.column(input$period)})
    
    # Get input data from the housingData dataset
    input.data <- eventReactive(input$goButton, {subset(housingData, `per`iod == period.vl() & gender == input$gender)})
    
    ## Initial period
    #output$init.msg <- renderText({initial.msg(input.data())})
    
    ## Initial Plot
    output$init.plot <- renderPlot({initial.plot(housingData, input.data())})
    
    ## Middle Messperiod
    #output$middle <- renderText({middle.msg(input.data())})
    
    ## Final Plot
    output$fin.plot <- renderPlot({final.plot(housingData, input.data())})
    
    # To conditionally load main panel at ui.R
    output$myoutput <- renderUI({
      if(input.data()$gender == 'Male' | input.data()$gender == 'Female'){
        tagList(
          h2('Results on 3 tabs'),
          tabsetPanel(
            tabPanel("period Analysis", 
                     h3('period Analysis For Your Gender'),
                     initial.msg(input.data()),
                     HTML("<br/>"),
                     plotOutput("init.plot"),
                     HTML("<br/>"),
                     
                     h4('Clinical Trend For period'),
                     middle.msg(input.data()),
                     HTML("<br/>")
                     ), 
            tabPanel("Gender Analysis", 
                     h3('Gender Analysis For All periods'),
                     final.msg(input.data()$gender),
                     HTML("<br/>"),
                     plotOutput("fin.plot"),
                     HTML("<br/>"),
                     h4('Clinical Trend For Gender'),
                     final.test(input.data()),
                     HTML("<br/>")
                     ), 
            tabPanel("Linear Model", 
                     h3('Predicting from Linear Model'),
                     msg.model(input.data()$gender),
                     HTML("<br/>"),
                     plotOutput("rate.model"),
                     HTML("<br/>"),
                     h4('Clinical Trend From Linear Model'),
                     final.msg.model(housingData, input.data()),
                     HTML("<br/>")
                     )
          )
        )
      }
    })
    
  }
)
