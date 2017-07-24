SETLOCAL EnableDelayedExpansion

SET FABRIC_VERSION=%1
SET TARGET=%2
SET FABRIC_LIB_VERSION=%FABRIC_VERSION:~0,3%

SET QT_DIR=C:\External\Qt\4.8.6-x64-msvc2013\
SET CPP2KL_PATH=D:\src\TADevelopment\Cpp2KL\
SET ARNOLD_DIR=C:\External\ArnoldSDK\Windows-4.2.11.0\
SET VECTOR_RENDERER=D:\src\RnD_edgedetect\
SET SHIBOKEN_PYSIDE_DIR=c:\python\Python27-x64\Lib\site-packages\PySide
SET PATH=%PATH%;C:\External\CMake\bin;C:\External\Git\bin

SET TBB_PATH=D:\External\TBB\tbb2017_20160916oss\

call "C:\Program Files\Autodesk\Softimage 2015\Application\bin\setenv.bat"

SET FABRIC_BUILD_OS=Windows
SET FABRIC_BUILD_DIST=Windows
SET FABRIC_BUILD_ARCH=x86_64
IF NOT DEFINED FABRIC_BUILD_TYPE ( 
  SET FABRIC_BUILD_TYPE=Release
)

IF NOT "%FABRIC_VERSION%" == "" (
  IF "%FABRIC_VERSION%" == "Daily" (
    FOR /F "delims=" %%i IN ('dir /b /ad-h /t:c /od C:\External\FabricEngine*') DO SET FABRIC_DIR=%%i
    CALL "C:\External\!FABRIC_DIR!\environment.bat" 
  ) ELSE (
    CALL "C:\External\FabricEngine-%FABRIC_VERSION%-Windows-x86_64\environment.bat"
  )
)
REM ECHO %FABRIC_DIR%
IF DEFINED FABRIC_DIR (
  ECHO *** Using Fabric %FABRIC_VERSION% environment ***
  GOTO :SET_EXTENSIONS
)

REM ////////////////////////////////////////////////////
REM Setup build from source for Fabric

ECHO +++ Setting environment for building from repo +++
SET FABRIC_SCENE_GRAPH_DIR=C:\src\FabricEngine\SceneGraph
SET FABRIC_DIR=%FABRIC_SCENE_GRAPH_DIR%/stage/%FABRIC_BUILD_OS%/%FABRIC_BUILD_ARCH%/%FABRIC_BUILD_TYPE%/

SET FABRIC_EXTS_PATH=%FABRIC_DIR%/Exts
SET FABRIC_DFG_PATH=%FABRIC_DIR%/Presets/DFG;%FABRIC_SCENE_GRAPH_DIR%/Test/Canvas/Presets
 
SET FABRIC_PYTHON_SPHINX_DIR=%FABRIC_SCENE_GRAPH_DIR%/Python/Sphinx
SET PYTHONDONTWRITEBYTECODE=1
SET PYTHON_VERSION=2.7
SET PYTHONPATH=%FABRIC_DIR%/Python/%PYTHON_VERSION%;%FABRIC_PYTHON_SPHINX_DIR%;%PYTHONPATH%
  
SET FABRIC_EXTERNAL_PYTHON_DIR=%FABRIC_SCENE_GRAPH_DIR%/ThirdParty/PreBuilt/%FABRIC_BUILD_OS%/%FABRIC_BUILD_ARCH%/Release/python/%PYTHON_VERSION%

SET PATH=%PATH%;%FABRIC_DIR%/bin;%FABRIC_SCENE_GRAPH_DIR%/ThirdParty/PreBuilt/%FABRIC_BUILD_OS%/%FABRIC_BUILD_ARCH%/%FABRIC_BUILD_TYPE%/bin/llvm-3.3;%QT_DIR%bin

GOTO :SET_EXTENSIONS

REM ////////////////////////////////////////////////////
REM Setup extra extensions for VS
:SET_EXTENSIONS


REM "Add Kraken to path"
REM set KRAKEN_PATH=C:\src\Fabric Engine\Kraken
REM set FABRIC_EXTS_PATH=%FABRIC_EXTS_PATH%;%KRAKEN_PATH%\Exts;
REM set FABRIC_DFG_PATH=%FABRIC_DFG_PATH%;%KRAKEN_PATH%\Presets\DFG;
REM set PYTHONPATH=%PYTHONPATH%;%KRAKEN_PATH%\Python;

CALL "D:\src\TADevelopment\scatter-brained-master\Scatter-brained\environment.bat"
CALL "D:\src\TADevelopment\scatter-brained-master\Scatter-brained-tests\environment.bat"
REM CALL "C:\src\Groove-Jones\environment.bat"

REM "Start in R:"
ECHO "Fabric is setup at %FABRIC_DIR%"
D:
CD D:\src


IF "%2" == "VS2015" (
    GOTO :START_VS2015
)
IF "%2" == "XSI" (
    GOTO :START_XSI
)
IF "%2" == "3dsMax" (
    GOTO :START_MAX
    GOTO :EOF
)
IF "%2" == "Maya" (
    GOTO :START_MAYA
    GOTO :EOF
)
IF "%2" == "Canvas" (
    GOTO :START_CANVAS
    GOTO :EOF
)
IF "%2" == "VSCode" (
    GOTO :START_VSCODE
    GOTO :EOF
)
IF "%2" == "ScatterBrained" (
    GOTO :START_SCATTERB
    GOTO :EOF
)
if "%2" == "Prompt" (
  REM Default to Prompt
  GOTO :START_PROMPT
)
if "%2" == "VSAdskQt" (
  REM Default to Prompt
  GOTO :START_VS_ADSKQT
)
if "%2" == "Prompt2013" (
  REM Default to Prompt
  GOTO :START_PROMPT2013
)
GOTO :EOF

REM ////////////////////////////////////////////////
:START_VS2015
START "" "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
GOTO :EOF

:START_XSI
START "" "C:\Program Files\Autodesk\Softimage 2015\Application\bin\XSI.bat"
GOTO :EOF

:START_MAX
START "" "%FABRIC_DIR%\DCCIntegrations\Fabric3dsmax2017\3dsmax2017.bat"
GOTO :EOF

:START_MAYA
SET MAYA_MODULE_PATH=%FABRIC_DIR%\DCCIntegrations\FabricMaya2017
SET PYTHONHOME=C:\Program Files\Autodesk\Maya2017\Python
START "" "C:\Program Files\Autodesk\Maya2017\bin\maya.exe"
GOTO :EOF

:START_CANVAS
CALL python "%FABRIC_DIR%/bin/canvas.py"
GOTO :EOF

:START_VSCODE
START "" "C:\Program Files (x86)\Microsoft VS Code\Code.exe"
GOTO :EOF

:START_SCATTERB
CALL python "%SCATTERB_ROOT%/apps/clip_viewer/app.py"
GOTO :EOF

:START_PROMPT
CALL %comspec% /k ""c:\Program Files (x86)\Microsoft Visual Studio 14.0\VC\vcvarsall.bat"" amd64
GOTO :EOF

:START_PROMPT2013
CALL %comspec% /k ""c:\Program Files (x86)\Microsoft Visual Studio 12.0\VC\vcvarsall.bat"" amd64
GOTO :EOF

:START_VS_ADSKQT
SET QT_DIR=C:\External\Qt\qt-adsk-4.8.6
GOTO :START_VS2015

:EOF
TIMEOUT /t 3
