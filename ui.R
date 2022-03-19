library(shiny)

shinyUI(fluidPage(
  titlePanel("An app that will help you with resolving a crossword!"),
  sidebarLayout(
    sidebarPanel(
      p("Tutaj jest lewy panel")
      
    ),
    mainPanel(
      br(),
      
      textInput(inputId = "language", label = "Choose a language. Type PL, EN lub GE: "),
      textInput(inputId = "word", label = "Type down a word that you would like to guess. Where a letter is missing, enter a dot: ", placeholder = "Ex.: statis..cs"),
      actionButton(inputId = "start", label = "Run", width = "300px")
    ),
  )
))