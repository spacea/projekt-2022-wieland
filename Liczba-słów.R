pckg_installed = function(){
  existence_pckg = require("stringr")
  if(existence_pckg == FALSE){
    install.packages("stringr")
    library(stringr)
  }
}

download_words = function(language){
  if(dir.exists("dictionaries") == FALSE)
    {
    dir.create("dictionaries")
  }
  
  }
  

  language = readline(prompt = "Choose a language. Type PL, EN lub GE: ")
  language = toupper(language)
  
  
  # Dla języka polskiego 
 
  if(language == "PL"){
    
    if(file.exists("dictionaries/polish.txt") == FALSE){
      
      download.file("http://czterycztery.pl/slowo/lista_frekwencyjna_z_odmianami/slowa.txt", "dictionaries/polish.txt")
      words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
    }
    else if(file.exists("dictionaries/polish.txt") == TRUE){
      words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
    }
  }
      
library(stringr)
x = require("stringr")

report_txt(find_words(download_words(), user_input()))

literki = c(LETTERS)
literki = tolower(literki)

for(i in 1:26){
  literka = literki[i]
  words_together = readLines("http://czterycztery.pl/slowo/lista_frekwencyjna_z_odmianami/slowa.txt", encoding = "UTF-8")
  words_together
  wystepowanie = str_count(string = words_together, pattern = literka)
  cat(sum(wystepowanie))
  cat("\n")}


# Dla języka angielskiego 

if(language == "EN"){
  
  if(file.exists("dictionaries/english.txt") == FALSE){
    
    download.file("http://www.gwicks.net/textlists/english3.zip", "dictionaries/english.txt")
    words_together = readLines("dictionaries/english.txt", encoding = "UTF-8")
  }
  else if(language == "EN"){
    if(file.exists("dictionaries/english.txt") == FALSE){
      download.file("http://www.gwicks.net/textlists/english3.zip", "dictionaries/english.zip")
      unzip("dictionaries/english.zip", exdir = "dictionaries", overwrite = TRUE)
      file.rename("dictionaries/english3.txt","dictionaries/english.txt")
      file.remove("dictionaries/english.zip")
      words_together = readLines("dictionaries/english.txt", encoding = "UTF-8")
    }
  }
  
  library(stringr)
  x = require("stringr")
  
  report_txt(find_words(download_words(), user_input()))
  
  literki = c(LETTERS)
  literki = tolower(literki)
  
  for(i in 1:26){
    literka = literki[i]
    words_together = readLines("http://www.gwicks.net/textlists/english3.zip", encoding = "UTF-8")
    words_together
    wystepowanie = str_count(string = words_together, pattern = literka)
    cat(sum(wystepowanie))
    cat("\n")}
  



 



