FROM alpine:3.15.0

LABEL maintainer="ClementTOCHE"
LABEL version="1.0.0"
LABEL description="DHCP Server"

ARG PCS_ID_NAME
ARG PCS_UID
ARG PCS_GID

RUN addgroup -g ${PCS_GID} ${PCS_ID_NAME};
RUN adduser -s /sbin/nologin -G pcs-dhcp -H -D -u ${PCS_UID} pcs-dhcp

# Upgrade the system
RUN apk update
RUN apk upgrade
RUN apk add \
    dhcp \
    rsyslog

# Entry script
COPY inputs/entry.sh /entry.sh
RUN chown pcs-dhcp:pcs-dhcp /entry.sh
RUN chmod 740 /entry.sh

ENTRYPOINT ["/entry.sh"]

VOLUME ["/etc/dhcp/"]