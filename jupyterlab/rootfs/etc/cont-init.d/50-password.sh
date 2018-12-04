#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Sets the user set password into JupyterLab
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly CONFIG_PATH="/etc/jupyter/jupyter_notebook_config.py"

# Set password
if hass.config.has_value 'password'; then
    password=$(hass.config.get 'password')
    password=$(python3 -c "from notebook.auth.security import passwd;print(passwd('${password}'))")
    sed -i "s/c.NotebookApp.password\\ .*/c.NotebookApp.password\\ =\\ '${password}'/" "${CONFIG_PATH}" \
        || hass.die 'Failed setting up password'
fi
