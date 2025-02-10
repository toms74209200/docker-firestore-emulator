# syntax=docker/dockerfile:1
# check=error=true

FROM debian:bookworm-slim

COPY --from=node:20-bookworm-slim --chown=root:root /usr/local/bin /usr/bin
COPY --from=node:20-bookworm-slim --chown=root:root /usr/local/lib/node_modules /usr/lib/node_modules

RUN apt-get update \
    && apt-get install -y --no-install-recommends \
    openjdk-17-jre-headless \
    && apt-get autoremove -y && apt-get clean && rm -rf /var/lib/apt/lists/*

RUN npm install -g firebase-tools@13.30 \
    && firebase setup:emulators:firestore

ARG USERNAME=firestore
ARG GROUPNAME=firestore
ARG UID=1000
ARG GID=1000
RUN groupadd -g $GID $GROUPNAME && \
    useradd -m -s /bin/bash -u $UID -g $GID $USERNAME
USER $USERNAME

# Download emulator
RUN firebase emulators:exec --only firestore bash || true

WORKDIR /firestore

ENTRYPOINT [ "firebase" ]
CMD [ "emulators:start", "--only", "firestore" ]