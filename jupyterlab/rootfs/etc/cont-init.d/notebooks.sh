#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab
# Ensures the JupyterLab notebooks directory exists
# ==============================================================================
readonly BOOKS="/config/notebooks/"

if ! bashio::fs.directory_exists '/config/notebooks'; then
    mkdir -p /config/notebooks \
        || bashio::exit.nok 'Failed creating notebooks directory'

    git clone -b master --single-branch \
        https://github.com/home-assistant/home-assistant-notebooks.git \
        "${BOOKS}home-assistant" \
            || bashio::exit.nok \
                'Failed installing Home Assistant example notebooks'

    git clone -b master --single-branch --depth 1 \
        https://github.com/bokeh/bokeh-notebooks.git \
        "${BOOKS}bokeh-examples" \
            || bashio::exit.nok \
                'Failed installing Bokeh example notebooks'
else
    if [ -z "$(git -C ${BOOKS}/home-assistant status --untracked-files=no --porcelain)" ];
    then
        git -C "${BOOKS}home-assistant" pull
    else
        bashio::log.warning "Not updating Home Assistant notebook!"
        bashio::log.warning \
            "You have made local changes, which we will not overwrite."
    fi

    if [ -z "$(git -C ${BOOKS}/bokeh-examples status --untracked-files=no --porcelain)" ];
    then
        git -C "${BOOKS}bokeh-examples" pull
    else
        bashio::log.warning "Not updating Bokeh examples notebook!"
        bashio::log.warning \
            "You have made local changes, which we will not overwrite."
    fi
fi
