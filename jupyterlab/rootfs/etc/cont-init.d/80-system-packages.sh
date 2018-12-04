#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Install user configured/requested packages
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

if hass.config.has_value 'system_packages'; then
    apt-get update \
        || hass.die 'Failed updating Ubuntu packages repository indexes'

    for package in $(hass.config.get 'system_packages'); do
        apt-get install -y --no-install-recommends "$package" \
            || hass.die "Failed installing package ${package}"
    done
fi
