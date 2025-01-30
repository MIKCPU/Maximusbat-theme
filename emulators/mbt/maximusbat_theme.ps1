$logo = @"
  __  __   _   __  _____ __  __ _   _ ___ ___   _ _____    _   _ ___ ___   _ _____ ___ ___ 
 |  \/  | /_\  \ \/ /_ _|  \/  | | | / __| _ ) /_\_   _|__| | | | _ \   \ /_\_   _| __| _ \
 | |\/| |/ _ \  >  < | || |\/| | |_| \__ \ _ \/ _ \| ||___| |_| |  _/ |) / _ \| | | _||   /
 |_|  |_/_/ \_\/_/\_\___|_|  |_|\___/|___/___/_/ \_\_|     \___/|_| |___/_/ \_\_| |___|_|_\
                                                                                           
"@

Write-Host $logo -ForegroundColor Red


$url = "https://github.com/MIKCPU/Maximusbat-theme/archive/refs/heads/main.zip"

$destinationFolder = "R:\retrobat"

$finalFolder = "R:\retrobat"  

$batFile = "R:\retrobat\emulators\mbt\move.bat"

$zipFile = "Maximusbat_theme.zip"

if (-Not (Test-Path $destinationFolder)) {
    New-Item -ItemType Directory -Path $destinationFolder
}

Set-Location -Path $destinationFolder

if (Test-Path $zipFile) {
    Remove-Item -Path $zipFile
    Write-Host "File ZIP esistente rimosso."
}

$zipFilePattern = "$destinationFolder\Maximusbat_theme*.zip"
Get-ChildItem -Path $destinationFolder -Filter "Maximusbat_theme*.zip" | Remove-Item

$aria2Path = "R:\RetroBat\emulators\mbt\aria2\aria2c.exe"

if (Test-Path $zipFile) {
    Write-Host "File esistente trovato, riprendendo il download..."
} else {
    Write-Host "File ZIP non trovato, avviando il download da zero..."
}

& $aria2Path -c --max-connection-per-server=4 --split=4 --out=$zipFile $url

if (Test-Path $zipFile) {
    Expand-Archive -Path $zipFile -DestinationPath $destinationFolder -Force

    Remove-Item -Path $zipFile

    Write-Host "Download e decompressione completati!"


    $fileToDelete1 = "R:\retrobat\maximusbat-theme-main\README.md"
    $fileToDelete2 = "R:\retrobat\maximusbat-theme-main\.gitattributes"

    if (Test-Path $fileToDelete1) {
        Remove-Item -Path $fileToDelete1
        Write-Host "$fileToDelete1 eliminato!"
    }

    if (Test-Path $fileToDelete2) {
        Remove-Item -Path $fileToDelete2
        Write-Host "$fileToDelete2 eliminato!"
    }

} else {
    Write-Host "Errore nel download del file ZIP."
}

Start-Process -FilePath $batFile -Wait
