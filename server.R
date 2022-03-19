shinyServer(function(input, output) {

  pckg_installed = function(){
    existence_pckg = require("stringr")
    if(existence_pckg == FALSE){
      install.packages("stringr")
      library(stringr)
    }
  }
  
  # Wybór jêzyka i pobieranie archiwów ze zbiorami s³ów.
  download_words = function(language){
    if(dir.exists("dictionaries") == FALSE)
    {
      dir.create("dictionaries")
    }
    # Wybieranie jezyka slownika.
    language = readline(prompt = "Choose a language. Type PL, EN lub GE: ")
    language = toupper(language)
    
    # Pobieramy odpowiedni plik ze s³owami
    # Wczytujemy zawartoœæ pliku txt do obiektu, który jest wektorem
    if(language == "PL"){
      
      if(file.exists("dictionaries/polish.txt") == FALSE){
        download.file("https://sjp.pl/slownik/growy/sjp-20220313.zip", "dictionaries/polish.zip")
        unzip("dictionaries/polish.zip", exdir = "dictionaries", overwrite = TRUE)
        file.rename("dictionaries/slowa.txt" ,"dictionaries/polish.txt")
        file.remove("dictionaries/polish.zip")
        readLines("dictionaries/README.txt", encoding = "UTF-8")
        words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
      }
      else if(file.exists("dictionaries/polish.txt") == TRUE){
        readLines("dictionaries/README.txt", encoding = "UTF-8")
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
    return(words_together)
  }
  
  # Polecenie do u¿ytkownika. Ma wpisaæ s³owo.
  user_input = function(){
    starting_word = readline(prompt = "Type down a word that you would like to guess. Where a letter is missing, enter a dot: ")
    starting_word = tolower(starting_word)
    return(starting_word)
  }
  
  # Zapisywanie wyniku do pliku txt
  report_txt = function(word_data){
    #sprawdzanie czy s¹ zainstalowane pakiety
    pckg_installed()
    get_words = word_data
    question = readline(prompt = "Would you like to create a report in .txt file? (Y/N): ")
    question = toupper(question)
    first_word = word_data[1]
    if(question == "Y"){
      if(dir.exists("results") == FALSE){
        dir.create("results")
      }
      # Nazw¹ pliku z raportem jest pierwsze s³owo w zbiorze potencjalnych prawid³owych s³ów.
      write.table(word_data, file = paste("results/", first_word, ".txt"), sep = "")
      cat("Report created successfully.")
      dir_return = paste(" Directory: results/", first_word, ".txt", sep = "")
      cat(dir_return)
      cat("\n")
    }
    if(question == "N"){
      cat("No report created.")
      cat("\n")
    }
  }
  
  find_words = function(dictionary, with_missing_parts){
    cat("\n")
    # Dodajemy znaki, które informuj¹ komputer, gdzie s¹ pocz¹tek i koniec s³owa
    with_missing_parts = paste("^", with_missing_parts, "$", sep = "")
    # Wydzielamy ze zbioru s³owa, które zgadzaj¹ siê z warunkami wpisanymi przez u¿ytkownika.
    extracted_words = str_subset(dictionary, pattern = with_missing_parts)
    #cat(extracted_words, sep = ", ", fill = TRUE)
    print(extracted_words)
    cat("\n")
    return(extracted_words)
  }
  
input$goButton
#output$text = renderText({ input$find_words(download_words(), user_input())})
  })