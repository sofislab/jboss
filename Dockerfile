FROM alpine:3.8
LABEL AUTOR="MARTIN VILCHE" PROYECTO="Proyecto JBOSS AS 7.1.1 OPENJDK 7"
ENV TZ=America/Montevideo JBOSS_HOME=/opt/jboss
RUN apk --no-cache add --update wget openjdk7-jre-base su-exec tzdata msttcorefonts-installer fontconfig && \
    update-ms-fonts && \
    fc-cache -f && \
touch /etc/localtime && chown 1001:1001 -R /etc/localtime
COPY run.sh /usr/bin/run.sh
ENTRYPOINT ["/usr/bin/run.sh"]
VOLUME ["/opt/jboss"]
CMD ["/opt/jboss/bin/standalone.sh",  "-b", "0.0.0.0"]
