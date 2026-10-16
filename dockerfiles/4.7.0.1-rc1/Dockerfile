# syntax=docker/dockerfile:1

################################################################
#                                                              #
#  WARNING: THIS FILE IS AUTO-GENERATED. DO NOT EDIT MANUALLY  #
#                                                              #
################################################################

ARG CREATED_AT

FROM alpine:3.24.1 AS downloader

WORKDIR /opt

# Download Open Integration Engine release
RUN apk add --no-cache curl \
    && curl -L \
      -o /opt/engine.tar.gz \
      -H "Accept: application/vnd.github+json" \
      -H "X-GitHub-Api-Version: 2022-11-28" \
       https://github.com/NovaMap-Health/engine/releases/download/v4.7.0.1-rc1/oie-nova_unix_4_7_0_1-rc1.tar.gz \
    && tar xzf engine.tar.gz \
    && mv /opt/oie-nova /opt/engine \
    && mkdir -p /opt/engine/appdata

WORKDIR /opt/engine
COPY --chmod=755 entrypoint.sh /opt/engine/entrypoint.sh

RUN rm -rf cli-lib manager-lib \
    && rm mirth-cli-launcher.jar oiecommand
FROM eclipse-temurin:21.0.11_10-jre-resolute AS ubuntu-jre

ARG CREATED_AT

LABEL \
  "org.opencontainers.image.authors"="NovaMap Health" \
  "org.opencontainers.image.created"="${CREATED_AT?:}" \
  "org.opencontainers.image.description"="An open source fork of the now closed-source Mirth Connect." \
  "org.opencontainers.image.licenses"="MPL-2.0" \
  "org.opencontainers.image.source"="https://github.com/NovaMap-Health/engine-docker" \
  "org.opencontainers.image.title"="Eclipse Open Integration Engine - NovaMap Edition" \
  "org.opencontainers.image.url"="https://github.com/NovaMap-Health/engine" \
  "org.opencontainers.image.vendor"="NovaMap Health" \
  "org.opencontainers.image.version"="4.7.0.1-rc1"

COPY --from=downloader --chown=1000:1000 /opt/engine /opt/engine

RUN apt-get update \
    && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/* \
    && groupmod --new-name engine ubuntu \
    && usermod -l engine ubuntu \
    && usermod -aG engine engine

VOLUME /opt/engine/appdata
VOLUME /opt/engine/custom-extensions

WORKDIR /opt/engine
EXPOSE 8443
USER engine

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./oie-novaserver"]

FROM eclipse-temurin:21.0.11_10-jdk-resolute AS ubuntu-jdk

ARG CREATED_AT

LABEL \
  "org.opencontainers.image.authors"="NovaMap Health" \
  "org.opencontainers.image.created"="${CREATED_AT?:}" \
  "org.opencontainers.image.description"="An open source fork of the now closed-source Mirth Connect." \
  "org.opencontainers.image.licenses"="MPL-2.0" \
  "org.opencontainers.image.source"="https://github.com/NovaMap-Health/engine-docker" \
  "org.opencontainers.image.title"="Eclipse Open Integration Engine - NovaMap Edition" \
  "org.opencontainers.image.url"="https://github.com/NovaMap-Health/engine" \
  "org.opencontainers.image.vendor"="NovaMap Health" \
  "org.opencontainers.image.version"="4.7.0.1-rc1"

COPY --from=downloader --chown=1000:1000 /opt/engine /opt/engine

RUN apt-get update \
    && apt-get install -y unzip \
    && rm -rf /var/lib/apt/lists/* \
    && groupmod --new-name engine ubuntu \
    && usermod -l engine ubuntu \
    && usermod -aG engine engine

VOLUME /opt/engine/appdata
VOLUME /opt/engine/custom-extensions

WORKDIR /opt/engine
EXPOSE 8443
USER engine

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./oie-novaserver"]

FROM eclipse-temurin:21.0.11_10-jre-alpine AS alpine-jre

ARG CREATED_AT

LABEL \
  "org.opencontainers.image.authors"="NovaMap Health" \
  "org.opencontainers.image.created"="${CREATED_AT?:}" \
  "org.opencontainers.image.description"="An open source fork of the now closed-source Mirth Connect." \
  "org.opencontainers.image.licenses"="MPL-2.0" \
  "org.opencontainers.image.source"="https://github.com/NovaMap-Health/engine-docker" \
  "org.opencontainers.image.title"="Eclipse Open Integration Engine - NovaMap Edition" \
  "org.opencontainers.image.url"="https://github.com/NovaMap-Health/engine" \
  "org.opencontainers.image.vendor"="NovaMap Health" \
  "org.opencontainers.image.version"="4.7.0.1-rc1"

COPY --from=downloader --chown=1000:1000 /opt/engine /opt/engine

RUN apk add --no-cache bash unzip \
    && adduser -D -H -u 1000 engine engine

VOLUME /opt/engine/appdata
VOLUME /opt/engine/custom-extensions

WORKDIR /opt/engine
EXPOSE 8443
USER engine

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./oie-novaserver"]

FROM eclipse-temurin:21.0.11_10-jdk-alpine AS alpine-jdk

ARG CREATED_AT

LABEL \
  "org.opencontainers.image.authors"="NovaMap Health" \
  "org.opencontainers.image.created"="${CREATED_AT?:}" \
  "org.opencontainers.image.description"="An open source fork of the now closed-source Mirth Connect." \
  "org.opencontainers.image.licenses"="MPL-2.0" \
  "org.opencontainers.image.source"="https://github.com/NovaMap-Health/engine-docker" \
  "org.opencontainers.image.title"="Eclipse Open Integration Engine - NovaMap Edition" \
  "org.opencontainers.image.url"="https://github.com/NovaMap-Health/engine" \
  "org.opencontainers.image.vendor"="NovaMap Health" \
  "org.opencontainers.image.version"="4.7.0.1-rc1"

COPY --from=downloader --chown=1000:1000 /opt/engine /opt/engine

RUN apk add --no-cache bash unzip \
    && adduser -D -H -u 1000 engine engine

VOLUME /opt/engine/appdata
VOLUME /opt/engine/custom-extensions

WORKDIR /opt/engine
EXPOSE 8443
USER engine

ENTRYPOINT ["./entrypoint.sh"]
CMD ["./oie-novaserver"]
