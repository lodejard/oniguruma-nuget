SETLOCAL
IF "%BUILD_ARTIFACTSTAGINGDIRECTORY%"=="" SET BUILD_ARTIFACTSTAGINGDIRECTORY=%~dp0bin
IF "%BUILD_SOURCESDIRECTORY%"=="" SET BUILD_SOURCESDIRECTORY=%~dp0

SET ARCH=%1
IF "%ARCH%" == "" SET ARCH=x64
IF "%ARCH%" == "x64" SET MAKE_WIN="%BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\make_win64.bat"
IF "%ARCH%" == "x86" SET MAKE_WIN="%BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\make_win32.bat"

CALL "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" %ARCH%
if %errorlevel% neq 0 exit /b %errorlevel%

IF NOT EXIST "%BUILD_ARTIFACTSTAGINGDIRECTORY%\win-%ARCH%" (
    mkdir %BUILD_ARTIFACTSTAGINGDIRECTORY%\win-%ARCH%
    if %errorlevel% neq 0 exit /b %errorlevel%
)

cd %BUILD_ARTIFACTSTAGINGDIRECTORY%\win-%ARCH%
if %errorlevel% neq 0 exit /b %errorlevel%

CALL %MAKE_WIN% clean
if %errorlevel% neq 0 exit /b %errorlevel%

CALL %MAKE_WIN% all
if %errorlevel% neq 0 exit /b %errorlevel%

cd %BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\src
if %errorlevel% neq 0 exit /b %errorlevel%

copy %BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\windows\testc.c .
if %errorlevel% neq 0 exit /b %errorlevel%

CALL %MAKE_WIN% all
if %errorlevel% neq 0 exit /b %errorlevel%

CALL %MAKE_WIN% ctest
if %errorlevel% neq 0 exit /b %errorlevel%

CALL %MAKE_WIN% ptest
if %errorlevel% neq 0 exit /b %errorlevel%

CALL %MAKE_WIN% clean
if %errorlevel% neq 0 exit /b %errorlevel%

del testc.c
if %errorlevel% neq 0 exit /b %errorlevel%
