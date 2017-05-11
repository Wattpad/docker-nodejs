FROM alpine:3.2

ENV NODEJS_VERSION=v5.12.0
ENV CONFIG_FLAGS="--without-npm"

RUN apk --update add --virtual build-dependencies \
    tar \
    xz \
    curl \
    make \
    gcc \
    g++ \
    python \
    linux-headers \
    binutils-gold \
    gnupg \
    libstdc++ \
    bash \
    paxctl && \
    curl -sSLO https://nodejs.org/dist/${NODEJS_VERSION}/node-${NODEJS_VERSION}.tar.xz
RUN tar -xf node-${NODEJS_VERSION}.tar.xz && \
    cd node-${NODEJS_VERSION} && \
    ./configure --prefix=/usr ${CONFIG_FLAGS} && \
    make -j$(getconf _NPROCESSORS_ONLN) && \
    make install && \
    paxctl -cmr /usr/bin/node && \
    rm -r /node-${NODEJS_VERSION} && \
    cd /

# Profile is needed for yarn install to succeed
RUN touch ~/.bash_profile

RUN curl -o -L https://yarnpkg.com/install.sh | bash
