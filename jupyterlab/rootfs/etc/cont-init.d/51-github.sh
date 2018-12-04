#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Install the users GitHub Access token into JupyterLab
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG_PATH="/etc/jupyter/jupyter_notebook_config.py"

# Set password
if hass.config.has_value 'github_access_token'; then
    token=$(hass.config.get 'github_access_token')
    sed -i "s/c.GitHubConfig.access_token\\ .*/c.GitHubConfig.access_token\\ =\\ '${token}'/" "${CONFIG_PATH}" \
        || hass.die 'Failed setting up GitHub access token'
fi
