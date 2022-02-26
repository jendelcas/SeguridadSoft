@echo off

rem ---------------------------------------------------------------------------
rem Service Install/Uninstall script
rem
rem Options
rem install                Install the service using KonaKartService as service name.
rem                        Service is installed using default settings.
rem remove                 Remove the service from the System.
rem
rem name        (optional) If the second argument is present it is considered
rem                        to be new service name
rem ---------------------------------------------------------------------------

setlocal

set "SELF=%~dp0%KonaKartService.bat"
set "BIN_DIR=%cd%"
cd ..
set "KK_HOME=%cd%"
cd %BIN_DIR%

if exist "%BIN_DIR%\KonaKartService.exe" goto okHome
echo KonaKartService.exe was not found...
goto end

:okHome

set "EXECUTABLE=%BIN_DIR%\KonaKartService.exe"

rem Set default Service name
set SERVICE_NAME=KonaKartService
set DISPLAYNAME=KonaKart Service on Tomcat
set PR_DISPLAYNAME=KonaKart - http://www.konakart.com/

if "x%1x" == "xx" goto displayUsage
set SERVICE_CMD=%1
shift
if "x%1x" == "xx" goto checkServiceCmd

set SERVICE_NAME=%1

:checkServiceCmd
if /i %SERVICE_CMD% == install goto doInstall
if /i %SERVICE_CMD% == remove goto doRemove
if /i %SERVICE_CMD% == uninstall goto doRemove
echo Unknown parameter "%SERVICE_CMD%"

:displayUsage
echo.
echo Usage: KonaKartService.bat install/remove [service_name] 
goto end

:doRemove
echo Removing the service '%SERVICE_NAME%' ...

"%EXECUTABLE%" //DS//%SERVICE_NAME% --LogPath "%KK_HOME%\logs"
if not errorlevel 1 goto removed
echo Failed removing '%SERVICE_NAME%' service
goto end

:removed
echo The service '%SERVICE_NAME%' has been removed
goto end

:doInstall
echo Installing the service '%SERVICE_NAME%' ...

set PR_INSTALL=%BIN_DIR%\KonaKartService.exe
set PR_DESCRIPTION=KonaKart Service

REM Service log configuration
set PR_LOGPREFIX=%SERVICE_NAME%
set PR_LOGPATH=%KK_HOME%\logs
set PR_STDOUTPUT=auto
set PR_STDERROR=auto
set PR_LOGLEVEL=Info

REM Path to java installation
set PR_JVM=auto
set PR_CLASSPATH=%BIN_DIR%\classes

REM Startup configuration
set PR_STARTUP=auto
set PR_STARTMODE=jvm
set PR_STARTCLASS=com.dsdata.util.service.KonaKartService
set PR_STARTMETHOD=windowsService
set PR_STARTPARAMS=start;KonaKart;%KK_HOME%

REM Shutdown configuration
set PR_STOPMODE=jvm
set PR_STOPCLASS=com.dsdata.util.service.KonaKartService
set PR_STOPMETHOD=windowsService
set PR_STOPPARAMS=stop;KonaKart;%KK_HOME%

REM JVM configuration
rem set PR_JVMMS=256
rem set PR_JVMMX=1024
rem set PR_JVMSS=4000

"%EXECUTABLE%" //IS//%SERVICE_NAME% 

if not errorlevel 1 goto installed
echo Failed installing '%SERVICE_NAME%' service
goto end

:installed
echo The service '%SERVICE_NAME%' has been installed.

:end
cd "%BIN_DIR%"
