SDPPZLIP - Skrypt Do Pobierania Plików Z Listy I Podpisywaniem

📝 Opis
SDPPZLIP.ps1 to zaawansowany skrypt PowerShell do pobierania plików z listy URL-i. Automatycznie organizuje pliki w folderach „Sezon X” na podstawie numeru sezonu podanego w nazwie pliku (np. S1, S2), śledzi postęp pobierania i umożliwia jego wznawianie. Idealny do zarządzania dużymi zbiorami multimediów, takich jak filmy czy podcasty.

✨ Główne funkcje

📥 Pobieranie plików z listy URL-i w formacie Nazwa|Link lub dwuliniowym
📁 Automatyczne tworzenie folderów w formacie „Sezon X” na podstawie sezonu w nazwie pliku (np. S1 →/ S2 itd.)
⚙️ Elastyczna konfiguracja poprzez parametry (limit pobierania, timeout, pliki wejściowe/wyjściowe)
♻️ Wznawianie pobierania dzięki śledzeniu stanu w pliku ukonczone.txt
⏱ Weryfikacja dostępności URL-i metodą HEAD
✅ Obsługa opcji -Force, -PominWeryfikacje, -Help
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
Uruchom skrypt z domyślnymi ustawieniami:
.\SDPPZLIP.ps1

Tryb zaawansowany
Dostosuj parametry do swoich potrzeb:
.\SDPPZLIP.ps1 -PlikZListy "moja_lista.txt" -GlownyFolder "Wynik" -LimitPobierania 20 -Timeout 60 -Force

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

Nazwa pliku powinna zaczynać się od S<NumerSezonu> (np. S1, S2), aby poprawnie rozpoznać sezon.
Komentarze zaczynające się od # są ignorowane.
Nazwy plików są automatycznie oczyszczane z niedozwolonych znaków.


⚙️ Parametry



Parametr
Opis


-PlikZListy
Plik z listą URL-i (domyślnie: lista.txt)

-GlownyFolder
Główny folder docelowy (domyślnie: Pobrane)

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

-Help
Wyświetla pomoc



⏸️ Pauzowanie i wznawianie

Zatrzymanie: Naciśnij Ctrl+C, aby przerwać pobieranie. Postęp zostanie zapisany w pliku ukonczone.txt.
Wznowienie: Uruchom skrypt ponownie, a pobieranie rozpocznie się od miejsca, w którym zostało przerwane.
Ponowne pobieranie: Użyj opcji -Force, aby pobrać wszystkie pliki od nowa, ignorując stan w ukonczone.txt.


📄 Licencja
Projekt objęty jest licencją MIT. Szczegóły w pliku LICENSE.

👨‍💻 Autor
SZAFQU

📋 Uwagi

Skrypt rozpoznaje numer sezonu z nazwy pliku (np. S1, S2) i tworzy foldery „Sezon 1”, „Sezon 2” itd.
Jeśli nazwa pliku nie zawiera numeru sezonu, plik zostanie zapisany w folderze „Sezon 1” z ostrzeżeniem.
W przypadku błędów pobierania szczegóły zapisywane są w pliku bledy.log.
Aby uzyskać najlepsze rezultaty, upewnij się, że lista URL-i jest poprawna i dostępna.
