#!/bin/sh
set -e

echo "··························································································"
echo "MARTIN VILCHE"
echo "··························································································"

if [ -z "$USERID" ]; then
USERID=1001
echo "···································································································"
echo "VARIABLE USERID NO ENCONTRADO USANDO POR DEFECTO " $USERID
echo "···································································································"
else
echo "···································································································"
echo "VARIABLE USERID ENCONTRADO: " $USERID
echo "···································································································"
fi

if [ -z "$TIMEZONE" ]; then
echo "···································································································"
echo "VARIABLE TIMEZONE NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "POSIBLES VALORES: America/Montevideo | America/El_Salvador"
echo "···································································································"
else
echo "···································································································"
echo "TIMEZONE SETEADO ENCONTRADO: " $TIMEZONE
echo "···································································································"
echo "SETEANDO TIMEZONE...."
su-exec $USERID cat /usr/share/zoneinfo/$TIMEZONE > /etc/localtime

if [ $? -eq 0 ]; then
echo "···································································································"
echo "TIMEZONE SETEADO CORRECTAMENTE"
echo "···································································································"
else

echo "···································································································"
echo "ERROR AL SETEAR EL TIMEZONE - SALIENDO"
echo "···································································································"
exit 1
fi
fi

if [ -z "$JAVA_OPTS" ]; then
echo "···································································································"
echo "VARIABLE JAVA_OPTS NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "PUEDE DEFINIR LA VARIABLE JAVA_OPTS PARA SETEAR PARAMETROS DE JAVA"

JAVA_OPTS="-XX:+UseParallelGC -Dfile.encoding=UTF8 -XX:GCTimeRatio=4 -XX:AdaptiveSizePolicyWeight=90 -XX:MinHeapFreeRatio=20 -XX:MaxHeapFreeRatio=40 -XX:+ExitOnOutOfMemoryError -XX:+UnlockExperimentalVMOptions -XX:+UseCGroupMemoryLimitForHeap"

echo "···································································································"
else
echo "........................."
echo "VARIABLE JAVA_OPTS SETEADA"
echo "SETEANDO LOS PARAMETROS: " $JAVA_OPTS
echo "........................."
fi


if [ ! -d /opt/jboss/init ]; then
echo "........................."
echo "JBOSS NO INICIALIZADO - DESCARGANDO.."
echo "ESPERE POR FAVOR...."
echo "........................."
wget http://download.jboss.org/jbossas/7.1/jboss-as-7.1.1.Final/jboss-as-7.1.1.Final.tar.gz -O jboss.tar.gz &> /dev/null && \
tar zxvf jboss.tar.gz -C /opt/jboss --strip-components 1 &> /dev/null && chmod +x /opt/jboss/bin/* && \
wget http://repo1.maven.org/maven2/org/jboss/modules/jboss-modules/1.1.5.GA/jboss-modules-1.1.5.GA.jar -O jboss-modules.jar &> /dev/null && cp -rf jboss-modules.jar /opt/jboss/ && \
rm -rf jboss-module.jar jboss.tar.gz && \
mkdir /opt/jboss/init && \
echo "........................." && \
echo "JBOSS DESCARGADO CORRECTAMENTE EN /opt/jboss"
echo "........................." 
else
echo "JBOSS YA FUE INICIALIZADO - NO ES NECESARIO VOLVER A DESCARGAR"
echo "........................." 
fi

echo "LIMPIANDO DIRECTORIOS"

cd /opt/jboss/standalone/; rm -rf log/ tmp/ data/ configuration/standalone_xml_history deployments/*.deployed deployments/*.failed

echo "........................."
echo "FIX PERMISOS"
chown $USERID:$USERID -R /opt/jboss



if [ -z "$JAVA_OPTS" ]; then
echo "···································································································"
echo "VARIABLE JAVA_OPTS NO SETEADA - INICIANDO CON VALORES POR DEFECTO"
echo "PUEDE DEFINIR LA VARIABLE JAVA_OPTS PARA SETEAR PARAMETROS DE JAVA"
echo "···································································································"

else
echo "........................."
echo "VARIABLE JAVA_OPTS SETEADA"
echo "SETEANDO LOS PARAMETROS: " $JAVA_OPTS
echo "........................."
fi

echo "INICIANDO JBOSS......"
exec su-exec $USERID "$@"
