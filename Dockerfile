# reference: https://www.blazemeter.com/blog/make-use-of-docker-with-jmeter-learn-how

FROM alpine:3.8

ARG JMETER_VERSION="3.3"

ENV	JMETER_FROM https://archive.apache.org/dist/jmeter/binaries/apache-jmeter-${JMETER_VERSION}.tgz
ENV JMETER_HOME /opt/apache-jmeter-${JMETER_VERSION}
ENV JMETER_PLUGINS ${JMETER_HOME}/lib/ext
ENV	JMETER_BIN	${JMETER_HOME}/bin

RUN apk update && apk upgrade
RUN	apk add ca-certificates && update-ca-certificates
RUN	apk add openjdk8-jre curl unzip bash
RUN	rm -rf /var/cache/apk/*
RUN mkdir -p /tmp/dependencies
RUN curl -L ${JMETER_FROM} > /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz
RUN mkdir -p /opt
RUN tar -xzf /tmp/dependencies/apache-jmeter-${JMETER_VERSION}.tgz -C /opt
RUN rm -rf /tmp/dependencies
# deploy websocket library
RUN curl -L https://bitbucket.org/pjtr/jmeter-websocket-samplers/downloads/JMeterWebSocketSamplers-1.2.1.jar -o ${JMETER_PLUGINS}/JMeterWebSocketSamplers-1.2.1.jar

# no need to copy test data
# use -v at runtime to access 
# them in and out of container
# COPY test/ ${JMETER_HOME}

ENV PATH $PATH:$JMETER_BIN

COPY run_jmeter.sh /

WORKDIR	${JMETER_HOME}

ENTRYPOINT ["/run_jmeter.sh"]
