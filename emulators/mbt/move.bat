@echo off
color 0A

echo.
echo   M   M  AAAAA X   X III M   M U   U SSSS  B B B AAAAA TTTTT
echo   MM MM  A   A X   X  I  MM MM U   U S     B   B A   A   T  
echo   M M M  AAAAA X X X  I  M M M U   U  SSS  BBBBB AAAAA   T  
echo   M   M  A   A X   X  I  M   M U   U     S B   B A   A   T  
echo   M   M  A   A X   X III M   M UUUUU SSSS  B B B A   A   T  
echo.

@echo off
echo Spostando i file da 'R:\retrobat\maximusbat-theme-main' a 'R:\retrobat'...
echo I move files from 'R:\retrobat\maximusbat-theme-main' to 'R:\retrobat'...

echo.

set sourceFolder=R:\retrobat\maximusbat-theme-main
set destinationFolder=R:\retrobat

if not exist "%sourceFolder%" (
    echo La cartella di origine '%sourceFolder%' non esiste!
    echo The source folder '%sourceFolder%' does not exist!
  
    pause
    exit /b
)

echo Spostando i file e le cartelle...
echo Moving the files and the folders...
xcopy "%sourceFolder%\*" "%destinationFolder%" /E /H /C /Y

if errorlevel 1 (
    echo Si è verificato un errore durante lo spostamento dei file!
    echo An error occurred while moving files!

) else (
    echo File e cartelle spostati con successo!
    echo Files and folders moved successfully!
)

rd /S /Q "%sourceFolder%"

echo Operazione completata!
echo Operation Complete!

pause
