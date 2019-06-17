ARG BUILD_FROM=hassioaddons/ubuntu-base:3.1.2
# hadolint ignore=DL3006
FROM ${BUILD_FROM}

# Set shell
SHELL ["/bin/bash", "-o", "pipefail", "-c"]

# Copy Python requirements file
COPY requirements.txt /opt/

# Setup base
# hadolint ignore=DL3018
ARG BUILD_ARCH
RUN \
    MAKEFLAGS="-j$(nproc)" \
    && export MAKEFLAGS \
    \
    && apt-get update \
    && apt-get install -y --no-install-recommends \
        build-essential=12.4ubuntu1 \
        dirmngr=2.2.4-1ubuntu1.2 \
        git=1:2.17.1-1ubuntu0.4 \
        gpg-agent=2.2.4-1ubuntu1.2 \
        gpg=2.2.4-1ubuntu1.2 \
        libffi-dev=3.2.1-8 \
        libffi6=3.2.1-8 \
        libfreetype6-dev=2.8.1-2ubuntu2 \
        libfreetype6=2.8.1-2ubuntu2 \
        libjpeg-turbo8-dev=1.5.2-0ubuntu5.18.04.1 \
        libjpeg-turbo8=1.5.2-0ubuntu5.18.04.1 \
        libmysqlclient-dev=5.7.26-0ubuntu0.18.04.1 \
        libmysqlclient20=5.7.26-0ubuntu0.18.04.1 \
        libnginx-mod-http-lua=1.14.0-0ubuntu1.2 \
        libpng-dev=1.6.34-1ubuntu0.18.04.2 \
        libpng16-16=1.6.34-1ubuntu0.18.04.2 \
        libpq-dev=10.8-0ubuntu0.18.04.1 \
        libpq5=10.8-0ubuntu0.18.04.1 \
        libssl-dev=1.1.1-1ubuntu2.1~18.04.2 \
        libtiff5-dev=4.0.9-5ubuntu0.2 \
        libxml2-dev=2.9.4+dfsg1-6.1ubuntu1.2 \
        libxml2=2.9.4+dfsg1-6.1ubuntu1.2 \
        libxslt1-dev=1.1.29-5 \
        libxslt1.1=1.1.29-5 \
        libzmq3-dev=4.2.5-1ubuntu0.1 \
        libzmq5=4.2.5-1ubuntu0.1 \
        luarocks=2.4.2+dfsg-1 \
        nginx=1.14.0-0ubuntu1.2 \
        pandoc=1.19.2.4~dfsg-1build4 \
        pkg-config=0.29.1-0ubuntu2 \
        python-dev=2.7.15~rc1-1 \
        python3-dev=3.6.7-1~18.04 \
        python3-distutils=3.6.8-1~18.04 \
        python3-minimal=3.6.7-1~18.04 \
        zlib1g-dev=1:1.2.11.dfsg-0ubuntu2 \
    \
    && luarocks install lua-resty-http 0.13-0 \
    \
    && curl -sL https://deb.nodesource.com/setup_8.x | bash - \
    \
    && apt-get install -y --no-install-recommends \
        nodejs=8.16.0-1nodesource1 \
    \
    && curl https://bootstrap.pypa.io/get-pip.py | python3 \
    \
    && update-alternatives \
        --install /usr/bin/python python /usr/bin/python3 10 \
    \
    && pip3 install --no-cache-dir numpy==1.16.4 \
    && pip3 install --no-cache-dir -r /opt/requirements.txt \
    \
    && jupyter labextension install \
        @jupyter-widgets/jupyterlab-manager@0.38 --no-build \
    && jupyter labextension install jupyterlab_bokeh --no-build \
    && jupyter labextension install @jupyterlab/github --no-build \
    && jupyter lab build \
    \
    && apt-get purge -y --auto-remove \
        build-essential \
        dirmngr \
        gpg \
        gpg-agent \
        libffi-dev \
        libfreetype6-dev \
        libjpeg-turbo8-dev \
        libmysqlclient-dev \
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
    && find /usr/local/lib/python3.6/ -type d -name tests -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.6/ -type d -name test -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.6/ -name __pycache__ -depth -exec rm -rf {} \; \
    && find /usr/local/lib/python3.6/ -name "*.pyc" -depth -exec rm -f {} \; \
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
    org.label-schema.vendor="Community Hass.io Add-ons"
