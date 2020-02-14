#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab Lite
# Install the users GitHub Access token into JupyterLab
# ==============================================================================
readonly CONFIG_PATH="/etc/jupyter/jupyter_notebook_config.py"

# Set password
if bashio::config.has_value 'github_access_token'; then
    token=$(bashio::config 'github_access_token')
    sed -i "s/c.GitHubConfig.access_token\\ .*/c.GitHubConfig.access_token\\ =\\ '${token}'/" "${CONFIG_PATH}" \
        || bashio::exit.nok 'Failed setting up GitHub access token'
fi
