CALL "C:\Program Files\Microsoft Visual Studio\2022\Enterprise\VC\Auxiliary\Build\vcvarsall.bat" x86

IF EXIST D:\environment\Qt\5.15.2\msvc2019 SET QTDIR=D:\environment\Qt\5.15.2\msvc2019


SET DIR=%~dp0
SET DIR_BUILD=build\x86
SET PATH=%QTDIR%\bin;%PATH%

PUSHD "%DIR%"

CLS

ECHO ############################################################
ECHO #                                                          #
ECHO #                         make.bat                         #
ECHO #                                                          #
ECHO ############################################################

:menu
echo.
echo.
echo     1 - qmake PROJECT
echo     2 - clean
echo     3 - make all
echo     4 - generate pri file
echo     0 - Exit
SET /P MAKE_ACT=Choose an action[1]: 

SET MAKE_ACT_VALID=NO
if "%MAKE_ACT%"=="" (
    SET MAKE_ACT=1
)

if "%MAKE_ACT%"=="1" (
    CALL:qmake
    SET MAKE_ACT_VALID=YES
)

if "%MAKE_ACT%"=="2" (
    CALL:clean
    SET MAKE_ACT_VALID=YES
)

if "%MAKE_ACT%"=="3" (
    CALL:make_all
    SET MAKE_ACT_VALID=YES
)

if "%MAKE_ACT%"=="4" (
    CALL:generate_pri
    SET MAKE_ACT_VALID=YES
)

IF "%MAKE_ACT%"=="0" (
    SET MAKE_ACT_VALID=YES
)

if %MAKE_ACT_VALID%==YES (
    goto return
) else (
    echo Error: action must be 1 2 3 4 0, leave blank is 1.
    goto menu
)


:qmake
CALL:_mkdir %DIR_BUILD%
PUSHD %DIR_BUILD%
qmake -tp vc -r ..\..\all.pro
POPD
GOTO return

:clean
CALL:_rm %DIR_BUILD%
GOTO return

:make_all
if not exist %DIR_BUILD%\all.sln (
    echo "must run qmake first"
)
devenv %DIR_BUILD%\all.sln /Rebuild Debug
devenv %DIR_BUILD%\all.sln /Rebuild Release
GOTO return

:generate_pri
echo.
echo.
python generate_pri.py
GOTO return

:_mkdir
IF NOT EXIST %1 MKDIR %1
GOTO return

:_rm
IF EXIST %1 RMDIR /S /Q %1
GOTO return

:_unlink
IF EXIST %1 DEL /Q /A %1
GOTO return

:return