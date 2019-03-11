# JBOSS AS 7.1.1 OPENJDK 7 -  ALPINE 3.8

[![Build Status](https://travis-ci.org/joemccann/dillinger.svg?branch=master)](https://travis-ci.org/joemccann/dillinger)


# Nuevas funcionalidades:

  - Permite definir la zona horaria al iniciar el servicio
  - Permite definir parametros de JAVA al iniciar el servicio
  - Permite definir el id del usuario que iniciará el contenedor
  - El jboss se descarga al iniciar el servicio por primera vez, si ya fue descargado se omite este paso.

### Iniciar


Ejecutar para iniciar el servicio

```sh
docker run -d --name jboss7.1.1 -e TIMEZONE=America/Montevideo -v $PWD/jboss:/opt/jboss -e USERID=1000 sofislab/jboss:as7.1.1-jdk7-alpine3.8

```

### Variables


| Variable | Detalle |
| ------ | ------ |
| TIMEZONE | Define la zona horaria a utilizar (America/Montevideo, America/El_salvador) |
| JAVA_OPTS | Define parametros de la jvm |
| USERID | Define el id del usuario que iniciará el contenedor |

License
----

Martin vilche
Sofis Solutions

