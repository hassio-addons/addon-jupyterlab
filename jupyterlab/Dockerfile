ARG BUILD_FROM=hassioaddons/debian-base:3.0.1
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /opt/
COPY rootfs/etc/pip.conf /etc/pip.conf

# Setup base
# hadolint ignore=DL3018
ARG BUILD_ARCH
RUN \
    MAKEFLAGS="-j$(nproc)" \
    && export MAKEFLAGS \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.6 \
        dirmngr=2.2.12-1+deb10u1 \
        git=1:2.20.1-2+deb10u1 \
        gpg-agent=2.2.12-1+deb10u1 \
        gpg=2.2.12-1+deb10u1 \
        libffi-dev=3.2.1-9 \
        libffi6=3.2.1-9 \
        libfreetype6-dev=2.9.1-3+deb10u1 \
        libfreetype6=2.9.1-3+deb10u1 \
        libjpeg62-turbo-dev=1:1.5.2-2+b1 \
        libjpeg62-turbo=1:1.5.2-2+b1 \
        libmariadb-dev=1:10.3.22-0+deb10u1 \
        libmariadb3=1:10.3.22-0+deb10u1 \
        libnginx-mod-http-lua=1.14.2-2+deb10u1 \
        libpng-dev=1.6.36-6 \
        libpng16-16=1.6.36-6 \
        libpq-dev=11.7-0+deb10u1 \
        libpq5=11.7-0+deb10u1 \
        libssl-dev=1.1.1d-0+deb10u2 \
        libtiff5-dev=4.1.0+git191117-2~deb10u1 \
        libxml2-dev=2.9.4+dfsg1-7+b3 \
        libxml2=2.9.4+dfsg1-7+b3 \
        libxslt1-dev=1.1.32-2.2~deb10u1 \
        libxslt1.1=1.1.32-2.2~deb10u1 \
        libzmq3-dev=4.3.1-4+deb10u1 \
        libzmq5=4.3.1-4+deb10u1 \
        luarocks=2.4.2+dfsg-1 \
        nginx=1.14.2-2+deb10u1 \
        pandoc=2.2.1-3+b2 \
        pkg-config=0.29-6 \
        python-dev=2.7.16-1 \
        python3-dev=3.7.3-1 \
        python3-distutils=3.7.3-1 \
        python3-minimal=3.7.3-1 \
        zlib1g-dev=1:1.2.11.dfsg-1 \
    \
    && luarocks install lua-resty-http 0.15-0 \
    \
    && curl -sL https://deb.nodesource.com/setup_12.x | bash - \
    \
    && apt-get install -y --no-install-recommends \
        nodejs=12.16.1-1nodesource1 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    \
    && update-alternatives \
        --install /usr/bin/python python /usr/bin/python3 10 \
    \
    && pip3 install --no-cache-dir numpy==1.18.1 \
    && pip3 install --no-cache-dir -r /opt/requirements.txt \
    \
    && jupyter labextension install \
        @jupyter-widgets/jupyterlab-manager@1.1 --no-build \
    && jupyter labextension install jupyterlab_bokeh --no-build \
    && jupyter labextension install @jupyterlab/github --no-build \
    && jupyter serverextension enable jupyterlab_sql --py --sys-prefix \
    && jupyter lab build \
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
    && find /usr/local/lib/python3.7/ -type d -name tests -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.7/ -type d -name test -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.7/ -name __pycache__ -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.7/ -name "*.pyc" -depth -exec rm -f {} \; \
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
ARG BUILD_DATE
ARG BUILD_REF
ARG BUILD_VERSION

# Labels
LABEL \
    io.hass.name="JupyterLab Lite" \
    io.hass.description="Create and share documents that contain live code, equations, visualizations, and explanatory text directly in your browser" \
    io.hass.arch="${BUILD_ARCH}" \
    io.hass.type="addon" \
    io.hass.version=${BUILD_VERSION} \
    maintainer="Franck Nijhof <frenck@addons.community>" \
    org.label-schema.description="Create and share documents that contain live code, equations, visualizations, and explanatory text directly in your browser" \
    org.label-schema.build-date=${BUILD_DATE} \
    org.label-schema.name="JupyterLab Lite" \
    org.label-schema.schema-version="1.0" \
    org.label-schema.url="https://addons.community" \
    org.label-schema.usage="https://github.com/hassio-addons/addon-jupyterlab-lite/tree/master/README.md" \
    org.label-schema.vcs-ref=${BUILD_REF} \
    org.label-schema.vcs-url="https://github.com/hassio-addons/addon-jupyterlab-lite" \
    org.label-schema.vendor="Home Assistant Community Add-ons"
