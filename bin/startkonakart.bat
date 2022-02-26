
rem ================
rem  Start KonaKart
rem ================

set KK_TOMCAT_BIN=%~dp0

set CATALINA_HOME=%KK_TOMCAT_BIN%/..
set CATALINA_BASE=%KK_TOMCAT_BIN%/..

set CATALINA_OPTS=-Xmx1400m -server -Dsolr.solr.home="%CATALINA_HOME%/solr" -Djava.awt.headless=true -Dactivemq.store.dir="%CATALINA_HOME%/mq" -Dkk.log4j.debug=true -XX:-OmitStackTraceInFastThrow

call "%KK_TOMCAT_BIN%/setJavaHome.bat"

echo Find out the version of Java

if not exist "%JRE_HOME%/bin/java.exe" (
	echo JRE_HOME not set correctly - Could not locate "%JRE_HOME%/bin/java.exe"
)

for /f tokens^=2-5^ delims^=.-_^" %%j in ('"%JRE_HOME%/bin/java" -fullversion 2^>^&1') do (
	set "jver=%%j%%k%%l%%m"
)

echo Java Version %jver%

rem echo %jver%|findstr "^9" >nul
rem if %errorlevel% == 0 (
rem 	echo Java 9 so we add the java.se.ee modules
rem	SET CATALINA_OPTS=%CATALINA_OPTS% --add-modules java.se.ee
rem )

rem echo Java Version %jver%
rem echo %jver%|findstr "^10" >nul
rem if %errorlevel% == 0 (
rem	echo Java 10 so we add the java.se.ee modules
rem	SET CATALINA_OPTS=%CATALINA_OPTS% --add-modules java.se.ee
rem )

echo %jver%|findstr "^17" >nul
if %errorlevel% == 0 (
	echo WARNING: Java 7 not supported
	SET CATALINA_OPTS=%CATALINA_OPTS% -XX:PermSize=256m -XX:MaxPermSize=256m
)

rem Disabling Endpoint Identificaton - You shouldn't do this in production systems
rem SET CATALINA_OPTS=%CATALINA_OPTS% -Dcom.sun.jndi.ldap.object.disableEndpointIdentification=true

rem SSL Protocols TLS 1.2
rem If using Java 7 and using a Payment Gateway that requires TLS 1.2 you will probably need to add these to CATALINA_OPTS or JAVA_OPTS:
rem -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2"  -Dhttps.protocols="TLSv1,TLSv1.1,TLSv1.2"

rem Logging debug options:
rem for debugging log4j                                 add:  -Dlog4j.debug=true
rem for debugging kklog4j                               add:  -Dkk.log4j.debug=true
rem for specifying a log configuration for KonaKart     add:  -Dkk.log4j.configuration=konakart-logging.xml

rem Logging java.net traffic
rem -Djavax.net.debug=all

rem Logging JAXWS processing:
rem -Dcom.sun.xml.ws.transport.http.client.HttpTransportPipe.dump=true -Dcom.sun.metro.soap.dump=true

if not exist "%CATALINA_HOME%/temp" mkdir %CATALINA_HOME%/temp

rem These JAVA_OPTS (or similar) can used when running the Java Message Queue Web Console 
rem set JAVA_OPTS=-Dwebconsole.type=properties -Dwebconsole.jms.url=tcp://localhost:8791 -Dwebconsole.jmx.url=service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi -Dwebconsole.jmx.user= -Dwebconsole.jmx.password=

rem Start Solr
echo Start Solr
cmd /c "%CATALINA_HOME%/solr/bin/solr.cmd" start -p 8983
echo. 

rem Start Tomcat
echo Start KonaKart
call "%KK_TOMCAT_BIN%/startup.bat"

