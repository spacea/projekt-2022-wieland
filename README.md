[![Review Assignment Due Date](https://classroom.github.com/assets/deadline-readme-button-8d59dc4de5201274e310e4c54b9627a8934c3b88527886e3b421487c677d23eb.svg)](https://classroom.github.com/a/6D3hpOQ5)
# projekt-2022-wieland

# 1. Autorzy.

Aleksander Wieland i Tymoteusz Tomala

# 2. Wstęp.

Celem projektu było stworzenie aplikacji interaktywnej ułatwiającej rozwiązywanie krzyżówek oraz pozwalającej na tworzenie diagramów na temat zbiorów słów występujących w trzech językach: polskim, niemieckim i angielskim. Aplikacja znajduje się w pliku app.R. Program w pliku crossword.R ma taką samą funkcjonalność jak aplikacja, jednak wszelka interakcja z programem odbywa się w konsoli.

# 3. Potrzebne pakiety

Do prawidłowego wykonania programów potrzebny jest pakiet "stringi".

# 4. Zakładki w aplikacji (app.R).

Crossword Assistant:

w tej zakładce program pomaga uzytkownikowi w odgadnięciu danego słowa w krzyżówce. Po wybraniu języka, w którym jest odgadywane słowo, należy wpisać w pole tekstowe słowo, które chcemy odgadnąć. W miejsce liter, których użytkownik nie zna, należy wpisać kropki. Wielkość wpisywanych liter nie ma znaczenia. Istnieje również możliwość poszukania słów w pliku `.txt` z komputera użytkownika. Przycisk "Choose a file" pozwala na wyszukanie pliku na swoim komputerze. Wyświetlane są tylko pliki `.txt`. Po wybraniu pliku, ścieżka do niego pokaże się pod przyciskiem. Adres należy skopiowac do pola tekstowego poniżej. Dla pliku wybranego przez użytkownika można wybrać rodzaj enkodowania (domyślnym jest UTF-8). Po wypełnieniu pola tekstowego, po prawej stronie wyświetlą się wszystkie wyrazy, które potencjalnie mogą być odpowiedziami w krzyżówce. Po kliknięciu przycisku "Create a txt. report", w folderze results, który będzie się znajdował w folderze, w którym znajduje się plik app.R, zostanie utworzony plik txt. z wszystkimi otzymanymi wynikami. Nazwą pliku .txt zawsze jest pierwsze słowo, które pasuje do szablonu wpisanego w polu tekstowym. Ścieżka do pliku jest pokazywana pod przyciskiem po jego naciśnięciu.

Statistics:

Program miałby za zadanie przedstawiać użytkownikowi dane informacyjne i statystyczne powiązane z głównym zadaniem aplikacji jakim jest pomoc w odgadnięciu danego słowa w krzyżówce. Użytkownik otrzymywałby informacje w postaci wykresów, które przdstawiałyby dla przykładu ogólną liczbę słów na daną literę występujących w danym języku uprzednio przez nas wybranym. 
# 5. Funkcja

W pliku fndwords.R znajduje się funckja, która pozwala na wydzielenie słów z danego zbioru wyrazów. Chcemy, aby była częścią pakietu, który zostanie stworzony w najbliższym czasie

UŻYCIE

`find_words(write_a_word, dictionary, report = FALSE, to_low = FALSE)`

ARGUMENTY

`write_a_word` - Jako argument należy wpisać słowo, które chcemy odgadnąć. W miejsce liter, które nie są znane, należy wpisać kropki.

`dictionary` - Jako argument należy podać obiekt, który jest wektorem, w którym znajdują się słowa.

`report` - Wartość TRUE oznacza, że do pliku txt. zostanie zapisany wynik funkcji. Ponadto utworzony zostanie folder results, w którym umieszczane będą wszystkie wyniki.

`to_low` - Wartość TRUE sprawia, że wszystkie wielkie litery w wektorze dictionary zostaną zamienione na małe. Ten argument przydaje się m.in. w przypadku słów niemieckich, ponieważ rzeczowniki w tym języku są rozpoczęte wielkimi literami. Niewykorzystanie tego argumentu może doprowadzić do otrzymania niepełnych wyników.

PRZYKŁADY

`find_words(".orld", words, report = TRUE)`
