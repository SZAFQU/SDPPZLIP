SDPPZLIP - Skrypt PowerShell do pobierania plików z listy i organizowania w folderach






---

📝 Opis

SDPPZLIP.ps1 to zaawansowany skrypt PowerShell służący do pobierania plików z listy URL-i. Automatycznie organizuje pobrane pliki w sezonowych folderach, śledzi postęp i umożliwia wznowienie pobierania. Idealny do zarządzania dużymi zbiorami multimediów.


---

✨ Główne funkcje

📥 Pobieranie plików z listy URL-i (format: Nazwa|Link lub dwuliniowy)

📁 Automatyczne tworzenie folderów w formacie Sezon XX

⚙️ Parametryzacja działania (limit, timeout, plik wejściowy/wyjściowy)

♻️ Wznawianie pobierania z zachowaniem stanu (ukonczone.txt)

⏱ Weryfikacja dostępności URL metodą HEAD

✅ Obsługa -Force, -PominWeryfikacje, -Help

✏️ Logowanie błędów do bledy.log

✨ Kolorowe komunikaty statusowe

⛔ Obsługa zatrzymania (Ctrl + C) bez utraty postępu



---

⚙️ Wymagania

PowerShell 7.1 lub nowszy

System Windows 10, 11 lub Server 2019/2022

Połączenie z internetem



---

🛠 Instalacja

1. Pobierz plik SDPPZLIP.ps1


2. Zapisz w dowolnym folderze


3. Odblokuj:

Unblock-File -Path .\SDPPZLIP.ps1




---

🚀 Użycie

Tryb podstawowy:

.\SDPPZLIP.ps1

Tryb zaawansowany:

.\SDPPZLIP.ps1 -PlikZListy "moja_lista.txt" -GlownyFolder "Wynik" -LimitPobierania 20 -Timeout 60 -Force

Pomoc:

.\SDPPZLIP.ps1 -Help


---

📌 Format listy

Plik lista.txt powinien wyglądać tak:

Film 1|https://adres.pl/plik1.mp4
Film 2
https://adres.pl/plik2.mp4
# komentarze są ignorowane


---

⚙️ Parametry


---

⏸️ Pauzowanie i wznawianie

Możesz zatrzymać pobieranie (Ctrl + C)

Wznowienie nastąpi przy ponownym uruchomieniu

Pliki już pobrane nie zostaną pobrane ponownie (chyba że dodasz -Force)



---

📄 Licencja

Ten projekt objęty jest licencją MIT. Szczegóły w pliku LICENSE.


---

👨‍💻 Autor

SZAFQU – pasjonat PowerShella i automatyzacji.
