<#
.SYNOPSIS
    SDPPZLIP – Skrypt do pobierania plików z listy i organizowania w folderach
.DESCRIPTION
    SDPPZLIP to zaawansowany skrypt PowerShell do pobierania plików z listy URL-i.
    Organizuje pliki w folderach „Sezon X” na podstawie numeru sezonu w nazwie pliku
    (np. S1, S2) lub zapisuje bezpośrednio w folderze głównym, jeśli użyto opcji -BezSezonow.
    Loguje błędy, śledzi postęp i umożliwia wznawianie pobierania.
.VERSION
    2.3.12
.AUTHOR
    SZAFQU
.LICENSE
    MIT
.NOTES
    Wymaga PowerShell 7.1 lub nowszego oraz połączenia z internetem.
#>
#requires -Version 7.1

param (
    [string]$PlikZListy       = "lista.txt",
    [string]$GlownyFolder     = "Multimedia",
    [string]$PlikLogow        = "bledy.log",
    [string]$PlikUkonczonych  = "ukonczone.txt",
    [int]   $LimitPobierania  = 0,
    [int]   $Timeout          = 30,
    [switch]$PominWeryfikacje,
    [switch]$Force,
    [switch]$BezSezonow,
    [switch]$Help
)

if ($Help) {
    Write-Host "UŻYCIE: .\SDPPZLIP.ps1 [opcje]" -ForegroundColor Cyan
    Write-Host "OPIS: Pobiera pliki z listy URL-i i organizuje je w folderach Sezon X lub bezpośrednio w folderze głównym."
    Write-Host "PARAMETRY:" -ForegroundColor Cyan
    Write-Host "  -PlikZListy       Plik z URL-ami (domyślnie: lista.txt)"
    Write-Host "  -GlownyFolder     Główny folder docelowy (domyślnie: Multimedia)"
    Write-Host "  -PlikLogow        Plik logów błędów (domyślnie: bledy.log)"
    Write-Host "  -PlikUkonczonych  Plik śledzenia ukończonych URL-i (domyślnie: ukonczone.txt)"
    Write-Host "  -LimitPobierania  Maksymalna liczba plików do pobrania (0 = bez limitu)"
    Write-Host "  -Timeout          Timeout dla żądań HEAD/GET w sekundach (domyślnie: 30)"
    Write-Host "  -PominWeryfikacje Pomija weryfikację dostępności URL metodą HEAD"
    Write-Host "  -Force            Wymusza ponowne pobranie wszystkich plików"
    Write-Host "  -BezSezonow       Pomija tworzenie folderów Sezon X, zapisuje pliki w GlownyFolder"
    Write-Host "  -Help             Wyświetla pomoc"
    Write-Host "PRZYKŁAD: .\SDPPZLIP.ps1 -PlikZListy moja_lista.txt -GlownyFolder Multimedia -BezSezonow -Force"
    exit
}

$ErrorActionPreference = 'Stop'

# Utwórz główny folder
if (-not ([IO.Path]::IsPathRooted($GlownyFolder))) {
    $GlownyFolder = Join-Path $PWD $GlownyFolder
}
if (-not (Test-Path $GlownyFolder)) {
    New-Item -ItemType Directory -Path $GlownyFolder -Force | Out-Null
}

# Funkcja do bezpiecznych nazw plików
function Get-SafeName {
    param([string]$Name)
    $invalid = [IO.Path]::GetInvalidFileNameChars() | ForEach-Object { [regex]::Escape($_) }
    $pattern = '[' + ($invalid -join '') + ']'
    return ($Name -replace $pattern, '').Trim()
}

# Wczytaj ukończone URL-i
$ukonczone = @()
if (Test-Path $PlikUkonczonych) {
    $ukonczone = Get-Content $PlikUkonczonych | ForEach-Object { $_.Trim() } | Where-Object { $_ }
}

# Wczytaj i przefiltruj wejście
if (-not (Test-Path $PlikZListy)) {
    Write-Host "Brak pliku listy: $PlikZListy" -ForegroundColor Red
    exit 1
}
$raw  = Get-Content $PlikZListy
$lines = $raw | Where-Object { $_.Trim() -and -not $_.TrimStart().StartsWith('#') }

