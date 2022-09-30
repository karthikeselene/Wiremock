FROM alpine:3.14

RUN apk upgrade
RUN apk add openjdk8
RUN apk add wget

ARG WIREMOCK_VERSION="2.33.2"

RUN mkdir /opt/service-mock
WORKDIR /opt/service-mock/

RUN wget -P /opt/service-mock/ --trust-server https://repo1.maven.org/maven2/com/github/tomakehurst/wiremock-jre8-standalone/${WIREMOCK_VERSION}/wiremock-jre8-standalone-${WIREMOCK_VERSION}.jar
RUN chmod 777 wiremock-jre8-standalone-*.jar
RUN mkdir /opt/service-mock/__files
RUN mkdir /opt/service-mock/mappings

COPY ./__files/* /opt/service-mock/__files/
COPY ./mappings/* /opt/service-mock/mappings/

ENTRYPOINT ["java", "-jar", "wiremock-jre8-standalone-2.33.2.jar"]