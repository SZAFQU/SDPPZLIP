# SDPPZLIP - Skrypt do pobierania plików z listy i podpisywania

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
- ♻️ Automatyczne wznawianie pobierania na podstawie `ukonczone.txt`
- ⛔ Obsługa zatrzymywania (`Ctrl + C`) z zachowaniem postępu
- ⚙️ Parametr `-Force` do wymuszenia ponownego pobrania

## 📦 Wymagania

- PowerShell 7.1 lub nowszy
- Windows 10/11 lub Windows Server 2019/2022
- Dostęp do internetu (dla pobierania plików)

## 🛠 Instalacja

1. Pobierz plik skryptu: `SDPPZLIP.ps1`
2. Zapisz w wybranym folderze
3. Odblokuj plik:
   ```powershell
   Unblock-File -Path .\SDPPZLIP.ps1

🚀 Użycie

Podstawowe:

.\SDPPZLIP.ps1

Zaawansowane:

.\SDPPZLIP.ps1 -PlikZListy "moja_lista.txt" -GlownyFolder "MojePliki" -Timeout 60 -LimitPobierania 10 -Force -PominWeryfikacje

Pomoc:

.\SDPPZLIP.ps1 -Help

📌 Przykładowy plik z listą

Film 1|https://...mp4
Film 2|https://...mp4
# komentarz
Film 3
https://...mp4

⚙️ Parametry

⏸️ Pauzowanie i wznawianie

Ctrl + C zatrzymuje pobieranie

Ponowne uruchomienie wznawia od miejsca przerwania

-Force wymusza ponowne pobranie


📄 Licencja

MIT License - LICENSE

👨‍💻 Autor

SZAFQU
