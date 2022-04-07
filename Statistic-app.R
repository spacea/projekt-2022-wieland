
ui <- fluidPage(
  
  
  titlePanel("Wykresy"),
  
  
  sidebarLayout(
    
    
    sidebarPanel(
      
      
      radioButtons("dist", "JÄ™zyk:",
                   c("Polski" = "PL",
                     "Angielski" = "ENG",
                     "Niemiecki" = "GER")),
      
      
      br(),
      
      
      sliderInput("n",
                  "Litery alfabetu:",
                  value = 500,
                  min = 1,
                  max = 1000)
    ),
    
    
    mainPanel(
      
      
      tabsetPanel(type = "tabs",
                  tabPanel("Plot", plotOutput("plot")),
                  tabPanel("Summary", verbatimTextOutput("summary")),
                  tabPanel("Table", tableOutput("table"))
      )
      
    )
  )
)


server <- function(input, output) {
  
  
  d <- reactive({
    dist <- switch(input$dist,
                   Polski = rPolski,
                   Angieslki = rAngielski,
                   Niemiecki = rNiemiecki,
                   
                   rnorm)
    
    dist(input$n)
  })
  
  
  output$plot <- renderPlot({
    dist <- input$dist
    n <- input$n
    
    hist(d(),
         main = paste("r", dist, "(", n, ")", sep = ""),
         col = "#75AADB", border = "white")
  })
  
  
  output$summary <- renderPrint({
    summary(d())
  })
  
  
  output$table <- renderTable({
    d()
  })
  
}

shinyApp(ui, server)

