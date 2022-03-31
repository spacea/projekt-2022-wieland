library(shiny)
# ui = (navbarPage("An app about words",
ui = fluidPage((tags$script(
  "Shiny.addCustomMessageHandler('message', function(params) { alert(params); });")),
  
  navbarPage("",
          tabPanel("Crossword Assistant",
  titlePanel("This program will help you with resolving a crossword!"),

sidebarPanel(radioButtons(inputId = "choose_language", label = "Choose a language.", c("English" = "EN", "Polish" = "PL","German" = "GE")),
textInput("word_type_down", label = "Type down a word that you would like to guess. Enter a dot in the place of the missing letter: "),
# checkboxInput("report_y_or_n", "Create a .txt report"),
actionButton("create_report", "Create a .txt report"),
),
singleton(
  tags$head(tags$script(src = "message-handler.js"))
),
mainPanel(textOutput("txt")),),
tabPanel("Statistics"),
)
)



server <- function(input, output, session) {

  
  output$word_type_down = reactive(input$word_type_down)
  
  output$create_report = reactive(input$create_report)
  
  output$choose_language = reactive(input$choose_language)
  
  # output$txt = renderText({paste("Siema", input$choose_language)})
  #   
    
    
    results = function(language_input, word_input){
      
      existence_pckg = require("stringr")
      if(existence_pckg == FALSE){
        install.packages("stringr")
        library(stringr)
        
      }
      if(dir.exists("dictionaries") == FALSE)
      {
        dir.create("dictionaries")
      }
      # Wybieranie jezyka slownika.
      language = language_input
      language = toupper(language)
      
      # Pobieramy odpowiedni plik ze słowami
      # Wczytujemy zawartość pliku txt do obiektu, który jest wektorem
      if(language == "PL"){
        
        if(file.exists("dictionaries/polish.txt") == FALSE){
          download.file("http://czterycztery.pl/slowo/lista_frekwencyjna_z_odmianami/slowa.txt", "dictionaries/polish.txt")
          words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
        }
        else if(file.exists("dictionaries/polish.txt") == TRUE){
          words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
        }
      }
      
      else if(language == "EN"){
        if(file.exists("dictionaries/english.txt") == FALSE){
          download.file("http://www.gwicks.net/textlists/english3.zip", "dictionaries/english.zip")
          unzip("dictionaries/english.zip", exdir = "dictionaries", overwrite = TRUE)
          file.rename("dictionaries/english3.txt","dictionaries/english.txt")
          file.remove("dictionaries/english.zip")
          words_together = readLines("dictionaries/english.txt", encoding = "UTF-8")
        }
        else if(file.exists("dictionaries/english.txt") == TRUE){
          words_together = readLines("dictionaries/english.txt", encoding = "UTF-8")
        }
      }
      else if(language == "GE"){
        if(file.exists("dictionaries/german.txt") == FALSE){
          download.file("http://www.gwicks.net/textlists/deutsch.zip", "dictionaries/german.zip")
          unzip("dictionaries/german.zip", exdir = "dictionaries", overwrite = TRUE)
          file.rename("dictionaries/deutsch.txt", "dictionaries/german.txt")
          file.remove("dictionaries/german.zip")
          words_together = readLines("dictionaries/german.txt", encoding = "iso8859-1")
          words_together = tolower(words_together)
        }
        else if(file.exists("dictionaries/german.txt") == TRUE){
          words_together = readLines("dictionaries/german.txt", encoding = "iso8859-1")
          words_together = tolower(words_together)
        }
      }
      
      starting_word = word_input
      starting_word = tolower(starting_word)
      
      # Dodajemy znaki, które informują komputer, gdzie są początek i koniec słowa
      starting_word = paste("^", starting_word, "$", sep = "")
      # Wydzielamy ze zbioru słowa, które zgadzają się z warunkami wpisanymi przez użytkownika.
      extracted_words = str_subset(words_together, pattern = starting_word)
      #cat(extracted_words, sep = ", ", fill = TRUE)
      
      get_words = extracted_words
      

      

      return(extracted_words)
      
      
    }
    
    save_in_file = function(selected_words){
    
    first_word = selected_words[1]
      if(dir.exists("results") == FALSE){
        dir.create("results")
      }
      # Nazwą pliku z raportem jest pierwsze słowo w zbiorze potencjalnych prawidłowych słów.
      write.table(selected_words, file = paste("results/", first_word, ".txt"), sep = "")
      dir_return = paste(" Directory: results/", first_word, ".txt", sep = "")
    
    }
    
    show_dir = function(selected_words){
      
      first_word = selected_words[1]
      # Nazwą pliku z raportem jest pierwsze słowo w zbiorze potencjalnych prawidłowych słów.
      dir_return = paste(" Directory: results/", first_word, ".txt", sep = "")
      
      return(dir_return)
    }
    
    # observeEvent(input$run_program, {
    #   output$txt = renderText(print(results(input$choose_language ,input$word_type_down ,input$report_y_or_n)))


    output$txt = renderText(print(results(input$choose_language ,input$word_type_down)))

    
observeEvent(input$create_report, {
  save_in_file(results(input$choose_language ,input$word_type_down))

  })
# Wyświetlanie ścieżki do pliku z zapisanymi wynikami
  observeEvent(input$create_report,{
    randomNumber <- runif(1,0,100)
    session$sendCustomMessage("message", list(show_dir(results(input$choose_language ,input$word_type_down))))
  })
}


shinyApp(ui, server)
