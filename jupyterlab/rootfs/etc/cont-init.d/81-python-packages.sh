#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Install user configured/requested Python packages
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.has_value 'python_packages'; then
    for package in $(hass.config.get 'python_packages'); do
        pip3 install "$package" \
            || hass.die "Failed installing package ${package}"
    done
fi
