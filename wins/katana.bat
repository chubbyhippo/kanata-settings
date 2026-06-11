@echo off
powershell -NoProfile -WindowStyle Hidden -Command "Start-Process -WindowStyle Hidden -FilePath 'kanata.exe' -ArgumentList '--cfg','%USERPROFILE%\wins.kbd'"
