#!/usr/bin/with-contenv bash
# ==============================================================================
# Community Hass.io Add-ons: JupyterLab Lite
# Ensures the JupyterLab notebooks directory exists
# ==============================================================================
# shellcheck disable=SC1091
source /usr/lib/hassio-addons/base.sh

readonly BOOKS="/config/notebooks/"

if ! hass.directory_exists '/config/notebooks'; then
    mkdir -p /config/notebooks \
        || hass.die 'Failed creating notebooks directory'

    git clone -b master --single-branch \
        https://github.com/home-assistant/home-assistant-notebooks.git \
        "${BOOKS}home-assistant" \
            || hass.die 'Failed installing Home Assistant example notebooks'

    git clone -b master --single-branch --depth 1 \
        https://github.com/bokeh/bokeh-notebooks.git \
        "${BOOKS}bokeh-examples" \
            || hass.die 'Failed installing Bokeh example notebooks'
else
    if [ -z "$(git -C ${BOOKS}/home-assistant status --untracked-files=no --porcelain)" ];
    then
        git -C "${BOOKS}home-assistant" pull
    else
        hass.log.warning "Not updating Home Assistant notebook!"
        hass.log.warning "You have made local changes, which we will not overwrite."
    fi

    if [ -z "$(git -C ${BOOKS}/bokeh-examples status --untracked-files=no --porcelain)" ];
    then
        git -C "${BOOKS}bokeh-examples" pull
    else
        hass.log.warning "Not updating Bokeh examples notebook!"
        hass.log.warning "You have made local changes, which we will not overwrite."
    fi
fi
