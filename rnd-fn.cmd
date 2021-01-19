@echo off

set param1=1
set param2=2

call :fn1 %param1%, %param2%

exit /B %ERRORLEVEL%

:fn1
    echo fn1:param1=%~1
    echo fn2:param2=%~2
exit /B 0

