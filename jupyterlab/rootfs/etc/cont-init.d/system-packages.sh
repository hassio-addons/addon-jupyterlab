#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab
# Install user configured requested packages & commands
# ==============================================================================
if bashio::config.has_value 'system_packages'; then
    apt-get update \
        || bashio::exit.nok 'Failed updating Ubuntu packages repository indexes'

    for package in $(bashio::config 'system_packages'); do
        apt-get install -y --no-install-recommends "$package" \
            || bashio::exit.nok "Failed installing package ${package}"
    done
fi

if bashio::config.has_value 'init_commands'; then
    while read -r cmd; do
        eval "${cmd}" \
            || bashio::exit.nok "Failed executing init command: ${cmd}"
    done <<< "$(bashio::config 'init_commands')"
fi
