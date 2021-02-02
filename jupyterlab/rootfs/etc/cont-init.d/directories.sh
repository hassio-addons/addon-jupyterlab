#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab Lite
# Ensure directories in the persistent storage exists
# ==============================================================================
if ! bashio::fs.directory_exists '/data/user-settings'; then
    mkdir -p /data/user-settings \
        || bashio::exit.nok \
            'Failed creating persistent user-settings directory'
fi

if ! bashio::fs.directory_exists '/data/workspaces'; then
    mkdir -p /data/workspaces \
        || bashio::exit.nok \
            'Failed creating persistent workspaces directory'
fi

if ! bashio::fs.directory_exists '/data/local'; then
    mkdir -p /data/local \
        || bashio::exit.nok \
            'Failed creating persistent local directory'
fi

ln -s /data/local /root/.local
