SET FILENAME=%~n1
CALL :GET_VERSION %FILENAME%
CALL :GET_TARGET %FILENAME%

ECHO %VERSION%
ECHO %TARGET%

CALL %~dp0buildenv.bat %VERSION% %TARGET%

:GET_VERSION
    SET VERSION=%2
    GOTO EOF

:GET_TARGET
    SET TARGET=%4
    GOTO EOF

:EOF
