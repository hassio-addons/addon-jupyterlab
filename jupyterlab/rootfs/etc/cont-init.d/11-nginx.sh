#!/usr/bin/with-contenv bashio
# ==============================================================================
# Home Assistant Community Add-on: JupyterLab Lite
# Configures NGINX for use with JupyterLab
# ==============================================================================
declare certfile
declare keyfile
declare hassio_dns

mkdir -p /var/log/nginx

if bashio::config.true 'ssl'; then
    rm /etc/nginx/nginx.conf
    mv /etc/nginx/nginx-ssl.conf /etc/nginx/nginx.conf

    certfile=$(bashio::config 'certfile')
    keyfile=$(bashio::config 'keyfile')

    sed -i "s#%%certfile%%#${certfile}#g" /etc/nginx/nginx.conf
    sed -i "s#%%keyfile%%#${keyfile}#g" /etc/nginx/nginx.conf
fi

hassio_dns=$(bashio::dns.host)
sed -i "s/%%hassio_dns%%/${hassio_dns}/g" /etc/nginx/nginx.conf
