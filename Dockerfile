ARG NEXUS_VERSION=3.69.0-java17

FROM maven:3-jdk-8-alpine AS build
RUN apk add git && git clone https://github.com/sonatype-nexus-community/nexus-repository-composer.git && \
 git clone https://github.com/sonatype-nexus-community/nexus-repository-apk.git && \
 git clone https://github.com/sonatype-nexus-community/nexus-repository-cargo.git

RUN cd /nexus-repository-composer/; \
    mvn clean package -PbuildKar;
RUN cd /nexus-repository-apk/; \
    mvn clean package -PbuildKar;
RUN cd /nexus-repository-cargo/; \
    mvn clean package -PbuildKar;

FROM sonatype/nexus3:$NEXUS_VERSION

ENV INSTALL4J_ADD_VM_PARAMS="-Xms1200m -Xmx1200m -XX:MaxDirectMemorySize=2g -Djava.util.prefs.userRoot=${NEXUS_DATA}/javaprefs"

ARG DEPLOY_DIR=/opt/sonatype/nexus/deploy/

USER root

COPY --from=build /nexus-repository-composer/nexus-repository-composer/target/nexus-repository-composer-*-bundle.kar ${DEPLOY_DIR}
COPY --from=build /nexus-repository-apk/nexus-repository-apk/target/nexus-repository-apk-*-bundle.kar ${DEPLOY_DIR}
COPY --from=build /nexus-repository-cargo/target/nexus-repository-cargo-*-bundle.kar ${DEPLOY_DIR}

USER nexus

CMD ["bin/nexus", "run"]
