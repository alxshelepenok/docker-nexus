ARG NEXUS_VERSION=3.69.0-java11

FROM maven:3-jdk-8-alpine AS build
RUN apk add git && git clone https://github.com/sonatype-nexus-community/nexus-repository-cargo.git

RUN cd /nexus-repository-cargo/; mvn clean package -PbuildKar;

FROM sonatype/nexus3:$NEXUS_VERSION

ENV INSTALL4J_ADD_VM_PARAMS="-Xms1024m -Xmx1024m -XX:MaxDirectMemorySize=1500m -Djava.util.prefs.userRoot=${NEXUS_DATA}/javaprefs"

ARG DEPLOY_DIR=/opt/sonatype/nexus/deploy/

USER root

COPY --from=build /nexus-repository-cargo/target/nexus-repository-cargo-*-bundle.kar ${DEPLOY_DIR}

USER nexus
