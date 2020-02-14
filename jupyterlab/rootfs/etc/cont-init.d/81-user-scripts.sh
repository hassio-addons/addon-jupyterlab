#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab Lite
# Executes user configured/requested commands on startup
# ==============================================================================
if bashio::config.has_value 'init_commands'; then
    while read -r cmd; do
        eval "${cmd}" \
            || bashio::exit.nok "Failed executing init command: ${cmd}"
    done <<< "$(bashio::config 'init_commands')"
fi
