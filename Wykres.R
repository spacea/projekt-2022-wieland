install.packages("ggplot2")
library(ggplot2)
library("stringr")

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

if(file.exists("dictionaries/polish.txt") == FALSE){
  download.file("http://czterycztery.pl/slowo/lista_frekwencyjna_z_odmianami/slowa.txt", "dictionaries/polish.txt")
  words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
}
if(file.exists("dictionaries/polish.txt") == TRUE){
  words_together = readLines("dictionaries/polish.txt", encoding = "UTF-8")
}


PL = words_together

  if(file.exists("dictionaries/english.txt") == FALSE){
    download.file("http://www.gwicks.net/textlists/english3.zip", "dictionaries/english.zip")
    unzip("dictionaries/english.zip", exdir = "dictionaries", overwrite = TRUE)
    file.rename("dictionaries/english3.txt","dictionaries/english.txt")
    file.remove("dictionaries/english.zip")
    words_together = readLines("dictionaries/english.txt", encoding = "UTF-8")
  }
if(file.exists("dictionaries/english.txt") == TRUE){
    words_together = readLines("dictionaries/english.txt", encoding = "UTF-8")
  }

EN = words_together

  if(file.exists("dictionaries/german.txt") == FALSE){
    download.file("http://www.gwicks.net/textlists/deutsch.zip", "dictionaries/german.zip")
    unzip("dictionaries/german.zip", exdir = "dictionaries", overwrite = TRUE)
    file.rename("dictionaries/deutsch.txt", "dictionaries/german.txt")
    file.remove("dictionaries/german.zip")
    words_together = stri_read_lines("dictionaries/german.txt", encoding = "windows-1252")
    words_together = tolower(words_together)
  }
if(file.exists("dictionaries/german.txt") == TRUE){
    words_together = stri_read_lines("dictionaries/german.txt", encoding = "windows-1252")
    words_together = tolower(words_together)
}


GE = words_together
tabela_ze_slowami = data.frame(
  PL = c(wystepowanie_liter(PL)),
  EN = c(wystepowanie_liter(EN)),
  GE = c(wystepowanie_liter(GE)),
  LITERY = c(LETTERS) )
tabela_ze_slowami


hist(tabela_ze_slowami$EN, main="Ilość liter w slowach", xlab="Litery")

ggplot(data = tabela_ze_slowami,aes(LITERY,sPL)) + geom_bar(stat = "identity")


library(tidyr)
data_new = gather(tabela_ze_slowami,"JEZYK", "ILOSC_LITER", PL:GE)
data_new

ggplot(data = data_new,aes(LITERY,ILOSC_LITER)) + geom_bar(stat = "identity",position = "dodge",aes(fill=JEZYK))

