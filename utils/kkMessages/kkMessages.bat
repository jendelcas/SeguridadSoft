@echo off

rem
rem Add arguments to pass to the utility on the command line
rem 
rem eg:   -i Messages_de.propertiesa -l de_DE -t 1 -u admin@konakart.com -p princess -e 2 -c -s store1
rem
rem NOTE: The arguments used here are just an example.  You may be able to leave some out and
rem       assume default values in your environment.
rem
rem       Use the argument "-?" to get usage information on the utility.
rem
rem NOTE: Convert properties files to ISO8859-1 format before importing (use a tool such as native2ascii
rem       to convert a UTF-8 version of your properties file).

call ..\setClasspath.bat

echo ======================================================================================================
echo KonaKart Messages Utility
echo ======================================================================================================

"%JAVA_HOME%/bin/java" -cp %KKADMIN_CLASSPATH% com.konakartadmin.utils.KKMessages %*
