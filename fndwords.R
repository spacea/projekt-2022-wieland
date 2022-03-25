# potrzebny pakiet stringr

# pckg_installed = function(){
#   existence_pckg = require("stringr")
#   if(existence_pckg == FALSE){
#     install.packages("stringr")
#     library(stringr)
#   }
# }
install.packages("usethis")
library(usethis)
install.packages("available")
library(available)

available("fndwords")

pckg_installed()
preparation_folder = function(){
if(dir.exists("dictionaries") == FALSE)
{
  dir.create("dictionaries")
}}


download_words = function(dir_of_word, encoding_pck){
words_together = readLines(dir_of_word, encoding = encoding_pck)
words_together = tolower(words_together)

  return(words_together)
}

# encoding: "iso8859-1", "UTF-8"

find_words = function(write_a_word, dictionary, report){
  write_a_word = paste("^", write_a_word, "$", sep = "")
  extracted_words = str_subset(dictionary, pattern = write_a_word)
  print(extracted_words)
  return(extracted_words)
}

report_txt = function(word_data){
  get_words = word_data
  first_word = word_data[1]
    if(dir.exists("results") == FALSE){
      dir.create("results")
    }
    write.table(c(word_data), file = paste("results/", first_word, ".txt"), sep = "")
    cat("Report created successfully.")
    dir_return = paste(" Directory: results/", first_word, ".txt", sep = "")
    cat(dir_return)
}

# 
# eng = readLines("C:/Users/User/Desktop/projekt_krzyzowkowy/dictionaries/english.txt")
# # eng
# # 
# report_txt(find_words("si...",  eng))

