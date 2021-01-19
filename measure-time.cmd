@echo off
set BLUE=[104m [104m
set CYAN=[96m [96m
set RED=[91m [91m
set GREEN=[92m [92m
set YELLOW=[93m [93m
set WHITE=[97m [97m
set NC=[0m

echo "%BLUE%[R&D] Measure time exmaple%NC%"

set startTime=%time%
pause
set endTime=%time%

call :timeDiff %startTime%, %endTime%, duration

echo duration=%duration%s

exit /B %ERRORLEVEL%

:timeDiff
    set startTime=%~1
    set endTime=%~2
    echo "timeDiff:startTime=%startTime%"
    echo "timeDiff:endTime=%endTime%"

    rem convert startTime and endTime to centiseconds
    set /A startTime=(1%startTime:~0,2%-100)*360000 + (1%startTime:~3,2%-100)*6000 + (1%startTime:~6,2%-100)*100 + (1%startTime:~9,2%-100)
    set /A endTime=(1%endTime:~0,2%-100)*360000 + (1%endTime:~3,2%-100)*6000 + (1%endTime:~6,2%-100)*100 + (1%endTime:~9,2%-100)
    echo "timeDiff:startTime=%startTime%"
    echo "timeDiff:endTime=%endTime%"

    rem calculating the duration is easy
    set /A duration=(%endTime%-%startTime%)/100
    echo "timeDiff:duration=%duration%"
    set %~3=%duration%
exit /B 0

