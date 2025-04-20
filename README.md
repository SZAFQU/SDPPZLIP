# SDPZLIP - Skrypt do pobierania plików z listy

![PowerShell](https://img.shields.io/badge/PowerShell-7.1+-blue.svg)
![Windows](https://img.shields.io/badge/Windows-11%20|%20Server%202022-supported-green.svg)
![License](https://img.shields.io/badge/License-MIT-yellow.svg)

## 📝 Opis

Zaawansowany skrypt PowerShell do pobierania plików z listy URL-i, organizujący je w folderach według sezonów z pełną obsługą logowania błędów i śledzeniem postępu.

## ✨ Funkcje

- 📂 Pobieranie plików z listy URL-i
- 🗂 Automatyczne organizowanie w folderach "Sezon X"
- 📝 Logowanie błędów i operacji
- ⏱ Konfigurowalny timeout połączeń
- 🔍 Weryfikacja URL przed pobraniem
- 🚀 Optymalizacja dla PowerShell 7.1+ i Windows 11
- 📊 Śledzenie postępu i statystyki

## 📦 Wymagania

- PowerShell 7.1 lub nowszy
- Windows 10/11 lub Windows Server 2019/2022
- Dostęp do internetu (dla pobierania plików)

## 🛠 Instalacja

1. Pobierz plik skryptu: `SDPPZLIP.ps1`
2. Zapisz w wybranym folderze
3. Dla bezpieczeństwa wykonaj komendę:
   Unblock-File -Path .\SDPPZLIP.ps1

## 🚀 Użycie

### Podstawowe użycie:
.\SDPPZLIP.ps1


### Zaawansowane opcje:

.\SDPPZLIP.ps1 -PlikZListy "moja_lista.txt" -GlownyFolder "MojePliki" -Timeout 60 -LimitPobierania 10


### Wyświetlenie pomocy:
.\SDPPZLIP.ps1 -Help


## 📌 Przykładowy plik z listą

Nazwa pliku 1|https://example.com/file1.mp4
Nazwa pliku 2|https://example.com/file2.mp4
# To jest komentarz - zostanie pominięty
Nazwa pliku 3
https://example.com/file3.mp4

## ⚙️ Parametry

| Parametr           | Opis                                  | Domyślnie     |
|--------------------|---------------------------------------|---------------|
| `-PlikZListy`      | Ścieżka do pliku z listą URL-i        | `lista.txt`   |
| `-GlownyFolder`    | Główny folder docelowy                | `Pobrane`     |
| `-PlikLogow`       | Plik logów błędów                     | `bledy.log`   |
| `-PlikUkonczonych` | Plik śledzenia pobranych plików       | `ukonczone.txt` |
| `-LimitPobierania` | Maks. liczba plików do pobrania (0=∞) | `0`           |
| `-Timeout`         | Czas oczekiwania na odpowiedź (s)     | `30`          |
| `-PominWeryfikacje`| Pomija weryfikację URL                | `$false`      |
| `-Force`           | Wymusza wykonanie (nadpisuje pliki)   | `$false`      |
| `-Help`            | Wyświetla pomoc                       | `$false`      |

## 📄 Licencja

MIT License - [LICENSE](LICENSE)

## 👨‍💻 Autor

**SZAFQU** - [Kontakt](mailto:twój@email.com)


Oto instrukcja jak prawidłowo włączyć i uruchomić skrypt **SDPPZLIP.ps1** w systemie Windows:

---

## 🚀 **Jak uruchomić skrypt - krok po kroku**

### 1. **Przygotowanie PowerShell**
Najpierw należy zmienić politykę wykonania skryptów:

Set-ExecutionPolicy RemoteSigned -Scope CurrentUser

> 💡 *To pozwoli uruchamiać lokalne skrypty (wymagane tylko raz)*


### 2. **Otwórz terminal PowerShell 7**
- Naciśnij `Win + R`
- Wpisz `pwsh` i kliknij OK
- Lub użyj **Windows Terminal** (zalecane)


### 3. **Przejdź do folderu ze skryptem**
cd C:\ścieżka\do\folderu\ze\skryptem

🔍 *Sprawdź zawartość folderu komendą  dir


### 4. **Odblokuj skrypt (tylko przy pierwszym uruchomieniu)**
Unblock-File -Path .\SDPPZLIP.ps1


### 5. **Podstawowe uruchomienie**
.\SDPPZLIP.ps1
Skrypt użyje domyślnych ustawień:
- Szuka pliku `lista.txt`
- Zapisuje pliki w folderze `Pobrane`


### 6. **Zaawansowane uruchomienie z parametrami**
Przykład z własnymi ustawieniami:
.\SDPPZLIP.ps1 -PlikZListy "moje_url.txt" -GlownyFolder "Filmy" -Timeout 60 -LimitPobierania 5


### 7. **Pomoc techniczna**
Aby wyświetlić wszystkie opcje:
.\SDPPZLIP.ps1 -Help



## 🛠 **Rozwiązywanie problemów**

### 🔴 **Błąd: "Nie można załadować pliku...**
.\SDPPZLIP.ps1 : Nie można załadować pliku [...], ponieważ wykonywanie skryptów jest wyłączone...
**Rozwiązanie:** Wykonaj ponownie krok 1 (zmiana polityki wykonania)

### 🔴 **Brak PowerShell 7**
**Rozwiązanie:** Pobierz najnowszą wersję z:
winget install --id Microsoft.PowerShell --source winget


### 🔴 **Problem z kodowaniem znaków**
Jeśli występują problemy z polskimi znakami:
[Console]::OutputEncoding = [System.Text.Encoding]::UTF8


## 📌 **Przykładowa sesja**
PS C:\> cd C:\Pobrane\Skrypty
PS C:\Pobrane\Skrypty> .\SDPPZLIP.ps1 -PlikZListy "seriale.txt" -Timeout 120

[1/10] Weryfikuję: Odcinek_1.mp4 (Timeout: 120s)
[1/10] Pobieranie (1/5): Odcinek_1.mp4 (Timeout: 120s)
Pobrano: Odcinek_1.mp4



## 💡 **Dodatkowe wskazówki**
1. Dla dużych plików zwiększ parametr `-Timeout` (np. do 300 sekund)
2. Użyj `-Force`, aby nadpisać istniejące pliki
3. Monitoruj postęp w plikach `bledy.log` i `ukonczone.txt`


