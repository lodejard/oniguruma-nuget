SETLOCAL
IF "%BUILD_ARTIFACTSTAGINGDIRECTORY%"=="" SET BUILD_ARTIFACTSTAGINGDIRECTORY=%~dp0bin
IF "%BUILD_SOURCESDIRECTORY%"=="" SET BUILD_SOURCESDIRECTORY=%~dp0

SET ARCH=%1
IF "%ARCH%" == "" SET ARCH=x64
IF "%ARCH%" == "x64" SET MAKE_WIN="%BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\make_win64.bat"
IF "%ARCH%" == "x86" SET MAKE_WIN="%BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\make_win32.bat"

call "C:\Program Files (x86)\Microsoft Visual Studio\2017\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" %ARCH%
mkdir %BUILD_ARTIFACTSTAGINGDIRECTORY%\win-%ARCH%
cd %BUILD_ARTIFACTSTAGINGDIRECTORY%\win-%ARCH%
call %MAKE_WIN% clean
call %MAKE_WIN% all

cd %BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\src
copy %BUILD_SOURCESDIRECTORY%\3rdparty\oniguruma\windows\testc.c .
call %MAKE_WIN% all
call %MAKE_WIN% ctest
call %MAKE_WIN% ptest
call %MAKE_WIN% clean
del testc.c
