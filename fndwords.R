install.packages("usethis")
library(usethis)
install.packages("available")
library(available)
available("fndwords")


install.packages("stringr")
library(stringr)


  find_words = function(write_a_word, dictionary, report = FALSE, to_low = TRUE){
    if(is.vector(write_a_word) == FALSE){
      stop("Argumentem dictionary musi byc wektor!")
    }
  write_a_word = paste("^", write_a_word, "$", sep = "")
  if(to_low == TRUE){
    dictionary = tolower(dictionary)
  }
  extracted_words = str_subset(dictionary, pattern = write_a_word)
  
  if(report == TRUE){
    first_word = extracted_words[1]
    if(dir.exists("results") == FALSE){
      dir.create("results")
    }
    write.table(c(extracted_words), file = paste("results/", first_word, ".txt"), sep = "")
    cat("Report created successfully.")
    dir_return = paste(" Directory: results/", first_word, ".txt", sep = "")
    cat(dir_return)
  }
  cat("\n")
  return(extracted_words)
}


 
eng = readLines("C:/Users/User/Desktop/projekt_krzyzowkowy/dictionaries/english.txt")
eng
find_words("a..l", eng, report = TRUE)