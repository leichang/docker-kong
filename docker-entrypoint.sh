#!/usr/local/bin/dumb-init /bin/bash
set -e

# Disabling nginx daemon mode
export KONG_NGINX_DAEMON="off"

if [ -z "$DEVICE" ]; then
  DEVICE="eth2"
fi

IP_ADDR=`ifconfig "$DEVICE" | awk '$1 == "inet" {gsub(/\/.*$/, "", $2); print $2}'`
#IP_ADDR="0.0.0.0"
echo "SETTING IP_ADDR FOR KONG CLUSTERING TO: ${IP_ADDR}"

export KONG_CLUSTER_LISTEN="${IP_ADDR}:7946"
export KONG_SSL_CERT="/server.crt"
export KONG_SSL_CERT_KEY="/server.key"
export KONG_ADMIN_SSL_CERT="/server.crt"
export KONG_ADMIN_SSL_CERT_KEY="/server.key"

exec "$@"
