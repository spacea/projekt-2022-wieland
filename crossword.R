# jesli polskie znaki w komentarzach sie nie wyswietlaja: File -> Reopen with encoding (UTF-8)

# sprawdzanie czy są zainstalowane pakiety
pckg_installed = function(){
  existence_pckg = require("stringr")
  if(existence_pckg == FALSE){
    install.packages("stringr")
    library(stringr)
  }
}

# Wybór języka i pobieranie archiwów ze zbiorami słów.
download_words = function(language){
if(dir.exists("dictionaries") == FALSE)
{
  dir.create("dictionaries")
}
# Wybieranie jezyka slownika.
language = readline(prompt = "Choose a language. Type PL, EN lub GE: ")
language = toupper(language)

# Pobieramy odpowiedni plik ze słowami
# Wczytujemy zawartość pliku txt do obiektu, który jest wektorem
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

# Polecenie do użytkownika. Ma wpisać słowo.
user_input = function(){
starting_word = readline(prompt = "Type down a word that you would like to guess. Enter a dot in the place of the missing letter: ")
starting_word = tolower(starting_word)
return(starting_word)
}

# Zapisywanie wyniku do pliku txt
report_txt = function(word_data){
  #sprawdzanie czy są zainstalowane pakiety
  pckg_installed()
  get_words = word_data
  question = readline(prompt = "Would you like to create a report in .txt file? (Y/N): ")
  question = toupper(question)
  first_word = word_data[1]
  if(question == "Y"){
    if(dir.exists("results") == FALSE){
      dir.create("results")
    }
    # Nazwą pliku z raportem jest pierwsze słowo w zbiorze potencjalnych prawidłowych słów.
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
  # Dodajemy znaki, które informują komputer, gdzie są początek i koniec słowa
  with_missing_parts = paste("^", with_missing_parts, "$", sep = "")
  # Wydzielamy ze zbioru słowa, które zgadzają się z warunkami wpisanymi przez użytkownika.
  extracted_words = str_subset(dictionary, pattern = with_missing_parts)
  #cat(extracted_words, sep = ", ", fill = TRUE)
  print(extracted_words)
  cat("\n")
  return(extracted_words)
}


# Pobieranie biblioteki do obsługi stringów
# install.packages("stringr")
# library(stringr)
# x = require("stringr")

report_txt(find_words(download_words(), user_input()))
