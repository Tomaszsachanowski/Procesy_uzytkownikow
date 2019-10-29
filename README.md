# Procesy_uzytkowników
## Treść zadania:
### Proszę napisać skrypt dający możliwość przeglądania listy procesów uruchamianych przez poszczególnych użytkowników. Wybieramy użytkownika z listy a skrypt wyświetla jego procesy. Powinien też pozwalać nawyświetlanie procesów użytkowników nie zalogowanych (np. uruchomione z crontaba), przy czym wskazane jest umożliwienie pominięcia procesów roota. Do stworzenia interfejsu należy użyć modułu Tk lub Tcl::Tk.

## Tests:
1) W pierwszym terminalu nalezy uruchomić skrypt bash `<./tests.sh>`
Uwaga skrypt wymaga praw root'a gdyż tworzy on przykładowego użytkownika systemu `test1_user`, dla którego uruchamiane są dwa procesy `sleep`. Na koniec testu użytkownik ten zostaje usunięty z systemu. 
2) W celu przetestowania czy powyższe procesy są uruchomione nalezy uruchomić w innym terminalu polecenie `<perl main.pl>`
3) Po wyborze odpowiedniego użytkownika `tests1_user` powinny być inforacje o procesach `sleep`. Natomiast dla naszego zalogowanego użytkownika powinny być widoczne procesy `sleep` i `yes`.
## Użycie:
Program uruchamiamy wpisując w komendę `perl main.pl`.
Wyświetli nam się okienko z dwoma częściami prawą (żółtą), gdzie będą wyswietlane inforamcje o processach oraz lewą (cyan) gdzie mamy możliowść wybrania usera, dla którego chcemy sprawdzić procesy, wystarczy tutaj kliknąć na odpowiedni element z listy.

Na samym początku listy są dodane elementy:
* `all_users` - wyświetla procesy dla wszytkich użytkowników w systemie.
* `all_users_without_root` - wyświetla procesy dla wszystkich użytkowników ale bez root'a w systemie.