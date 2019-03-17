#!/usr/bin/with-contenv bashio
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Install user configured/requested packages
# ==============================================================================
if bashio::config.has_value 'system_packages'; then
    apt-get update \
        || bashio::exit.nok 'Failed updating Ubuntu packages repository indexes'

    for package in $(bashio::config 'system_packages'); do
        apt-get install -y --no-install-recommends "$package" \
            || bashio::exit.nok "Failed installing package ${package}"
    done
fi
