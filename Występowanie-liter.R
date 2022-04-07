library(stringr)
# x = require("stringr")

words_together = readLines("http://czterycztery.pl/slowo/lista_frekwencyjna_z_odmianami/slowa.txt", encoding = "UTF-8")
words_together

wystepowanie_liter = function(zbior_slow, litera = "all"){
  literki = c(LETTERS)
  literki = tolower(literki)
  liczba_slow = c(0)
  words_together = zbior_slow
  if(litera == "all"){
    for(i in 1:26){
      literka = literki[i]
      wystepowanie = str_count(string = words_together, pattern = literka)
      liczba_slow[i] = sum(wystepowanie)}
  }
  
  else{
    wystepowanie = str_count(string = words_together, pattern = litera)
    liczba_slow = sum(wystepowanie)}
  
  return(liczba_slow)
}

wystepowanie_liter(words_together, litera = "a")
