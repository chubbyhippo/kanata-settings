@echo off
kanata.exe --cfg "%USERPROFILE%\wins.kbd" --check
if errorlevel 1 (
    echo wins.kbd failed --check; kanata NOT started. Fix the config and rerun.
    pause
    exit /b 1
)
powershell -NoProfile -WindowStyle Hidden -Command "Start-Process -WindowStyle Hidden -FilePath 'kanata.exe' -ArgumentList '--cfg','%USERPROFILE%\wins.kbd'"
