@echo off
title MICRODOS COMMAND LINE
color 07
cd /d "%~dp0"

:microdos
cls
echo MICRODOS COMMAND LINE [Version 25.0.23629.1612]
echo (C) REMIX LASER RISING STUDIO. All rights reserved.
echo.

:microdos2
set "a=x"
set /p a=%cd%^>
set "a=x" & if /i "%a%" equ "x" (
	goto :microdos2
) else if /i "%a%" equ "MICRODOS /?" (
	   goto :microdoshelp
) else if /i "%a%" equ "echo on" (
	echo.
	goto :microdos2
) else if "%a%" equ "ver" (
	echo.
	echo MICRODOS COMMAND LINE [Version 25.0.23629.1612]
	echo.
	goto :microdos2
) else if /i "%a:~0,12%" equ "MICRODOS /YA" (
	 set "file=%a:~13%"
	 if "x%a:~13%" equ "x" (
		set /p "hide=What file you want to hide:"
		set "file=%hide%"
	 )
    attirb +s +h %file%
	 goto :microdos2
) else if /i "%a:~0,12%" equ "MICRODOS /NA" (
    set "file2=%a:~13%"
	 if "x%a:~13%" equ "x" (
		set /p "show=What file you want to show:"
		set "file2=%show%"
	 )
	 attirb -s -h %file2%
	 goto :microdos2
) else if /i "%a:~0,11%" (
    set "file3=%a:~13%"
	 if not exist %file3% (
		set /p "duplicate=Which file do you want to find duplicate lines in:"
		set "file3=%duplicate%"
	 ) else if exist %file3% (cd /d "%~dp0%"
    for /f "delims=" %%i in (%file3%) do (
       if not defined %%i set %%i=s & echo %%i>>output.txt)
    )
    ren "output.txt" "%file3%"
	 goto :microdos2
) else if /i "%a:~0,11%" equ "MICRODOS /D" (
	dir /s /b %a:~11%
	goto :microdos2
) else if /i "%a:~0,11%" equ "MICRODOS /T" (
    set "file4=%a:~12%"
	 if "x%a:~12%" equ "x" (
		set /p "own=Which file do you want to get ownership of:"
		set "file4=%own%"
	 )
    takeown /f %file4% && icacls %file4% /grant Users:F"
	 goto :microdos2
) else if /i "%a:~0,11%" equ "MICRODOS /M" goto :microdos
else echo. & %a%
goto :microdos2

:microdoshelp
echo Convenient advanced command line
echo.
echo MICRODOS [/YA;/NA] [/C] [/D] [/T] [/M]
echo.
echo /A   Hide or show the specified file
echo /C   Find duplicate lines in the specified file
echo /D   Lists the contents of the specified folder
echo /T   Take ownership of the administrator
echo /M   Show the main interface
echo.
pause
echo.
goto :microdos2