# Parsuj pary: linia z '|' lub dwuliniowo
$pairs = @()
for ($i = 0; $i -lt $lines.Count; ) {
    $l = $lines[$i].Trim()
    if ($l -match '\|') {
        $parts = $l -split '\|',2
        $name = $parts[0].Trim()
        $url  = $parts[1].Trim()
        $i++
    }
    elseif ($i + 1 -lt $lines.Count) {
        $name = $l
        $url  = $lines[$i+1].Trim()
        $i += 2
    }
    else {
        Write-Host "OSTRZEŻENIE: Pomijam niekompletną linijkę: $l" -ForegroundColor Yellow
        break
    }
    $pairs += [PSCustomObject]@{ Name = $name; Url = $url }
}

$total   = $pairs.Count
$downloaded = 0
$index   = 0
$logs    = @()

# Obsługa przerwania (Ctrl+C)
trap {
    Write-Host "`nPrzerwano pobieranie. Postęp zapisano w $PlikUkonczonych." -ForegroundColor Yellow
    if ($logs.Count -gt 0) {
        $logs | Out-File -FilePath $PlikLogow -Encoding UTF8 -Append
        Write-Host "Zapisano błędy w: $PlikLogow" -ForegroundColor Yellow
    }
    Write-Host "Aby wznowić, uruchom skrypt ponownie." -ForegroundColor Cyan
    exit
}

foreach ($item in $pairs) {
    if ($LimitPobierania -gt 0 -and $downloaded -ge $LimitPobierania) { break }
    $index++
    $name = $item.Name
    $url  = $item.Url

    # Walidacja URL
    if (-not [URI]::IsWellFormedUriString($url, [URIKind]::Absolute)) {
        Write-Host "[$index/$total] Niepoprawny URL: $url" -ForegroundColor Red
        $logs += "[{0}] Niepoprawny URL: {1}" -f (Get-Date -Format 'yyyy/MM/dd HH:mm:ss'), $url
        continue
    }

    if ($ukonczone -contains $url -and -not $Force) {
        Write-Host "[$index/$total] Pominięto plik (już pobrany): $name" -ForegroundColor Yellow
        continue
    }

    # Przygotowanie folderu docelowego
    if ($BezSezonow) {
        $destDir = $GlownyFolder
    }
    else {
        # Parsowanie numeru sezonu z nazwy pliku
        if ($name -match '^S(\d+)\.') {
            $seasonNum = [int]$Matches[1]
        }
        else {
            Write-Host "[$index/$total] OSTRZEŻENIE: Nie można rozpoznać sezonu w nazwie: $name. Używam Sezon 1." -ForegroundColor Yellow
            $seasonNum = 1
        }
        $destDir = Join-Path $GlownyFolder "Sezon $seasonNum"
        if (-not (Test-Path $destDir)) {
            New-Item -ItemType Directory -Path $destDir -Force | Out-Null
        }
    }

    # Przygotowanie nazwy pliku
    $ext = [IO.Path]::GetExtension($url)
    if (-not $ext -or $ext.Length -gt 5) { $ext = '.mp4' }
    $safe  = Get-SafeName $name
    $file  = "$safe$ext"
    $dest  = Join-Path $destDir $file

    Write-Host "[$index/$total] Pobieram: $file" -ForegroundColor Cyan

    try {
        if (-not $PominWeryfikacje) {
            $req = [Net.WebRequest]::Create($url)
            $req.Method  = 'HEAD'
            $req.Timeout = $Timeout * 1000
            $res = $req.GetResponse(); $res.Close()
        }
        Invoke-WebRequest -Uri $url -OutFile $dest -TimeoutSec $Timeout -ErrorAction Stop
        Add-Content -Path $PlikUkonczonych -Value $url
        $downloaded++
        Write-Host "    ✓ Ukończono: $file" -ForegroundColor Green
    }
    catch {
        Write-Host "[$index/$total] Błąd pobierania: $file" -ForegroundColor Red
        $logs += "[{0}] Błąd pobierania: {1} -- {2}" -f (Get-Date -Format 'yyyy/MM/dd HH:mm:ss'), $url, $_.Exception.Message
    }
}

# Zapis logów błędów
if ($logs.Count -gt 0) {
    $logs | Out-File -FilePath $PlikLogow -Encoding UTF8 -Append
    Write-Host "`nZapisano błędy w: $PlikLogow" -ForegroundColor Yellow
}

Write-Host "`n=== Podsumowanie ===" -ForegroundColor Cyan
Write-Host "Z listy: $total, pobranych: $downloaded" -ForegroundColor Green
Write-Host "Folder wynikowy: $GlownyFolder" -ForegroundColor Cyan