# syntax=docker/dockerfile:1
# check=error=true

FROM debian:trixie-slim

COPY --from=node:24-trixie-slim --chown=root:root /usr/local/bin /usr/bin
COPY --from=node:24-trixie-slim --chown=root:root /usr/local/lib/node_modules /usr/lib/node_modules

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openjdk-21-jre-headless \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g firebase-tools@15.32 \
    && npm cache clean --force

ARG USERNAME=firestore
ARG GROUPNAME=firestore
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME

# Download emulator
WORKDIR /home/$USERNAME
RUN firebase setup:emulators:firestore

WORKDIR /firestore

ENTRYPOINT [ "firebase" ]
CMD [ "emulators:start", "--only", "firestore" ]
