FROM alpine:3.2

ENV NODEJS_VERSION=v5.12.0
ENV DEL_PKGS="libgcc libstdc++" RM_DIRS=/usr/include

RUN apk --update add --virtual build-dependencies \
    tar \
    curl \
    make \
    gcc \
    g++ \
    python \
    binutils-gold \
    linux-headers \
    paxctl \
    libgcc \
    libstdc++ && \
    curl -s https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.gz | tar -xz && \
    cd /node-${NODEJS_VERSION} && \
    ./configure --prefix=/usr && \
    make -j$(grep -c ^processor /proc/cpuinfo 2>/dev/null || 1) && \
    make install && \
    paxctl -cm /usr/bin/node && \
    rm -r /node-${NODEJS_VERSION} && \
    apk del build-dependencies
