SDPPZLIP - Skrypt do pobierania plików z listy i organizowania w folderach

📝 Opis
SDPPZLIP.ps1 to zaawansowany skrypt PowerShell do pobierania plików z listy URL-i. Automatycznie organizuje pliki w folderach „Sezon X” na podstawie numeru sezonu podanego w nazwie pliku (np. S1, S2) lub zapisuje je bezpośrednio w folderze głównym, jeśli użyto opcji -BezSezonow. Śledzi postęp pobierania, loguje błędy i umożliwia wznawianie.




✨ Główne funkcje

📥 Pobieranie plików z listy URL-i w formacie Nazwa|Link lub dwuliniowym
📁 Elastyczna organizacja:
Domyślnie: tworzy foldery „Sezon X” na podstawie sezonu w nazwie pliku (np. S1 → Sezon 1)
Z opcją -BezSezonow: zapisuje pliki bezpośrednio w folderze głównym


⚙️ Elastyczna konfiguracja poprzez parametry
♻️ Wznawianie pobierania dzięki pliku ukonczone.txt
⏱ Weryfikacja dostępności URL-i metodą HEAD
✅ Obsługa opcji -Force, -PominWeryfikacje, -BezSezonow, -Help
✏️ Logowanie błędów do pliku bledy.log
✨ Kolorowe komunikaty statusowe w konsoli
⛔ Obsługa przerwania (Ctrl+C) z zachowaniem postępu


⚙️ Wymagania

PowerShell 7.1 lub nowszy
System operacyjny: Windows 10, 11, Server 2019 lub 2022
Połączenie z internetem


🛠 Instalacja

Pobierz plik SDPPZLIP.ps1 z repozytorium.

Zapisz go w wybranym folderze.

Odblokuj skrypt, aby umożliwić jego uruchomienie:
Unblock-File -Path .\SDPPZLIP.ps1




🚀 Użycie
Tryb podstawowy
Uruchom skrypt z domyślnymi ustawieniami (tworzy foldery Sezon X):
.\SDPPZLIP.ps1

Tryb bez folderów Sezon X
Zapisz wszystkie pliki bezpośrednio w folderze głównym:
.\SDPPZLIP.ps1 -BezSezonow

Tryb zaawansowany
Dostosuj parametry:
.\SDPPZLIP.ps1 -PlikZListy "moja_lista.txt" -GlownyFolder "Multimedia" -LimitPobierania 20 -Timeout 60 -Force -BezSezonow

Wyświetlenie pomocy
Sprawdź dostępne opcje:
.\SDPPZLIP.ps1 -Help


📌 Format listy
Plik lista.txt powinien zawierać pary nazwa-URL w jednym z dwóch formatów:
Format z separatorem |
S1.E01.Nazwa|https://przyklad.pl/plik1.mp4
S2.E01.Nazwa|https://przyklad.pl/plik2.mp4

Format dwuliniowy
S1.E01.Nazwa
https://przyklad.pl/plik1.mp4
S2.E01.Nazwa
https://przyklad.pl/plik2.mp4

Uwagi:

Nazwa pliku powinna zaczynać się od S<NumerSezonu> (np. S1, S2), jeśli używasz segregacji po sezonach.
Komentarze zaczynające się od # są ignorowane.
Nazwy plików są automatycznie oczyszczane z niedozwolonych znaków.


⚙️ Parametry


Parametr
Opis


-PlikZListy
Plik z listą URL-i (domyślnie: lista.txt)

-GlownyFolder
Główny folder docelowy (domyślnie: Multimedia w bieżącym katalogu)

-PlikLogow
Plik logów błędów (domyślnie: bledy.log)

-PlikUkonczonych
Plik śledzenia ukończonych URL-i (domyślnie: ukonczone.txt)

-LimitPobierania
Maksymalna liczba plików do pobrania (0 = bez limitu)

-Timeout
Timeout dla żądań HEAD/GET w sekundach (domyślnie: 30)

-PominWeryfikacje
Pomija weryfikację dostępności URL-i metodą HEAD

-Force
Wymusza ponowne pobranie wszystkich plików

-BezSezonow
Pomija tworzenie folderów Sezon X, zapisuje pliki w GlownyFolder

-Help
Wyświetla pomoc



⏸️ Pauzowanie i wznawianie

Zatrzymanie: Naciśnij Ctrl+C, aby przerwać pobieranie. Postęp zostanie zapisany w pliku ukonczone.txt.
Wznowienie: Uruchom skrypt ponownie, a pobieranie rozpocznie się od miejsca, w którym zostało przerwane.
Ponowne pobieranie: Użyj opcji -Force, aby pobrać wszystkie pliki od nowa.


📄 Licencja
Projekt objęty jest licencją MIT. Szczegóły w pliku LICENSE.

👨‍💻 Autor
SZAFQU

📋 Uwagi

Skrypt domyślnie rozpoznaje numer sezonu z nazwy pliku (np. S1, S2) i tworzy foldery „Sezon 1”, „Sezon 2” itd., chyba że użyto opcji -BezSezonow.
Z opcją -BezSezonow wszystkie pliki są zapisywane bezpośrednio w folderze określonym przez -GlownyFolder.
Jeśli nazwa pliku nie zawiera numeru sezonu, plik zostanie zapisany w folderze „Sezon 1” z ostrzeżeniem (tylko bez -BezSezonow).
Foldery są tworzone dynamicznie, bez hardkodowanych ścieżek.
Konsola wyświetla tylko kluczowe informacje: nazwę pliku podczas pobierania i potwierdzenie ukończenia.
W przypadku błędów pobierania szczegóły zapisywane są w pliku bledy.log.

