
::SET TESTING=YES
SET TESTING=NO
::if %TESTING%==NO (
::echo off
::)

::gdive get from
::https://github.com/prasmussen/gdrive
:: 

SET gdrive=E:\Arhiv\gdrive-windows-x64.exe
SET LOGFILE=E:\Arhiv\gdrive.log

SET PATH_TO_SOURCE_DIR=E:\Arhiv\8\
SET LISTFILE="/tmp/mylist.txt"
SET COUNT_DAY="30" 




SET DateStr=_%date:~6,4%-%date:~3,2%-%date:~0,2%





echo %date% %time%  start upload >>  %LOGFILE%

SET Pref=Zorja-Agro
SET Suf=dt



SET NameOfFile=%Pref%%DateStr%.%Suf%

SET my_ID=0B1aaCP_qcOxoREpQMjEzOXdhUkk


call :upload2googledrive %PATH_TO_SOURCE_DIR%%NameOfFile% %my_ID%



echo %date% %time% finish upload >>  %LOGFILE%

exit


:upload2googledrive
SET my_file=%1
SET my_folder_ID=%2
if exist %my_file% (
%gdrive% upload -p  %my_folder_ID%  %my_file% >> %LOGFILE% 
echo. >>  %LOGFILE%
) else (
echo %date% %time% file %my_file% not exist >> %LOGFILE%
)
exit /b
