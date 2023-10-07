ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:7.1.0
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Install Python packages on system level
ENV PIP_BREAK_SYSTEM_PACKAGES=1

# Copy Python requirements file
COPY requirements.txt /opt/
COPY rootfs/etc/pip.conf /etc/pip.conf

# Setup base
ARG BUILD_ARCH
# hadolint ignore=DL3018,DL3008
RUN \
    MAKEFLAGS="-j$(nproc)" \
    && export MAKEFLAGS \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.9 \
        dirmngr=2.2.40-1.1 \
        git=1:2.39.2-1.1 \
        gpg-agent=2.2.40-1.1 \
        gpg=2.2.40-1.1 \
        libffi-dev=3.4.4-1 \
        libffi8=3.4.4-1 \
        libfreetype6-dev=2.12.1+dfsg-5 \
        libfreetype6=2.12.1+dfsg-5 \
        libjpeg62-turbo-dev=1:2.1.5-2 \
        libjpeg62-turbo=1:2.1.5-2 \
        libmariadb-dev=1:10.11.4-1~deb12u1 \
        libmariadb3=1:10.11.4-1~deb12u1 \
        libnginx-mod-http-lua=1:0.10.23-1 \
        libpng-dev=1.6.39-2 \
        libpng16-16=1.6.39-2 \
        libpq-dev=15.3-0+deb12u1 \
        libpq5=15.3-0+deb12u1 \
        libssl-dev=3.0.11-1~deb12u1 \
        libtiff5-dev=4.5.0-6 \
        libxml2-dev=2.9.14+dfsg-1.3~deb12u1 \
        libxml2=2.9.14+dfsg-1.3~deb12u1 \
        libxslt1-dev=1.1.35-1 \
        libxslt1.1=1.1.35-1 \
        libzmq3-dev=4.3.4-6 \
        libzmq5=4.3.4-6 \
        nginx=1.22.1-9 \
        pandoc=2.17.1.1-2~deb12u1 \
        pkg-config=1.8.1-1 \
        python3-dev=3.11.2-1+b1 \
        python3-distutils=3.11.2-3 \
        python3-minimal=3.11.2-1+b1 \
        zlib1g-dev=1:1.2.13.dfsg-1 \
    \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_20.x nodistro main" \
     > /etc/apt/sources.list.d/nodesource.list \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs=20.6.1-1nodesource1 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    \
    && update-alternatives \
        --install /usr/bin/python python /usr/bin/python3 10 \
    \
    && pip3 install --no-cache-dir numpy==1.25.2 \
    && pip3 install --no-cache-dir -r /opt/requirements.txt \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        dirmngr \
        gpg \
        gpg-agent \
        libffi-dev \
        libfreetype6-dev \
        libjpeg62-turbo-dev \
        libmariadb-dev \
        libpng-dev \
        libpq-dev \
        libssl-dev \
        libtiff5-dev \
        libxml2-dev \
        libxslt1-dev \
        libzmq3-dev \
        pkg-config \
        python-dev \
        python3-dev \
        zlib1g-dev \
    \
    && find /usr/local \
        \( -type d -a -name test -o -name tests -o -name '__pycache__' \) \
        -o \( -type f -a -name '*.pyc' -o -name '*.pyo' \) \
        -exec rm -rf '{}' + \
    \
    && npm cache clean --force \
    \
    && rm -fr \
        /tmp/* \
        /root/{.cache,.config,.gnupg,.local,.log,.npm} \
        /usr/local/share/.cache \
        /var/{cache,log}/* \
        /var/lib/apt/lists/*

# Copy root filesystem
COPY rootfs /

# Build arguments
ARG BUILD_ARCH
ARG BUILD_DATE
ARG BUILD_DESCRIPTION
ARG BUILD_NAME
ARG BUILD_REF
ARG BUILD_REPOSITORY
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="${BUILD_NAME}" \
    io.hass.description="${BUILD_DESCRIPTION}" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.title="${BUILD_NAME}" \
    org.opencontainers.image.description="${BUILD_DESCRIPTION}" \
    org.opencontainers.image.vendor="Home Assistant Community Add-ons" \
    org.opencontainers.image.authors="Franck Nijhof <frenck@addons.community>" \
    org.opencontainers.image.licenses="MIT" \
    org.opencontainers.image.url="https://addons.community" \
    org.opencontainers.image.source="https://github.com/${BUILD_REPOSITORY}" \
    org.opencontainers.image.documentation="https://github.com/${BUILD_REPOSITORY}/blob/main/README.md" \
    org.opencontainers.image.created=${BUILD_DATE} \
    org.opencontainers.image.revision=${BUILD_REF} \
    org.opencontainers.image.version=${BUILD_VERSION}
