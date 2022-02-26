#!/bin/sh
# ================
#  Start KonaKart
# ================

HERE=`pwd`

# figure out where the home is - $0 may be a softlink

PRG="$0"

while [ -h "$PRG" ] ; do
  ls=`ls -ld "$PRG"`
  link=`expr "$ls" : '.*-> \(.*\)$'`
  if expr "$link" : '/.*' > /dev/null; then
    PRG="$link"
  else
    PRG=`dirname "$PRG"`/"$link"
  fi
done

KK_TOMCAT_BIN=`dirname "$PRG"`

cd ${KK_TOMCAT_BIN}

export CATALINA_HOME=${KK_TOMCAT_BIN}/..
export CATALINA_BASE=${KK_TOMCAT_BIN}/..

export CATALINA_OPTS="-Xmx1400m -Xms400m -server -Dsolr.solr.home=${CATALINA_HOME}/solr -Djava.awt.headless=true -Dactivemq.store.dir=${CATALINA_HOME}/mq -Dkk.log4j.debug=true -XX:-OmitStackTraceInFastThrow -DjvmRoute=`hostname` "

# SSL Protocols TLS 1.2
# If using Java 7 and using a Payment Gateway that requires TLS 1.2 you will probably need to add these to CATALINA_OPTS or JAVA_OPTS:
# -Djdk.tls.client.protocols="TLSv1,TLSv1.1,TLSv1.2"  -Dhttps.protocols="TLSv1,TLSv1.1,TLSv1.2"

# Giving KonaKart more memory:
# You will probably want to use considerably more memory on 64' platforms - such as -Xmx4096m at least

# Logging debug options:    
# for debugging log4j                                 add:  -Dlog4j.debug=true
# for debugging kklog4j                               add:  -Dkk.log4j.debug=true
# for specifying a log configuration for KonaKart     add:  -Dkk.log4j.configuration=konakart-logging.xml

# Logging java.net traffic
# -Djavax.net.debug=all

# Logging JAXWS processing:
# -Dcom.sun.xml.ws.transport.http.client.HttpTransportPipe.dump=true -Dcom.sun.metro.soap.dump=true

. ${KK_TOMCAT_BIN}/setJavaHome.sh

if [ ! -x "${CATALINA_HOME}/temp" ]; then
	mkdir ${CATALINA_HOME}/temp
fi

echo "Find out the Java Version"
JAVA_VERSION=$(${JRE_HOME}/bin/java -version 2>&1 | sed -n ';s/.* version "\(.*\)\.\(.*\)\..*"/\1\2/p;')

echo "JAVA_VERSION = '${JAVA_VERSION}'"

case "${JAVA_VERSION}" in
	17)  JAVA_V="7";;
	18)  JAVA_V="8";;
	90)  JAVA_V="9";;
	10*) JAVA_V="10";;
	11*) JAVA_V="11";;
	12*) JAVA_V="12";;
	13*) JAVA_V="13";;
	*)   echo "Unrecognised Java version : ${JAVA_VERSION}";;
esac

echo "Java Version = '${JAVA_V}'"

if [ "${JAVA_V}" = "7" ]
then
	echo "WARNING: Java 7 not supported"
	export CATALINA_OPTS="${CATALINA_OPTS} -XX:PermSize=256m -XX:MaxPermSize=256m "
fi

#if [ "${JAVA_V}" = "9" ]
#then
#	echo "Java 9 so we add the java.se.ee modules"
#	export CATALINA_OPTS="${CATALINA_OPTS} --add-modules java.se.ee "
#fi

#if [ "${JAVA_V}" = "10" ]
#then
#	echo "Java 10 so we add the java.se.ee modules"
#	export CATALINA_OPTS="${CATALINA_OPTS} --add-modules java.se.ee "
#fi

# These JAVA_OPTS (or similar) can be used when running the Java Message Queue Web Console (Enterprise Extensions)
# export JAVA_OPTS="-Dwebconsole.type=properties -Dwebconsole.jms.url=tcp://localhost:8791 -Dwebconsole.jmx.url=service:jmx:rmi:///jndi/rmi://localhost:1099/jmxrmi -Dwebconsole.jmx.user= -Dwebconsole.jmx.password="

if [ -r "$CATALINA_BASE/solr/bin/solr" ]; then
	echo "Start Solr"
	"$CATALINA_BASE/solr/bin/solr" start -p 8983
fi

${KK_TOMCAT_BIN}/startup.sh

# Return to where you started
cd ${HERE}
