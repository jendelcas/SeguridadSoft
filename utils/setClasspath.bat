@echo off

rem 
rem Set the classpath
rem -----------------
rem

set KK_WEBAPPS_HOME=%~dp0\..\webapps

set KKADMIN_CLASSPATH=.;"%KK_WEBAPPS_HOME%\konakartadmin\WEB-INF\classes"
set KKADMIN_CLASSPATH=%KKADMIN_CLASSPATH%;"%KK_WEBAPPS_HOME%\konakartadmin\WEB-INF\lib\*"

set KK_CLASSPATH=.;"%KK_WEBAPPS_HOME%\konakart\WEB-INF\classes"
set KK_CLASSPATH=%KK_CLASSPATH%;"%KK_WEBAPPS_HOME%\konakart\WEB-INF\lib\*"

set SERVLET_API_PATH=%~dp0\lib\servlet-api.jar

set KKCMD_CLASSPATH=%KK_CLASSPATH%;%KKADMIN_CLASSPATH%;%SERVLET_API_PATH%
