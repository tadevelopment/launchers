ECHO OFF
call "D:\External\FabricEngine-2.3.0-Windows-x86_64\environment.bat"
CALL buildenv.bat

set KRAKEN_PATH=C:\src\Fabric Engine\Kraken
set FABRIC_EXTS_PATH=%FABRIC_EXTS_PATH%;%KRAKEN_PATH%\Exts;
set FABRIC_DFG_PATH=%FABRIC_DFG_PATH%;%KRAKEN_PATH%\Presets\DFG;
set PYTHONPATH=%PYTHONPATH%;%KRAKEN_PATH%\Python;

start "" "C:\Program Files (x86)\Microsoft Visual Studio 14.0\Common7\IDE\devenv.exe"
timeout /t 3