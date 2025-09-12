ARG BUILD_FROM=ghcr.io/hassio-addons/debian-base:8.0.0
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
        build-essential=12.12 \
        dirmngr=2.4.7-21+b3 \
        git=1:2.47.3-0+deb13u1 \
        gpg-agent=2.4.7-21+b3 \
        gpg=2.4.7-21+b3 \
        libffi-dev=3.4.8-2 \
        libffi8=3.4.8-2 \
        libfreetype-dev=2.13.3+dfsg-1 \
        libfreetype6=2.13.3+dfsg-1 \
        libjpeg62-turbo-dev=1:2.1.5-4 \
        libjpeg62-turbo=1:2.1.5-4 \
        libmariadb-dev=1:11.8.3-0+deb13u1 \
        libmariadb3=1:11.8.3-0+deb13u1 \
        libnginx-mod-http-lua=1:0.10.28-2 \
        libpng-dev=1.6.48-1 \
        libpng16-16t64=1.6.48-1 \
        libpq-dev=17.6-0+deb13u1 \
        libpq5=17.6-0+deb13u1 \
        libssl-dev=3.5.1-1 \
        libtiff-dev=4.7.0-3 \
        libtiff6=4.7.0-3 \
        libxml2-dev=2.12.7+dfsg+really2.9.14-2.1+deb13u1 \
        libxml2=2.12.7+dfsg+really2.9.14-2.1+deb13u1 \
        libxslt1-dev=1.1.35-1.2+deb13u1 \
        libxslt1.1=1.1.35-1.2+deb13u1 \
        libzmq3-dev=4.3.5-1+b3 \
        libzmq5=4.3.5-1+b3 \
        nginx=1.26.3-3+deb13u1 \
        pandoc=3.1.11.1+ds-2 \
        pkg-config=1.8.1-4 \
        python3-dev=3.13.5-1 \
        python3-minimal=3.13.5-1 \
        zlib1g-dev=1:1.3.dfsg+really1.3.1-1+b1 \
    \
    && mkdir -p /etc/apt/keyrings \
    && curl -fsSL https://deb.nodesource.com/gpgkey/nodesource-repo.gpg.key \
        | gpg --dearmor -o /etc/apt/keyrings/nodesource.gpg \
    \
    && echo "deb [signed-by=/etc/apt/keyrings/nodesource.gpg] https://deb.nodesource.com/node_22.x nodistro main" \
     > /etc/apt/sources.list.d/nodesource.list \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        nodejs=22.19.0-1nodesource1 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    \
    && update-alternatives \
        --install /usr/bin/python python /usr/bin/python3 13 \
    \
    && pip3 install --no-cache-dir numpy==2.3.2 \
    && pip3 install --no-cache-dir -r /opt/requirements.txt \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        dirmngr \
        gpg \
        gpg-agent \
        libffi-dev \
        libfreetype-dev \
        libjpeg62-turbo-dev \
        libmariadb-dev \
        libpng-dev \
        libpq-dev \
        libssl-dev \
        libtiff-dev \
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
