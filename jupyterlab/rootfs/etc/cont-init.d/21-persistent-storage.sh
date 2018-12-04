#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Ensure directories in the persistent storage exists
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if ! hass.directory_exists '/data/user-settings'; then
    mkdir -p /data/user-settings \
        || hass.die 'Failed creating persistent user-settings directory'
fi

if ! hass.directory_exists '/data/workspaces'; then
    mkdir -p /data/workspaces \
        || hass.die 'Failed creating persistent workspaces directory'
fi

if ! hass.directory_exists '/data/local'; then
    mkdir -p /data/local \
        || hass.die 'Failed creating persistent local directory'
fi
ln -s /data/local /root/.local
