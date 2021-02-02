#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab
# Configure JupterLabs
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

bashio::var.json \
    entry "$(bashio::addon.ingress_entry)" \
    token "$(bashio::config 'github_access_token')" \
    | tempio \
        -template /etc/jupyter/jupyter_notebook_config.gtpl \
        -out /etc/jupyter/jupyter_notebook_config.py


