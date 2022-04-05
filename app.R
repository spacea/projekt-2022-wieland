# install.packages("shiny")
library(shiny)
# install.packages("stringi")
library(stringi)
#install.packages("shinyFiles")
library(shinyFiles)
# ui = (navbarPage("An app about words",
ui = fluidPage(
  tags$head(
    tags$style(HTML("
        @import url('https://fonts.googleapis.com/css2?family=Dosis:wght@200&display=swap');
        
        body {
        background-color: white;
        color: black;
        font-family: 'Dosis', sans-serif; font-size: 20px;
        }
        h2 {
          font-family: 'Dosis', sans-serif; font-size: 35px;
        }
        .shiny-input-container{
        font-family: 'Dosis', sans-serif;text-align: justify; font-size: 15px;
        }

 "))
  ),
  (tags$script(
  "Shiny.addCustomMessageHandler('message', function(params) { alert(params); });")),
  
  navbarPage("",
    tabPanel("Crossword Assistant",
    titlePanel("This program will help you with resolving a crossword!"),
    br(),
                      
    sidebarPanel(radioButtons(inputId = "choose_language", label = "Choose a language.", c("English" = "EN", "Polish" = "PL","German" = "GE", "Your directory" = "dir_up")),

                 shinyFilesButton("Btn_GetFile", "Choose a file" ,
                                  title = "Please select a file:", multiple = FALSE,
                                  buttonType = "default", class = NULL),
                 
                 
                 verbatimTextOutput("txt_file"),
                 textInput("txt_dir", "Paste the directory down below:", placeholder = "Directory..."),
                 textInput("txt_encoding", "Encoding:", placeholder = "Ex.: UTF-8"),
                 
                 
    textInput("word_type_down", label = "Type down a word that you would like to guess. Enter a dot in the place of the missing letter: ", placeholder = "Ex.: crossw.rd"),
    br(),
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

  output$txt_dir = reactive(input$txt_dir)
  
  output$txt_encoding = reactive(input$txt_encoding)
  
  
  volumes = getVolumes()
  observe({  
    shinyFileChoose(input, "Btn_GetFile", roots = volumes, session = session, filetypes=c('', 'txt'))
    
    if(!is.null(input$Btn_GetFile)){
      # browser()
      file_selected<-parseFilePaths(volumes, input$Btn_GetFile)
      output$txt_file <-  renderText(as.character(file_selected$datapath))
    }
  })
  
  results = function(language_input, word_input, file, encoding_file){

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
        words_together = stri_read_lines("dictionaries/german.txt", encoding = "windows-1252")
        words_together = tolower(words_together)
      }
      else if(file.exists("dictionaries/german.txt") == TRUE){
        words_together = stri_read_lines("dictionaries/german.txt", encoding = "windows-1252")
        words_together = tolower(words_together)
      }
    }
    else if(language == "DIR_UP"){
      words_together = stri_read_lines(file, encoding = encoding_file)
      words_together = tolower(words_together)
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
  
  
  output$txt = renderText(print(results(input$choose_language ,input$word_type_down, input$txt_dir, input$txt_encoding)))
  
  
  observeEvent(input$create_report, {
    save_in_file(results(input$choose_language ,input$word_type_down, input$txt_dir, input$txt_encoding))
    
  })
  # Wyświetlanie ścieżki do pliku z zapisanymi wynikami
  observeEvent(input$create_report,{
    randomNumber <- runif(1,0,100)
    session$sendCustomMessage("message", list(show_dir(results(input$choose_language ,input$word_type_down, input$txt_dir, input$txt_encoding))))
  })



}
shinyApp(ui, server)
