# Imposta la URL del file ZIP su GitHub
$url = "https://github.com/MIKCPU/Maximusbat-theme/archive/refs/heads/main.zip"

# Imposta la cartella in cui vuoi decomprimere il file
$destinationFolder = "R:\retrobat"
$batFile = "R:\retrobat\emulators\mbt\maximusbat_theme.bat" # Sostituisci con il tuo file BAT

# Imposta il nome del file ZIP
$zipFile = "Maximusbat_theme.zip"

# Verifica se la cartella di destinazione esiste, altrimenti creala
if (-Not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}# Directory di lavoro
Set-Location -Path $destinationFolder

# Scarica il file ZIP
Invoke-WebRequest -Uri $url -OutFile $zipFile

# Verifica se il download è avvenuto correttamente
if (Test-Path $zipFile) {
    # Decomprimi il file ZIP
    Expand-Archive -Path $zipFile -DestinationPath $destinationFolder -Force

    # Rimuovi il file ZIP dopo la decompressione
    Remove-Item -Path $zipFile

    Write-Host "Download e decompressione completati!"
} else {
    Write-Host "Errore nel download del file ZIP."
}
# Esegui il file BAT
Start-Process -FilePath $batFile