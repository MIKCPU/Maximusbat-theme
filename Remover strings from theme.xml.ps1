# Ottieni la cartella in cui si trova lo script
$rootPath = Split-Path -Parent $MyInvocation.MyCommand.Definition

# Le stringhe da rimuovere
$stringsToRemove = @(
    "<pos>0.95 0.8</pos>",
    "<origin>1 0</origin>",
    "<size>0.90 0.1</size>",
    "<backgroundColor>00000000</backgroundColor>",
    "<color>F5F5F5</color>",
    "\$\{themePath\}/_inc/fonts/SF Slapstick Comic Bold\.ttf", # <- fix qui
    "<fontSize>0.055</fontSize>"
)

# Trova tutti i file theme.xml nelle sottocartelle, ma ignora:
# 1) la cartella principale
# 2) le sottocartelle .loading e _inc direttamente sotto la cartella principale
$files = Get-ChildItem -Path $rootPath -Filter "theme.xml" -Recurse |
         Where-Object {
            $dir = $_.DirectoryName
            # Non nella cartella principale
            $dir -ne $rootPath -and
            # Non in .loading o _inc direttamente sotto rootPath
            -not ($dir -like "$rootPath\.loading*") -and
            -not ($dir -like "$rootPath\_inc*")
         }

foreach ($file in $files) {
    # Legge il contenuto
    $content = Get-Content $file.FullName

    # Rimuove le righe contenenti le stringhe da cancellare
    foreach ($pattern in $stringsToRemove) {
        # Usa regex match per eliminare la riga
        $content = $content | Where-Object { $_ -notmatch $pattern }
    }

    # Rimuove righe vuote
    $content = $content | Where-Object { $_.Trim() -ne "" }

    # Sovrascrive il file originale
    Set-Content -Path $file.FullName -Value $content
}

Write-Host "Cancellazione completata! Tutti i theme.xml nelle sottocartelle valide aggiornati."
Pause
